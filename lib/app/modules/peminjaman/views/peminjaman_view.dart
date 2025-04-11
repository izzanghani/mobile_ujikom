import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/peminjaman/controllers/peminjaman_controller.dart';
import 'package:sislab/app/data/peminjaman_response.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PeminjamanController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peminjaman'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.peminjamanList.isEmpty) {
          return const Center(child: Text('Tidak ada data peminjaman'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.peminjamanList.length,
          itemBuilder: (context, index) {
            final PeminjamanResponse pinjam = controller.peminjamanList[index];

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.assignment, color: Colors.orange),
                title: Text(
                  "Kegiatan: ${pinjam.jenisKegiatan ?? 'Tidak diketahui'}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanggal: ${pinjam.tanggalPeminjaman ?? '-'}"),
                    Text("Waktu: ${pinjam.waktuPeminjaman ?? '-'}"),
                    Text("ID Barang: ${pinjam.idBarang?.join(', ') ?? '-'}"),
                    Text("Jumlah: ${pinjam.jumlahPinjam?.join(', ') ?? '-'}"),
                  ],
                ),
                onTap: () {
                  Get.snackbar(
                    'Peminjaman',
                    'Anggota ID: ${pinjam.idAnggota}, Ruangan ID: ${pinjam.idRuangan}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
