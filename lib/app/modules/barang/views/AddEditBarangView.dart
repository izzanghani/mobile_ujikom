import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/barang_controller.dart';

class AddEditBarangView extends StatelessWidget {
  final bool isEdit;
  final int? id;

  AddEditBarangView({this.isEdit = false, this.id});

  final controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Barang" : "Tambah Barang")),
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextField(
                      controller: controller.namaController,
                      decoration: InputDecoration(labelText: 'Nama Barang'),
                    ),
                    TextField(
                      controller: controller.merkController,
                      decoration: InputDecoration(labelText: 'Merk'),
                    ),
                    DropdownButtonFormField(
                      value: controller.selectedKategori,
                      items: controller.listKategori.map((kategori) {
                        return DropdownMenuItem(
                          value: kategori['id'],
                          child: Text(kategori['nama_kategori']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedKategori = value as int?;
                      },
                      decoration: InputDecoration(labelText: 'Kategori'),
                    ),
                    TextField(
                      controller: controller.detailController,
                      decoration: InputDecoration(labelText: 'Detail'),
                    ),
                    TextField(
                      controller: controller.jumlahController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Jumlah'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (isEdit && id != null) {
                          controller.editBarang(id!, () => Get.back());
                        } else {
                          controller.tambahBarang(() => Get.back());
                        }
                      },
                      child: Text(isEdit ? 'Update' : 'Simpan'),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
