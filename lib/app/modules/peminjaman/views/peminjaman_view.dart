import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/peminjaman_response.dart';
import 'package:sislab/app/modules/peminjaman/controllers/peminjaman_controller.dart';
import 'package:sislab/app/modules/peminjaman/views/AddEditPeminjamanView.dart';
import 'package:sislab/app/modules/peminjaman/views/PeminjamanDetailView.dart';

class PeminjamanView extends StatelessWidget {
  const PeminjamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PeminjamanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Peminjaman'),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: const Color(0xFFF1FDFB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.peminjamanList.isEmpty) {
          return const Center(
            child: Text(
              'Belum ada data peminjaman.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.peminjamanList.length,
          itemBuilder: (context, index) {
            final item = controller.peminjamanList[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: const Icon(Icons.assignment_rounded,
                    color: Colors.teal, size: 32),
                title: Text(
                  item.jenisKegiatan ?? "Tanpa Judul",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📅 ${item.tanggalPeminjaman ?? '-'}"),
                    Text("⏰ ${item.waktuPeminjaman ?? '-'}"),
                  ],
                ),
                trailing: PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onSelected: (value) {
                    if (value == 'detail') {
                      Get.to(() => PeminjamanDetailView(peminjaman: item));
                    } else if (value == 'edit') {
                      Get.to(() =>
                          AddEditPeminjamanView(isEdit: true, data: item));
                    } else if (value == 'delete') {
                      Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          title: Row(
                            children: const [
                              Icon(Icons.warning_amber_rounded,
                                  color: Colors.red, size: 28),
                              SizedBox(width: 8),
                              Text("Konfirmasi Hapus"),
                            ],
                          ),
                          content: Text(
                            "Apakah kamu yakin ingin menghapus peminjaman '${item.jenisKegiatan}'?",
                            style: const TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton.icon(
                              icon:
                                  const Icon(Icons.cancel, color: Colors.grey),
                              label: const Text("Batal",
                                  style: TextStyle(color: Colors.grey)),
                              onPressed: () => Get.back(),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.white),
                              label: const Text("Hapus"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                controller.deletePeminjaman(
                                    item.idAnggota ?? 0);
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'detail',
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.blue, size: 20),
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
                          Icon(Icons.delete_forever,
                              color: Colors.red, size: 20),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddEditPeminjamanView(isEdit: false));
        },
        label: const Text("Tambah"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
