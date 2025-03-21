import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/routes/app_pages.dart'; // Pastikan Anda mengimpor rute yang benar

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final AnggotaController anggotaController = Get.put(AnggotaController()); // Inisialisasi Controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Inventaris'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SISLAB',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                children: [
                  // ✅ Gunakan Obx untuk menampilkan jumlah anggota secara real-time
                  Obx(() => _buildStatCard(
                        'Anggota',
                        '${anggotaController.anggotaList.length}', // Menampilkan jumlah data anggota dari controller
                        Colors.blue,
                        () {
                          Get.toNamed(Routes.ANGGOTA);
                        },
                      )),
                  _buildStatCard('Barang', '200', Colors.green, () {
                    // Get.toNamed(Routes.BARANG);
                  }),
                  _buildStatCard('Peminjaman', '30', Colors.orange, () {
                    // Get.toNamed(Routes.PEMINJAMAN);
                  }),
                  _buildStatCard('Pengembalian', '25', Colors.red, () {
                    // Get.toNamed(Routes.PENGEMBALIAN);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
