import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';
import 'package:sislab/app/data/anggota_response.dart';

class AnggotaView extends GetView<AnggotaController> {
  const AnggotaView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnggotaController()); // Register controller

 return Scaffold(
  appBar: AppBar(
    title: const Text('Daftar Anggota'),
    centerTitle: true,
  ),
  body: Obx(() {
    // ✅ Debugging: Cek isi anggotaList
    print("Isi anggotaList di View: ${controller.anggotaList}");

    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.anggotaList.isEmpty) {
      return const Center(child: Text('Tidak ada data anggota'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: controller.anggotaList.length,
      itemBuilder: (context, index) {
        final Data anggota = controller.anggotaList[index];
        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: Text(anggota.namaPeminjam ?? "Nama tidak tersedia"),
            subtitle: Text(anggota.instansiLembaga ?? "Instansi tidak tersedia"),
            onTap: () {
              Get.snackbar('Anggota Dipilih', anggota.codeAnggota ?? "Kode tidak tersedia");
            },
          ),
        );
      },
    );
  }),
);
}
}
