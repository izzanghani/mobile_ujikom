import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anggota_controller.dart';

class AnggotaView extends GetView<AnggotaController> {
  const AnggotaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anggota'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.AnggotaList.isEmpty) {
          return const Center(child: Text("Tidak ada data anggota"));
        }

        return ListView.builder(
          itemCount: controller.AnggotaList.length,
          itemBuilder: (context, index) {
            var anggota = controller.AnggotaList[index];
            return ListTile(
              title: Text(anggota.namaPeminjam ?? "Nama tidak tersedia"),
              subtitle: Text(anggota.email ?? "Email tidak tersedia"),
            );
          },
        );
      }),
    );
  }
}
