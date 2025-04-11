import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/modules/peminjaman/controllers/peminjaman_controller.dart'; // ✅ Import controller peminjaman
import 'package:sislab/app/routes/app_pages.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final anggotaController = Get.put(AnggotaController());
    final barangController = Get.put(BarangController());
    final peminjamanController = Get.put(PeminjamanController()); // ✅ Tambah controller peminjaman

    return Scaffold(
      appBar: AppBar(
        title: const Text('SISLAB'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Future: search feature
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            double aspectRatio = constraints.maxWidth > 600 ? 1.2 : 1.5;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dasboard',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: aspectRatio,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      Obx(() => _buildStatCard(
                            'Anggota',
                            '${anggotaController.anggotaList.length}',
                            const Color.fromARGB(255, 49, 160, 250),
                            () => Get.toNamed(Routes.ANGGOTA),
                          )),
                      Obx(() => _buildStatCard(
                            'Barang',
                            '${barangController.barangList.length}',
                            Colors.green,
                            () => Get.toNamed(Routes.BARANG),
                          )),
                      Obx(() => _buildStatCard(
                            'Peminjaman',
                            '${peminjamanController.peminjamanList.length}',
                            Colors.orange,
                            () => Get.toNamed(Routes.PEMINJAMAN),
                          )),
                      _buildStatCard(
                        'Pengembalian',
                        '1',
                        Colors.red,
                        () {
                          // Future: navigasi ke halaman pengembalian
                          // Get.toNamed(Routes.PENGEMBALIAN);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                    color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
