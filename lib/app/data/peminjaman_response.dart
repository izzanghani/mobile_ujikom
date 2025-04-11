class PeminjamanResponse {
  int? idAnggota;
  String? jenisKegiatan;
  int? idRuangan;
  String? tanggalPeminjaman;
  String? waktuPeminjaman;
  List<int>? idBarang;
  List<int>? jumlahPinjam;

  PeminjamanResponse({
    this.idAnggota,
    this.jenisKegiatan,
    this.idRuangan,
    this.tanggalPeminjaman,
    this.waktuPeminjaman,
    this.idBarang,
    this.jumlahPinjam,
  });

  PeminjamanResponse.fromJson(Map<String, dynamic> json) {
    idAnggota = json['id_anggota'];
    jenisKegiatan = json['jenis_kegiatan'];
    idRuangan = json['id_ruangan'];
    tanggalPeminjaman = json['tanggal_peminjaman'];
    waktuPeminjaman = json['waktu_peminjaman'];

    // ✅ Ambil dari peminjaman_details
    if (json['peminjaman_details'] != null) {
      List<dynamic> details = json['peminjaman_details'];
      idBarang = details.map<int>((item) => item['id_barang'] as int).toList();
      jumlahPinjam = details.map<int>((item) => item['jumlah_pinjam'] as int).toList();
    } else {
      idBarang = [];
      jumlahPinjam = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id_anggota'] = idAnggota;
    data['jenis_kegiatan'] = jenisKegiatan;
    data['id_ruangan'] = idRuangan;
    data['tanggal_peminjaman'] = tanggalPeminjaman;
    data['waktu_peminjaman'] = waktuPeminjaman;
    data['id_barang'] = idBarang;
    data['jumlah_pinjam'] = jumlahPinjam;
    return data;
  }
}
