import 'dart:async';

import 'package:flutter/material.dart';

import '../models/issue.dart';
import '../theme/app_colors.dart';
import '../widgets/dashboard_widgets.dart';
import 'create_report_page.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.userName});

  final String userName;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  late DateTime _now;
  Timer? _clockTimer;
  final List<Issue> _issues = [
    Issue(
      title: 'Jalan berlubang',
      category: 'Jalan',
      location: 'Jl. Merdeka, Kecamatan Pusat',
      description: 'Lubang cukup besar dan membahayakan pengendara.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Issue(
      title: 'Lampu jalan mati',
      category: 'Penerangan',
      location: 'Jl. Diponegoro, Kecamatan Utara',
      description: 'Lampu jalan tidak menyala sejak beberapa hari.',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Issue(
      title: 'Sampah menumpuk',
      category: 'Kebersihan',
      location: 'Pasar Baru, Kecamatan Pusat',
      description: 'Sampah belum diangkut dan mulai mengganggu.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Issue(
      title: 'Drainase tersumbat',
      category: 'Drainase',
      location: 'Jl. Kenanga, Kecamatan Selatan',
      description: 'Saluran air tersumbat oleh sampah.',
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    Issue(
      title: 'Trotoar rusak',
      category: 'Fasilitas umum',
      location: 'Jl. Sudirman, Kecamatan Pusat',
      description: 'Permukaan trotoar terangkat dan tidak rata.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Issue(
      title: 'Pohon tumbang',
      category: 'Lingkungan',
      location: 'Taman Kota, Kecamatan Barat',
      description: 'Dahan pohon menghalangi sebagian jalan.',
      date: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
    ),
    Issue(
      title: 'Rambu lalu lintas rusak',
      category: 'Lalu lintas',
      location: 'Simpang Lima, Kecamatan Timur',
      description: 'Rambu lalu lintas miring dan sulit terlihat.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Issue(
      title: 'Kebocoran pipa air',
      category: 'Air bersih',
      location: 'Jl. Melati, Kecamatan Selatan',
      description: 'Air terus mengalir dari pipa di tepi jalan.',
      date: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
    ),
    Issue(
      title: 'Jembatan perlu diperbaiki',
      category: 'Infrastruktur',
      location: 'Kampung Baru, Kecamatan Utara',
      description: 'Pagar pengaman jembatan mulai rapuh.',
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Issue(
      title: 'Genangan air',
      category: 'Drainase',
      location: 'Jl. Anggrek, Kecamatan Barat',
      description: 'Genangan muncul setiap kali hujan turun.',
      date: DateTime.now().subtract(const Duration(days: 4, hours: 6)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _clockTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  void _addIssue(Issue issue) {
    setState(() => _issues.insert(0, issue));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Laporan berhasil ditambahkan.')),
    );
  }

  void _openCreateIssue() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CreateReportPage(onSubmit: _addIssue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHome(),
      _buildReportList(title: 'Laporan Populer'),
      _buildReportList(title: 'Riwayat Laporan'),
      _buildProfile(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateIssue,
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: const Icon(Icons.camera_alt_rounded, size: 26),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        elevation: 10,
        child: SizedBox(
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavButton(
                icon: Icons.home_rounded,
                label: 'Beranda',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              NavButton(
                icon: Icons.campaign_outlined,
                label: 'Laporan',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              const SizedBox(width: 58),
              NavButton(
                icon: Icons.history_rounded,
                label: 'Riwayat',
                selected: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
              NavButton(
                icon: Icons.person_outline_rounded,
                label: 'Profil',
                selected: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHome() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: AppColors.paleBlue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.location_city_rounded,
                        color: AppColors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LaporKota',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Halo, ${widget.userName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF8591A3),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            const SnackBar(
                              content: Text('Belum ada notifikasi baru.'),
                            ),
                          ),
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.navy,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: const Size(44, 44),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(19),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF286FF8), Color(0xFF164BBE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.wb_sunny_rounded,
                            color: Color(0xFFFFD66B),
                            size: 20,
                          ),
                          const SizedBox(width: 7),
                          const Text(
                            'Kondisi kota hari ini',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(_now),
                            style: const TextStyle(
                              color: Color(0xFFDCE8FF),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: WeatherMetric(
                              icon: Icons.air_rounded,
                              title: 'Udara',
                              value: '42 AQI',
                              detail: 'Baik',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 46,
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                          Expanded(
                            child: WeatherMetric(
                              icon: Icons.cloud_rounded,
                              title: 'Cuaca',
                              value: '28Â°',
                              detail: 'Cerah berawan',
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 46,
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                          Expanded(
                            child: WeatherMetric(
                              icon: Icons.schedule_rounded,
                              title: 'Waktu',
                              value: _formatTime(_now),
                              detail: 'WIB',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Laporan populer',
                        style: TextStyle(
                          color: AppColors.navy,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _selectedIndex = 1),
                      child: const Text(
                        'Lihat semua',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Masalah yang paling sering dilaporkan warga',
                  style: TextStyle(color: Color(0xFF8A95A6), fontSize: 12),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          sliver: SliverList.separated(
            itemCount: _issues.length < 10 ? _issues.length : 10,
            separatorBuilder: (_, _) => const SizedBox(height: 9),
            itemBuilder: (context, index) => IssueTile(
              issue: _issues[index],
              number: index + 1,
              compact: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReportList({required String title}) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.background,
          surfaceTintColor: AppColors.background,
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.navy,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverList.separated(
            itemCount: _issues.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) =>
                IssueTile(issue: _issues[index], number: index + 1),
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      children: [
        const Text(
          'Profil',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 29,
                backgroundColor: AppColors.paleBlue,
                child: Text(
                  widget.userName.isEmpty
                      ? 'W'
                      : widget.userName[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Warga LaporKota',
                      style: TextStyle(color: Color(0xFF8792A3)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.verified_rounded, color: AppColors.blue),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.article_outlined, color: AppColors.blue),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Laporan Anda',
                  style: TextStyle(color: AppColors.navy, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                '${_issues.where((issue) => issue.status == 'Menunggu').length}',
                style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(builder: (_) => const LoginPage()),
            (_) => false,
          ),
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Keluar'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFD44D4D),
            padding: const EdgeInsets.symmetric(vertical: 15),
            side: const BorderSide(color: Color(0xFFEBDADA)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';
  }

  String _formatTime(DateTime date) =>
      '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
