import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/barang_response.dart';

class BarangDetailView extends StatelessWidget {
  final DataBarang barang = Get.arguments as DataBarang;

  BarangDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Detail Barang'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.blueAccent.withOpacity(0.8),
              child: const Icon(Icons.inventory_2_outlined, size: 48, color: Colors.white),
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
                      "Berikut adalah informasi lengkap dari barang yang terdaftar.",
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
                  _buildDetailItem(Icons.qr_code_2, "Kode Barang", barang.codeBarang),
                  _buildDetailItem(Icons.label_important_outline, "Nama Barang", barang.namaBarang),
                  _buildDetailItem(Icons.branding_watermark, "Merk", barang.merk),
                  _buildDetailItem(Icons.category_outlined, "ID Kategori", barang.idKategori?.toString()),
                  _buildDetailItem(Icons.description_outlined, "Detail", barang.detail),
                  _buildDetailItem(Icons.confirmation_number_outlined, "Jumlah", barang.jumlah),
                  _buildDetailItem(Icons.calendar_today_outlined, "Dibuat Pada", barang.createdAt),
                  _buildDetailItem(Icons.update, "Diperbarui Pada", barang.updatedAt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String? value) {
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
                  value ?? '-',
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
