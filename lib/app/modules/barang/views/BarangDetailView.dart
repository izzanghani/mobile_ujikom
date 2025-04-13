import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/barang_response.dart';

class BarangDetailView extends StatelessWidget {
  final DataBarang barang;

  const BarangDetailView({super.key, required this.barang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Detail Barang'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade100,
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
              backgroundColor: Colors.teal,
              child: const Icon(Icons.inventory_2, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.teal, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Informasi lengkap tentang barang yang dipilih.",
                      style: const TextStyle(fontSize: 14),
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
                  _buildDetailItem(Icons.qr_code_2_outlined, "Kode Barang", barang.codeBarang),
                  _buildDetailItem(Icons.label_important_outline, "Nama Barang", barang.namaBarang),
                  _buildDetailItem(Icons.precision_manufacturing_outlined, "Merk", barang.merk),
                  _buildDetailItem(Icons.confirmation_number_outlined, "Jumlah", barang.jumlah),
                  _buildDetailItem(Icons.description_outlined, "Detail", barang.detail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 4),
                Text(
                  value?.toString() ?? '-',
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
