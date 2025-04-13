class BarangResponse {
  bool? success;
  String? message;
  List<DataBarang>? data;

  BarangResponse({this.success, this.message, this.data});

  BarangResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataBarang>[];
      json['data'].forEach((v) {
        data!.add(DataBarang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

  DataBarang({
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
