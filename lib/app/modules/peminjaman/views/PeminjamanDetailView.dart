import 'package:flutter/material.dart';
import 'package:sislab/app/data/peminjaman_response.dart';

class PeminjamanDetailView extends StatelessWidget {
  final PeminjamanResponse peminjaman;

  const PeminjamanDetailView({super.key, required this.peminjaman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Detail Peminjaman'),
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
              child: const Icon(Icons.assignment, size: 48, color: Colors.white),
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
                      "Informasi detail peminjaman termasuk ruangan dan barang.",
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
                  _buildDetailItem(Icons.person, "ID Anggota", peminjaman.idAnggota),
                  _buildDetailItem(Icons.event_note, "Jenis Kegiatan", peminjaman.jenisKegiatan),
                  _buildDetailItem(Icons.meeting_room_outlined, "ID Ruangan", peminjaman.idRuangan),
                  _buildDetailItem(Icons.calendar_today, "Tanggal Peminjaman", peminjaman.tanggalPeminjaman),
                  _buildDetailItem(Icons.access_time, "Waktu Peminjaman", peminjaman.waktuPeminjaman),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Detail Barang",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 12),
            if ((peminjaman.idBarang?.isNotEmpty ?? false) &&
                (peminjaman.jumlahPinjam?.isNotEmpty ?? false))
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: peminjaman.idBarang!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.inventory_2, color: Colors.teal),
                      title: Text("ID Barang: ${peminjaman.idBarang![index]}"),
                      subtitle: Text("Jumlah: ${peminjaman.jumlahPinjam![index]}"),
                    ),
                  );
                },
              )
            else
              const Text("Tidak ada data barang."),
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
