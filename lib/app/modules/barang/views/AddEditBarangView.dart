import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/barang_response.dart';
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/modules/barang/controllers/barang_controller.dart';

class AddBarangView extends StatelessWidget {
  final bool isEdit;
  final DataBarang? barang;
  final controller = Get.put(BarangController());

  AddBarangView({super.key})
      : isEdit = Get.arguments?['isEdit'] ?? false,
        barang = Get.arguments?['barang'] {
    // Perbaikan inisialisasi form hanya sekali menggunakan Future.microtask
    Future.microtask(() {
      if (isEdit && barang != null) {
        controller.fillForm(barang!);
      } else {
        controller.clearForm();
        controller.codeController.text = controller.generateKodeBarang();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Barang' : 'Tambah Barang'),
        centerTitle: true,
        backgroundColor: isEdit ? Colors.orange.shade100 : Colors.blue.shade100,
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
                  color: isEdit ? Colors.orange.shade50 : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isEdit ? Icons.edit : Icons.inventory_2,
                      color: isEdit ? Colors.orange : Colors.blueAccent,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isEdit
                            ? "Ubah data barang yang sudah ada."
                            : "Masukkan data untuk menambahkan barang baru.",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField(controller.codeController, 'Kode Barang', Icons.code, readOnly: true),
              const SizedBox(height: 12),
              _buildTextField(controller.namaController, 'Nama Barang', Icons.label),
              const SizedBox(height: 12),
              _buildTextField(controller.merkController, 'Merk Barang', Icons.branding_watermark),
              const SizedBox(height: 12),
              _buildDropdownKategori(),
              const SizedBox(height: 12),
              _buildTextField(controller.detailController, 'Detail Barang', Icons.description),
              const SizedBox(height: 12),
              _buildTextField(
                controller.jumlahController,
                'Jumlah Barang',
                Icons.confirmation_num,
                keyboardType: TextInputType.number,
              ),
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
                            : "Tambah Barang",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (isEdit && barang != null) {
                            controller.updateBarang(barang!.id!);
                          } else {
                            controller.tambahBarang();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEdit ? Colors.orange : Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
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
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownKategori() {
    return Obx(() {
      return DropdownButtonFormField<KategoriData>(
        value: controller.selectedKategori.value,
        onChanged: (kategori) {
          controller.selectedKategori.value = kategori;
        },
        items: controller.kategoriList.map((kategori) {
          return DropdownMenuItem<KategoriData>( 
            value: kategori,
            child: Text(kategori.namaKategori ?? '-'),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: 'Kategori Barang',
          prefixIcon: const Icon(Icons.category, color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      );
    });
  }
}
