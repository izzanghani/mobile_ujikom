import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/modules/kategori/controllers/kategori_controller.dart';

class KategoriDetailView extends StatelessWidget {
  final KategoriController controller = Get.find();

  KategoriDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final kategori = controller.selectedKategori.value;

      return Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          title: const Text('Detail Kategori'),
          centerTitle: true,
          backgroundColor: Colors.blue.shade100,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
        body: kategori == null
            ? const Center(child: Text("Data tidak tersedia"))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.blueAccent.withOpacity(0.8),
                      child: const Icon(Icons.category_outlined, size: 48, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.blueAccent, size: 30),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Berikut adalah informasi lengkap dari kategori barang.",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildDetailItem(Icons.label_important_outline, "Nama Kategori", kategori.namaKategori),
                          _buildDetailItem(Icons.calendar_today_outlined, "Dibuat Pada", DateFormat('yyyy-MM-dd').format(kategori.createdAt)),
                          _buildDetailItem(Icons.update, "Diperbarui Pada", DateFormat('yyyy-MM-dd').format(kategori.updatedAt)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
