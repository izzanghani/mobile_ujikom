import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/modules/kategori/controllers/kategori_controller.dart';
import 'package:sislab/app/modules/kategori/views/AddEditKategoriView.dart';
import 'package:sislab/app/modules/kategori/views/KategoriDetailView.dart';

class KategoriView extends StatelessWidget {
  const KategoriView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KategoriController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Kategori"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchKategori(); // Memanggil fetchKategori() untuk mengambil data terbaru
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.kategoriList.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada data kategori.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.kategoriList.length,
            itemBuilder: (context, index) {
              final KategoriData data = controller.kategoriList[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 24,
                    child: Icon(Icons.category, color: Colors.white, size: 30),
                  ),
                  title: Text(
                    data.namaKategori ?? "Nama tidak tersedia",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "ID: ${data.id}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.goToEditKategori(data); // Mengisi form dengan data kategori yang dipilih
                        Get.to(() => AddEditKategoriView(), arguments: {
                          'isEdit': true, // Menandakan bahwa ini adalah halaman edit
                          'kategori': data, // Mengirimkan data kategori untuk diubah
                        });
                      } else if (value == 'detail') {
                        controller.selectedKategori.value = data; // Mengatur kategori yang dipilih untuk detail
                        Get.to(() => KategoriDetailView(), arguments: data); // Mengirimkan data kategori ke halaman detail
                      } else if (value == 'delete') {
                        _showDeleteDialog(context, controller, data); // Menampilkan dialog konfirmasi penghapusan
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'detail',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, color: Colors.teal, size: 20),
                            SizedBox(width: 8),
                            Text("Detail"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.orange, size: 20),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text("Hapus"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.clearForm(); // Membersihkan form sebelum menambah kategori baru
          Get.to(() => AddEditKategoriView(), arguments: {
            'isEdit': false, // Menandakan bahwa ini adalah untuk menambah kategori baru
          });
        },
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
        elevation: 8,
      ),
    );
  }

  // Dialog konfirmasi untuk menghapus kategori
  void _showDeleteDialog(BuildContext context, KategoriController controller, KategoriData data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                const Text(
                  "Hapus Kategori?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Yakin ingin menghapus kategori ini? Tindakan ini tidak bisa dibatalkan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Batal", style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        controller.deleteKategori(data.id!); // Menghapus kategori
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Hapus", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
