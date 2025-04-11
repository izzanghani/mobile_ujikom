import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';
import 'package:sislab/app/data/barang_response.dart';

class BarangView extends GetView<BarangController> {
  const BarangView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BarangController()); // Register controller

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
        centerTitle: true,
      ),
      body: Obx(() {
        print("Isi barangList di View: ${controller.barangList}");

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.barangList.isEmpty) {
          return const Center(child: Text('Tidak ada data barang'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: controller.barangList.length,
          itemBuilder: (context, index) {
            final Data barang = controller.barangList[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.inventory, color: Colors.green),
                title: Text(barang.namaBarang ?? "Nama tidak tersedia"),
                subtitle: Text("Merk: ${barang.merk ?? '-'} | Jumlah: ${barang.jumlah ?? '-'}"),
                trailing: Text(barang.codeBarang ?? "-", style: const TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Get.snackbar('Barang Dipilih', barang.codeBarang ?? "Kode tidak tersedia");
                },
              ),
            );
          },
        );
      }),
    );
  }
}
