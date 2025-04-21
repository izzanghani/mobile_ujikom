class BarangResponse {
  bool? success;
  String? message;
  List<DataBarang>? dataBarang;

  BarangResponse({this.success, this.message, this.dataBarang});

  BarangResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['dataBarang'] != null) {
      dataBarang = <DataBarang>[];
      json['dataBarang'].forEach((v) {
        dataBarang!.add(new DataBarang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dataBarang != null) {
      data['dataBarang'] = this.dataBarang!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataBarang {
  int? id;
  String? codeBarang;
  String? namaBarang;
  String? merk;
  int? idKategori;
  String? detail;
  String? jumlah;
  String? createdAt;
  String? updatedAt;
  Kategori? kategori;

  DataBarang(
      {this.id,
      this.codeBarang,
      this.namaBarang,
      this.merk,
      this.idKategori,
      this.detail,
      this.jumlah,
      this.createdAt,
      this.updatedAt,
      this.kategori});

  DataBarang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    codeBarang = json['code_barang'];
    namaBarang = json['nama_barang'];
    merk = json['merk'];
    idKategori = json['id_kategori'];
    detail = json['detail'];
    jumlah = json['jumlah'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kategori = json['kategori'] != null
        ? new Kategori.fromJson(json['kategori'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code_barang'] = this.codeBarang;
    data['nama_barang'] = this.namaBarang;
    data['merk'] = this.merk;
    data['id_kategori'] = this.idKategori;
    data['detail'] = this.detail;
    data['jumlah'] = this.jumlah;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.kategori != null) {
      data['kategori'] = this.kategori!.toJson();
    }
    return data;
  }
}

class Kategori {
  int? id;
  String? namaKategori;
  String? createdAt;
  String? updatedAt;

  Kategori({this.id, this.namaKategori, this.createdAt, this.updatedAt});

  Kategori.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKategori = json['nama_kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kategori'] = this.namaKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}