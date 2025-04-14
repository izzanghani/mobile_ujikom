import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/modules/barang/views/AddEditBarangView.dart';
import 'package:sislab/app/modules/barang/views/BarangDetailView.dart';

class BarangView extends StatelessWidget {
  const BarangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarangController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Barang"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchBarang(); // Refresh daftar barang
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.barangList.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada data barang.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.barangList.length,
            itemBuilder: (context, index) {
              final data = controller.barangList[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 24,
                    child: const Icon(Icons.inventory, color: Colors.white, size: 30),
                  ),
                  title: Text(
                    data.namaBarang ?? 'Nama tidak tersedia',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "Merk: ${data.merk ?? '-'} | Jumlah: ${data.jumlah ?? 0}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.fillForm(data);
                        Get.to(() => AddBarangView(), arguments: {
                          'isEdit': true,
                          'barang': data,
                        });
                      } else if (value == 'detail') {
                        Get.to(() => BarangDetailView(), arguments: data);
                      } else if (value == 'delete') {
                        _showDeleteDialog(context, controller, data);
                      }
                    },
                    itemBuilder: (context) => [
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
                        value: 'detail',
                        child: Row(
                          children: [
                            Icon(Icons.visibility, color: Colors.blueAccent, size: 20),
                            SizedBox(width: 8),
                            Text("Detail"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_forever, color: Colors.red, size: 20),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.clearForm(); // Reset form sebelum tambah
          Get.to(() => AddBarangView());
        },
        child: const Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
        elevation: 8,
      ),
    );
  }

  // Dialog untuk konfirmasi penghapusan barang
  void _showDeleteDialog(BuildContext context, BarangController controller, data) {
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
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                const Text(
                  "Hapus Barang?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Yakin ingin menghapus data ini? Tindakan ini tidak bisa dibatalkan.",
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
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete_outline),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        controller.deleteBarang(data.id ?? 0);
                        Navigator.of(context).pop();
                      },
                      label: const Text("Hapus", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
