import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/anggota_response.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/modules/anggota/views/AddAnggotaView.dart';
import 'package:sislab/app/modules/anggota/views/AnggotaDetailView.dart';

class AnggotaView extends StatelessWidget {
  const AnggotaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnggotaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Anggota"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchAnggota(); // Memanggil fetchAnggota() untuk mengambil data terbaru
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

          if (controller.anggotaList.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada data anggota.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.anggotaList.length,
            itemBuilder: (context, index) {
              final AnggotaData data = controller.anggotaList[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    radius: 24,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  title: Text(
                    data.namaPeminjam ?? "Nama tidak tersedia",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    data.instansiLembaga ?? "-",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.fillForm(data); // Mengisi form dengan data anggota yang dipilih
                        Get.to(() =>  AddAnggotaView(), arguments: {
                          'isEdit': true,
                          'anggota': data,
                        });
                      } else if (value == 'detail') {
                        controller.selectedAnggota.value = data; // Mengatur anggota yang dipilih untuk detail
                        Get.to(() => AnggotaDetailView(), arguments: data);
                      } else if (value == 'delete') {
                        _showDeleteDialog(context, controller, data);
                      }
                    },
                    itemBuilder: (context) => [
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
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_note_rounded, color: Colors.orange, size: 20),
                            SizedBox(width: 8),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_forever_rounded, color: Colors.red, size: 20),
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
          controller.clearForm(); // Membersihkan form sebelum menambah anggota baru
          Get.to(() =>  AddAnggotaView(), arguments: {
            'isEdit': false,
          });
        },
        label: const Text("Tambah"),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        backgroundColor: Colors.blueAccent,
        elevation: 8,
      ),
    );
  }

  // Dialog konfirmasi untuk menghapus anggota
  void _showDeleteDialog(BuildContext context, AnggotaController controller, AnggotaData data) {
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
                  "Hapus Anggota?",
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
                        controller.deleteAnggota(data.id.toString()); // Menghapus anggota
                        Navigator.of(context).pop();
                      },
                      label: const Text("Hapus", style: TextStyle(fontSize: 16)),
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
