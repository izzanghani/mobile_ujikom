import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/modules/barang/views/AddEditBarangView.dart';
import '../controllers/barang_controller.dart';

class BarangView extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  BarangView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Barang'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());  // Removed 'const'
        }

        if (controller.listBarang.isEmpty) {
          return Center(child: Text("Tidak ada data barang."));  // Removed 'const'
        }

        return ListView.builder(
          itemCount: controller.listBarang.length,
          itemBuilder: (context, index) {
            final barang = controller.listBarang[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(barang.namaBarang[0].toUpperCase()),
                ),
                title: Text(
                  barang.namaBarang,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Merk: ${barang.merk}'),
                    Text('Jumlah: ${barang.jumlah}'),
                  ],
                ),
                isThreeLine: true,
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      Get.to(() => AddEditBarangView(isEdit: true, id: barang.id));
                    } else if (value == 'delete') {
                      controller.hapusBarang(barang.id);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Hapus')),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddEditBarangView(isEdit: false)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
