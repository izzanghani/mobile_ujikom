import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sislab/app/data/anggota_response.dart';

class AnggotaDetailView extends StatelessWidget {
  final AnggotaData anggota = Get.arguments as AnggotaData;

  AnggotaDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Detail Anggota'),
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
              child: const Icon(Icons.person, size: 48, color: Colors.white),
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
                  Expanded(
                    child: Text(
                      "Berikut adalah informasi lengkap dari anggota terdaftar.",
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
                  _buildDetailItem(Icons.person_outline, "Nama", anggota.namaPeminjam),
                  _buildDetailItem(Icons.apartment_outlined, "Instansi", anggota.instansiLembaga),
                  _buildDetailItem(Icons.phone_android, "No. Telepon", anggota.noTelepon),
                  _buildDetailItem(Icons.email_outlined, "Email", anggota.email),
                  _buildDetailItem(Icons.qr_code_2_outlined, "NIM", anggota.nim), // Mengganti ke nim
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
