class PeminjamanResponse {
  bool? success;
  List<DataPeminjaman>? data;

  PeminjamanResponse({this.success, this.data});

  PeminjamanResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataPeminjaman>[];
      json['data'].forEach((v) {
        data!.add(DataPeminjaman.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataPeminjaman {
  int? id;
  String? codePeminjaman;
  int? idAnggota;
  String? jenisKegiatan;
  int? idRuangan;
  String? tanggalPeminjaman;
  String? waktuPeminjaman;
  String? createdAt;
  String? updatedAt;
  dynamic anggota;
  Ruangan? ruangan;
  List<PeminjamanDetails>? peminjamanDetails;

  DataPeminjaman({
    this.id,
    this.codePeminjaman,
    this.idAnggota,
    this.jenisKegiatan,
    this.idRuangan,
    this.tanggalPeminjaman,
    this.waktuPeminjaman,
    this.createdAt,
    this.updatedAt,
    this.anggota,
    this.ruangan,
    this.peminjamanDetails,
  });

  DataPeminjaman.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codePeminjaman = json['code_peminjaman'];
    idAnggota = json['id_anggota'];
    jenisKegiatan = json['jenis_kegiatan'];
    idRuangan = json['id_ruangan'];
    tanggalPeminjaman = json['tanggal_peminjaman'];
    waktuPeminjaman = json['waktu_peminjaman'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    anggota = json['anggota']; // Could be another class or dynamic
    ruangan = json['ruangan'] != null ? Ruangan.fromJson(json['ruangan']) : null;
    if (json['peminjaman_details'] != null) {
      peminjamanDetails = [];
      json['peminjaman_details'].forEach((v) {
        peminjamanDetails!.add(PeminjamanDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['code_peminjaman'] = this.codePeminjaman;
    data['id_anggota'] = this.idAnggota;
    data['jenis_kegiatan'] = this.jenisKegiatan;
    data['id_ruangan'] = this.idRuangan;
    data['tanggal_peminjaman'] = this.tanggalPeminjaman;
    data['waktu_peminjaman'] = this.waktuPeminjaman;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['anggota'] = this.anggota;
    if (this.ruangan != null) {
      data['ruangan'] = this.ruangan!.toJson();
    }
    if (this.peminjamanDetails != null) {
      data['peminjaman_details'] = this.peminjamanDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ruangan {
  int? id;
  String? namaRuangan;
  String? namaPic;
  String? posisiRuangan;
  String? createdAt;
  String? updatedAt;

  Ruangan({
    this.id,
    this.namaRuangan,
    this.namaPic,
    this.posisiRuangan,
    this.createdAt,
    this.updatedAt,
  });

  Ruangan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaRuangan = json['nama_ruangan'];
    namaPic = json['nama_pic'];
    posisiRuangan = json['posisi_ruangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['nama_ruangan'] = this.namaRuangan;
    data['nama_pic'] = this.namaPic;
    data['posisi_ruangan'] = this.posisiRuangan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PeminjamanDetails {
  int? id;
  int? idPmBarang;
  int? idBarang;
  int? jumlahPinjam;
  String? createdAt;
  String? updatedAt;
  Barang? barang;

  PeminjamanDetails({
    this.id,
    this.idPmBarang,
    this.idBarang,
    this.jumlahPinjam,
    this.createdAt,
    this.updatedAt,
    this.barang,
  });

  PeminjamanDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPmBarang = json['id_pm_barang'];
    idBarang = json['id_barang'];
    jumlahPinjam = json['jumlah_pinjam'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    barang = json['barang'] != null ? Barang.fromJson(json['barang']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['id_pm_barang'] = this.idPmBarang;
    data['id_barang'] = this.idBarang;
    data['jumlah_pinjam'] = this.jumlahPinjam;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.barang != null) {
      data['barang'] = this.barang!.toJson();
    }
    return data;
  }
}

class Barang {
  int? id;
  String? codeBarang;
  String? namaBarang;
  String? merk;
  int? idKategori;
  String? detail;
  String? jumlah;
  String? createdAt;
  String? updatedAt;

  Barang({
    this.id,
    this.codeBarang,
    this.namaBarang,
    this.merk,
    this.idKategori,
    this.detail,
    this.jumlah,
    this.createdAt,
    this.updatedAt,
  });

  Barang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeBarang = json['code_barang'];
    namaBarang = json['nama_barang'];
    merk = json['merk'];
    idKategori = json['id_kategori'];
    detail = json['detail'];
    jumlah = json['jumlah'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['code_barang'] = this.codeBarang;
    data['nama_barang'] = this.namaBarang;
    data['merk'] = this.merk;
    data['id_kategori'] = this.idKategori;
    data['detail'] = this.detail;
    data['jumlah'] = this.jumlah;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
