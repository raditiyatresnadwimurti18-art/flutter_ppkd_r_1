class AttendanceModel {
  final int? id;
  final int? userId;
  final String? tanggal;
  final String? jamMasuk;
  final String? jamKeluar;
  final double? latitudeMasuk;
  final double? longitudeMasuk;
  final double? latitudeKeluar;
  final double? longitudeKeluar;
  final String? status;
  final String? keterangan;

  AttendanceModel({
    this.id,
    this.userId,
    this.tanggal,
    this.jamMasuk,
    this.jamKeluar,
    this.latitudeMasuk,
    this.longitudeMasuk,
    this.latitudeKeluar,
    this.longitudeKeluar,
    this.status,
    this.keterangan,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      userId: json['user_id'],
      tanggal: json['tanggal'] ?? json['date'],
      jamMasuk: json['jam_masuk'] ??
          json['check_in'] ??
          json['waktu_masuk'],
      jamKeluar: json['jam_keluar'] ??
          json['check_out'] ??
          json['waktu_keluar'],
      latitudeMasuk: _parseDouble(json['latitude_masuk'] ?? json['lat_masuk']),
      longitudeMasuk:
          _parseDouble(json['longitude_masuk'] ?? json['long_masuk']),
      latitudeKeluar:
          _parseDouble(json['latitude_keluar'] ?? json['lat_keluar']),
      longitudeKeluar:
          _parseDouble(json['longitude_keluar'] ?? json['long_keluar']),
      status: json['status'],
      keterangan: json['keterangan'] ?? json['notes'],
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  bool get sudahCheckIn => jamMasuk != null && jamMasuk!.isNotEmpty;
  bool get sudahCheckOut => jamKeluar != null && jamKeluar!.isNotEmpty;
}

class StatisticModel {
  final int totalHadir;
  final int totalAlpha;
  final int totalIzin;
  final int totalSakit;

  StatisticModel({
    required this.totalHadir,
    required this.totalAlpha,
    required this.totalIzin,
    required this.totalSakit,
  });

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      totalHadir: _parseInt(json['total_hadir'] ?? json['hadir'] ?? 0),
      totalAlpha: _parseInt(json['total_alpha'] ?? json['alpha'] ?? 0),
      totalIzin: _parseInt(json['total_izin'] ?? json['izin'] ?? 0),
      totalSakit: _parseInt(json['total_sakit'] ?? json['sakit'] ?? 0),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
