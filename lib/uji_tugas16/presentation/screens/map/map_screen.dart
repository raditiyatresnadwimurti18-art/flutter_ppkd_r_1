import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String title;
  final double? checkOutLat;
  final double? checkOutLng;

  const MapScreen({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.title,
    this.checkOutLat,
    this.checkOutLng,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setupMarkers();
  }

  void _setupMarkers() {
    _markers.add(
      Marker(
        markerId: const MarkerId('check_in'),
        position: LatLng(widget.latitude, widget.longitude),
        infoWindow: const InfoWindow(
          title: 'Lokasi Absen Masuk',
          snippet: 'Titik check-in Anda',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen),
      ),
    );

    if (widget.checkOutLat != null && widget.checkOutLng != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('check_out'),
          position: LatLng(widget.checkOutLat!, widget.checkOutLng!),
          infoWindow: const InfoWindow(
            title: 'Lokasi Absen Pulang',
            snippet: 'Titik check-out Anda',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange),
        ),
      );
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialPosition =
        CameraPosition(target: LatLng(widget.latitude, widget.longitude), zoom: 16);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              // Show info window for check-in marker after map loads
              Future.delayed(const Duration(milliseconds: 500), () {
                controller.showMarkerInfoWindow(
                    const MarkerId('check_in'));
              });
            },
            initialCameraPosition: initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
          ),

          // Legend
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Keterangan',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  _LegendItem(color: Colors.green, label: 'Absen Masuk'),
                  if (widget.checkOutLat != null)
                    _LegendItem(
                        color: Colors.orange, label: 'Absen Pulang'),
                ],
              ),
            ),
          ),

          // Coordinate info
          Positioned(
            bottom: 20,
            left: 12,
            right: 12,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: AppTheme.successColor),
                        const SizedBox(width: 8),
                        const Text('Masuk: ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        Text(
                          '${widget.latitude.toStringAsFixed(6)}, '
                          '${widget.longitude.toStringAsFixed(6)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    if (widget.checkOutLat != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: AppTheme.warningColor),
                          const SizedBox(width: 8),
                          const Text('Pulang: ',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          Text(
                            '${widget.checkOutLat!.toStringAsFixed(6)}, '
                            '${widget.checkOutLng!.toStringAsFixed(6)}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
