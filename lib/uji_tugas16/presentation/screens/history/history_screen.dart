import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/attendance_provider.dart';
import '../../widgets/common_widgets.dart';
import '../map/map_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/attendance_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceProvider>().loadHistory();
    });
  }

  Future<void> _confirmDelete(BuildContext context, int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.delete_outline, color: AppTheme.errorColor),
            SizedBox(width: 10),
            Text('Hapus Absen',
                style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        content: const Text(
            'Yakin ingin menghapus data absensi ini? Tindakan tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final provider = context.read<AttendanceProvider>();
    final success = await provider.deleteAbsen(id);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Data absen berhasil dihapus'
              : provider.errorMessage ?? 'Gagal menghapus data',
        ),
        backgroundColor:
            success ? AppTheme.successColor : AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Absensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => provider.loadHistory(),
          ),
        ],
      ),
      body: _buildBody(context, provider),
    );
  }

  Widget _buildBody(BuildContext context, AttendanceProvider provider) {
    if (provider.status == AttendanceStatus.loading &&
        provider.history.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.status == AttendanceStatus.error &&
        provider.history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline,
                size: 56, color: AppTheme.errorColor),
            const SizedBox(height: 12),
            Text(
              provider.errorMessage ?? 'Terjadi kesalahan',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.errorColor),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Coba Lagi',
              onPressed: () => provider.loadHistory(),
              width: 160,
            ),
          ],
        ),
      );
    }

    if (provider.history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_outlined,
                size: 72, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'Belum ada riwayat absensi',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Data absensi Anda akan muncul di sini',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadHistory(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.history.length,
        itemBuilder: (context, index) {
          final absen = provider.history[index];
          return _HistoryCard(
            absen: absen,
            onDelete: absen.id != null
                ? () => _confirmDelete(context, absen.id!)
                : null,
          );
        },
      ),
    );
  }
}

// ── History Card ──────────────────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  final AttendanceModel absen;
  final VoidCallback? onDelete;

  const _HistoryCard({required this.absen, this.onDelete});

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(dt);
    } catch (_) {
      return dateStr;
    }
  }

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'hadir':
        return AppTheme.successColor;
      case 'alpha':
        return AppTheme.errorColor;
      case 'izin':
        return AppTheme.primaryColor;
      case 'sakit':
        return AppTheme.warningColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasLocation = absen.latitudeMasuk != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.event_note,
                      color: AppTheme.primaryColor, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _formatDate(absen.tanggal),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (absen.status != null)
                  StatusChip(
                    label: absen.status!,
                    color: _statusColor(absen.status),
                  ),
              ],
            ),

            const Divider(height: 16),

            // Time row
            Row(
              children: [
                Expanded(
                  child: _InfoRow(
                    icon: Icons.login,
                    iconColor: AppTheme.successColor,
                    label: 'Masuk',
                    value: absen.jamMasuk ?? '--:--',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _InfoRow(
                    icon: Icons.logout,
                    iconColor: AppTheme.warningColor,
                    label: 'Keluar',
                    value: absen.jamKeluar ?? '--:--',
                  ),
                ),
              ],
            ),

            // Location row
            if (hasLocation) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapScreen(
                        latitude: absen.latitudeMasuk!,
                        longitude: absen.longitudeMasuk!,
                        title: 'Lokasi Absen - ${absen.tanggal ?? ""}',
                        checkOutLat: absen.latitudeKeluar,
                        checkOutLng: absen.longitudeKeluar,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppTheme.accentColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: AppTheme.accentColor),
                      const SizedBox(width: 6),
                      Text(
                        '${absen.latitudeMasuk!.toStringAsFixed(5)}, '
                        '${absen.longitudeMasuk!.toStringAsFixed(5)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.open_in_new,
                          size: 12, color: AppTheme.accentColor),
                    ],
                  ),
                ),
              ),
            ],

            // Notes
            if (absen.keterangan != null &&
                absen.keterangan!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.notes, size: 14, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      absen.keterangan!,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],

            // Delete button
            if (onDelete != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline,
                      size: 16, color: AppTheme.errorColor),
                  label: const Text(
                    'Hapus',
                    style: TextStyle(
                        color: AppTheme.errorColor, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
