import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/common_widgets.dart';
import '../map/map_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/attendance_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceProvider>().loadDashboardData();
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  Future<void> _handleCheckIn() async {
    final confirmed = await _showConfirmDialog(
      'Absen Masuk',
      'Apakah Anda yakin ingin melakukan absen masuk sekarang?',
      Icons.login,
      AppTheme.successColor,
    );
    if (!confirmed || !mounted) return;

    final attendanceProvider = context.read<AttendanceProvider>();
    final success = await attendanceProvider.checkIn();

    if (!mounted) return;
    _showResultSnackbar(
      success,
      'Absen masuk berhasil! ✅',
      attendanceProvider.errorMessage ?? 'Absen masuk gagal',
    );
  }

  Future<void> _handleCheckOut() async {
    final confirmed = await _showConfirmDialog(
      'Absen Pulang',
      'Apakah Anda yakin ingin melakukan absen pulang sekarang?',
      Icons.logout,
      AppTheme.warningColor,
    );
    if (!confirmed || !mounted) return;

    final attendanceProvider = context.read<AttendanceProvider>();
    final success = await attendanceProvider.checkOut();

    if (!mounted) return;
    _showResultSnackbar(
      success,
      'Absen pulang berhasil! ✅',
      attendanceProvider.errorMessage ?? 'Absen pulang gagal',
    );
  }

  Future<bool> _showConfirmDialog(
    String title,
    String message,
    IconData icon,
    Color color,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: ElevatedButton.styleFrom(backgroundColor: color),
                child: const Text('Ya, Lanjutkan'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showResultSnackbar(bool success, String successMsg, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? successMsg : errorMsg),
        backgroundColor:
            success ? AppTheme.successColor : AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final attendanceProvider = context.watch<AttendanceProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final user = authProvider.user;
    final todayAbsen = attendanceProvider.todayAbsen;
    final statistic = attendanceProvider.statistic;

    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(now);
    final timeStr = DateFormat('HH:mm').format(now);

    return LoadingOverlay(
      isLoading: attendanceProvider.isLoading,
      message: attendanceProvider.loadingLocation
          ? 'Mendapatkan lokasi GPS...'
          : 'Memproses absensi...',
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => attendanceProvider.loadDashboardData(),
          child: CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppTheme.primaryColor, Color(0xFF1565C0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_getGreeting()},',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.85),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      user?.name ?? 'Pengguna',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Dark Mode Toggle
                                    GestureDetector(
                                      onTap: () =>
                                          themeProvider.toggleTheme(),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          themeProvider.isDark
                                              ? Icons.light_mode
                                              : Icons.dark_mode,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.25),
                                      child: Text(
                                        user?.name.isNotEmpty == true
                                            ? user!.name[0].toUpperCase()
                                            : 'U',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Date & Time
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.white, size: 14),
                                  const SizedBox(width: 8),
                                  Text(
                                    dateStr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Icon(Icons.access_time,
                                      color: Colors.white, size: 14),
                                  const SizedBox(width: 4),
                                  Text(
                                    timeStr,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Today's Attendance Card ────────────────────
                      _TodayAbsenCard(todayAbsen: todayAbsen),
                      const SizedBox(height: 16),

                      // ── Check In / Check Out Buttons ──────────────
                      _AttendanceButtons(
                        todayAbsen: todayAbsen,
                        onCheckIn: _handleCheckIn,
                        onCheckOut: _handleCheckOut,
                        isLoading: attendanceProvider.isLoading,
                      ),
                      const SizedBox(height: 20),

                      // ── Location Map Shortcut ─────────────────────
                      if (attendanceProvider.currentPosition != null ||
                          (todayAbsen?.latitudeMasuk != null))
                        _MapPreviewButton(todayAbsen: todayAbsen),

                      if (attendanceProvider.currentPosition != null ||
                          (todayAbsen?.latitudeMasuk != null))
                        const SizedBox(height: 20),

                      // ── Statistics ────────────────────────────────
                      if (statistic != null) ...[
                        const SectionHeader(
                          title: 'Statistik Kehadiran',
                          subtitle: 'Rekap total absensi Anda',
                        ),
                        const SizedBox(height: 12),
                        _StatisticsGrid(statistic: statistic),
                        const SizedBox(height: 20),
                      ],

                      // ── Training Info ─────────────────────────────
                      if (user?.training != null)
                        _TrainingInfoCard(user: user!),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Today Attendance Card ─────────────────────────────────────────────────

class _TodayAbsenCard extends StatelessWidget {
  final AttendanceModel? todayAbsen;

  const _TodayAbsenCard({this.todayAbsen});

  @override
  Widget build(BuildContext context) {
    final hasMasuk =
        todayAbsen != null && todayAbsen!.sudahCheckIn;
    final hasKeluar =
        todayAbsen != null && todayAbsen!.sudahCheckOut;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.today,
                      color: AppTheme.primaryColor, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Absensi Hari Ini',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const Spacer(),
                StatusChip(
                  label: hasKeluar
                      ? 'Selesai'
                      : hasMasuk
                          ? 'Hadir'
                          : 'Belum Absen',
                  color: hasKeluar
                      ? AppTheme.successColor
                      : hasMasuk
                          ? AppTheme.primaryColor
                          : AppTheme.warningColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TimeInfo(
                    label: 'Jam Masuk',
                    time: hasMasuk ? todayAbsen!.jamMasuk! : '--:--',
                    icon: Icons.login,
                    color: AppTheme.successColor,
                    active: hasMasuk,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Expanded(
                  child: _TimeInfo(
                    label: 'Jam Keluar',
                    time: hasKeluar ? todayAbsen!.jamKeluar! : '--:--',
                    icon: Icons.logout,
                    color: AppTheme.warningColor,
                    active: hasKeluar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeInfo extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;
  final Color color;
  final bool active;

  const _TimeInfo({
    required this.label,
    required this.time,
    required this.icon,
    required this.color,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon,
            color: active ? color : Colors.grey.shade400, size: 22),
        const SizedBox(height: 6),
        Text(
          time,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: active
                ? color
                : Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

// ── Attendance Buttons ────────────────────────────────────────────────────

class _AttendanceButtons extends StatelessWidget {
  final AttendanceModel? todayAbsen;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;
  final bool isLoading;

  const _AttendanceButtons({
    this.todayAbsen,
    required this.onCheckIn,
    required this.onCheckOut,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final hasMasuk = todayAbsen != null && todayAbsen!.sudahCheckIn;
    final hasKeluar = todayAbsen != null && todayAbsen!.sudahCheckOut;

    return Row(
      children: [
        Expanded(
          child: _AbsenButton(
            label: 'Absen Masuk',
            icon: Icons.login_rounded,
            color: AppTheme.successColor,
            onTap: (!hasMasuk && !isLoading) ? onCheckIn : null,
            isActive: !hasMasuk,
            isDone: hasMasuk,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _AbsenButton(
            label: 'Absen Pulang',
            icon: Icons.logout_rounded,
            color: AppTheme.warningColor,
            onTap: (hasMasuk && !hasKeluar && !isLoading) ? onCheckOut : null,
            isActive: hasMasuk && !hasKeluar,
            isDone: hasKeluar,
          ),
        ),
      ],
    );
  }
}

class _AbsenButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isDone;

  const _AbsenButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
    required this.isActive,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 90,
        decoration: BoxDecoration(
          gradient: isActive
              ? LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isActive ? null : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
          border: !isActive
              ? Border.all(color: Colors.grey.withOpacity(0.2))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDone ? Icons.check_circle : icon,
              color: isActive ? Colors.white : Colors.grey,
              size: 28,
            ),
            const SizedBox(height: 6),
            Text(
              isDone ? 'Selesai' : label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Map Preview Button ────────────────────────────────────────────────────

class _MapPreviewButton extends StatelessWidget {
  final AttendanceModel? todayAbsen;

  const _MapPreviewButton({this.todayAbsen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (todayAbsen?.latitudeMasuk != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MapScreen(
                latitude: todayAbsen!.latitudeMasuk!,
                longitude: todayAbsen!.longitudeMasuk!,
                title: 'Lokasi Absen Masuk',
              ),
            ),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.map_outlined,
                    color: AppTheme.accentColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lihat Lokasi Absen',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    if (todayAbsen?.latitudeMasuk != null)
                      Text(
                        '${todayAbsen!.latitudeMasuk!.toStringAsFixed(5)}, '
                        '${todayAbsen!.longitudeMasuk!.toStringAsFixed(5)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.55),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Statistics Grid ───────────────────────────────────────────────────────

class _StatisticsGrid extends StatelessWidget {
  final StatisticModel statistic;

  const _StatisticsGrid({required this.statistic});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.7,
      children: [
        _StatCard(
          label: 'Hadir',
          value: statistic.totalHadir,
          icon: Icons.check_circle_outline,
          color: AppTheme.successColor,
        ),
        _StatCard(
          label: 'Alpha',
          value: statistic.totalAlpha,
          icon: Icons.cancel_outlined,
          color: AppTheme.errorColor,
        ),
        _StatCard(
          label: 'Izin',
          value: statistic.totalIzin,
          icon: Icons.assignment_outlined,
          color: AppTheme.primaryColor,
        ),
        _StatCard(
          label: 'Sakit',
          value: statistic.totalSakit,
          icon: Icons.local_hospital_outlined,
          color: AppTheme.warningColor,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Training Info Card ────────────────────────────────────────────────────

class _TrainingInfoCard extends StatelessWidget {
  final dynamic user;

  const _TrainingInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.school_outlined,
                  color: AppTheme.primaryColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Program Training',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    user.training?.namaTraining ?? '-',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ),
            StatusChip(
              label: 'Batch ${user.batch ?? "-"}',
              color: AppTheme.accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
