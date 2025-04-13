import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/anggota_response.dart';
import 'package:sislab/app/modules/anggota/controllers/anggota_controller.dart';

class AddAnggotaView extends StatelessWidget {
  final bool isEdit;
  final AnggotaData? anggota;

  AddAnggotaView({super.key})
      : isEdit = Get.arguments?['isEdit'] ?? false,
        anggota = Get.arguments?['anggota'];

  final controller = Get.put(AnggotaController());

  @override
  Widget build(BuildContext context) {
    if (isEdit && anggota != null) {
      controller.fillForm(anggota!);
    } else {
      controller.clearForm();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Anggota' : 'Tambah Anggota'),
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
                      isEdit ? Icons.edit : Icons.person_add,
                      color: isEdit ? Colors.orange : Colors.blueAccent,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isEdit
                            ? "Ubah data anggota yang sudah ada."
                            : "Masukkan data untuk menambahkan anggota baru.",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              _buildTextField(controller.namaController, 'Nama Peminjam', Icons.person),
              const SizedBox(height: 12),
              _buildTextField(controller.emailController, 'Email', Icons.email),
              const SizedBox(height: 12),
              _buildTextField(controller.teleponController, 'No. Telepon', Icons.phone),
              const SizedBox(height: 12),
              _buildTextField(controller.instansiController, 'Instansi/Lembaga', Icons.business),
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
                            : "Tambah Anggota",
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          if (isEdit && anggota != null) {
                            controller.updateAnggota(anggota!.id.toString());
                          } else {
                            final kode = controller.generateKodeAnggota();
                            controller.tambahAnggota(codeAnggota: kode);
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
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }
}
