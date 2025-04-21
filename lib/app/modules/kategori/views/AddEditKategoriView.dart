import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/modules/kategori/controllers/kategori_controller.dart';

class AddEditKategoriView extends StatefulWidget {
  const AddEditKategoriView({super.key});

  @override
  State<AddEditKategoriView> createState() => _AddEditKategoriViewState();
}

class _AddEditKategoriViewState extends State<AddEditKategoriView> {
  final controller = Get.put(KategoriController());
  late bool isEdit;
  KategoriData? kategori;

  @override
  void initState() {
    super.initState();
    isEdit = Get.arguments?['isEdit'] ?? false;
    kategori = Get.arguments?['kategori'];

    if (isEdit && kategori != null) {
      controller.fillForm(kategori!);
    } else {
      controller.clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Kategori' : 'Tambah Kategori'),
        centerTitle: true,
        backgroundColor: isEdit ? Colors.orange.shade100 : Colors.green.shade100,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isEdit ? Colors.orange.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isEdit ? Icons.edit : Icons.category,
                      color: isEdit ? Colors.orange : Colors.green,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isEdit
                            ? "Ubah data kategori barang."
                            : "Masukkan data untuk menambahkan kategori baru.",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField(controller.namaKategoriController, 'Nama Kategori', Icons.label),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: controller.isLoading.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(
                    controller.isLoading.value
                        ? "Memproses..."
                        : isEdit
                            ? "Simpan Perubahan"
                            : "Tambah Kategori",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          // Handling save action
                          if (isEdit && kategori != null) {
                            await controller.updateKategori(kategori!.id);
                          } else {
                            await controller.tambahKategori();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEdit ? Colors.orange : Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }
}
