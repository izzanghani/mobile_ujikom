import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/modules/dashboard/views/profile_view.dart';
import 'package:sislab/app/routes/app_pages.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DashboardContent(),
    const Center(child: Text('Settings')),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2ecf5),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _fancyNavItem(Icons.dashboard_outlined, 'Dashboard', 0),
                  _fancyNavItem(Icons.settings_outlined, 'Settings', 1),
                  _fancyNavItem(Icons.person_outline, 'Profile', 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fancyNavItem(IconData icon, String label, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blueAccent.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.indigo : Colors.grey.shade600),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              child: isActive
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.indigo),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    final anggotaController = Get.put(AnggotaController());
    final barangController = Get.put(BarangController());
  
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dashboard', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade100,
                  child: Icon(Icons.admin_panel_settings_outlined, color: Colors.blueGrey.shade800),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Center(
              child: Lottie.asset(
                'assets/lottie/2.json',  // Menggunakan animasi Lottie
                height: 180,
              ),
            ),
            const SizedBox(height: 20),

            Obx(() {
              return GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                children: [
                  _buildCard('Anggota', anggotaController.anggotaList.length.toString(), LucideIcons.users, () => Get.toNamed(Routes.ANGGOTA)),
                  _buildCard('Barang', barangController.barangList.length.toString(), LucideIcons.box, () => Get.toNamed(Routes.BARANG)),
                  _buildCard('Kategori', '5', LucideIcons.grid, () => Get.toNamed(Routes.KATEGORI)), // Ganti Peminjaman menjadi Kategori
                  _buildCard('Pengembalian', '1', LucideIcons.refreshCw, () {}),
                ],
              );
            }),

            const SizedBox(height: 30),

            const Text('📈 Aktivitas Terbaru', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffdbe9ff), Color(0xfff0f4f8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('• 2 barang baru ditambahkan minggu ini', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('• 1 anggota baru terdaftar', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('• Peminjaman naik 25% dari minggu lalu', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCard(String title, String value, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28, color: Colors.indigo),
            const Spacer(),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
