class anggotaResponse {
  String? message;
  List<AnggotaData>? data;

  anggotaResponse({this.message, this.data});

  anggotaResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <AnggotaData>[];
      json['data'].forEach((v) {
        data!.add(new AnggotaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnggotaData {
  int? id;
  String? nim;
  String? namaPeminjam;
  String? email;
  String? noTelepon;
  String? instansiLembaga;
  String? createdAt;
  String? updatedAt;

  AnggotaData(
      {this.id,
      this.nim,
      this.namaPeminjam,
      this.email,
      this.noTelepon,
      this.instansiLembaga,
      this.createdAt,
      this.updatedAt});

  AnggotaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nim = json['nim'];
    namaPeminjam = json['nama_peminjam'];
    email = json['email'];
    noTelepon = json['no_telepon'];
    instansiLembaga = json['instansi_lembaga'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nim'] = this.nim;
    data['nama_peminjam'] = this.namaPeminjam;
    data['email'] = this.email;
    data['no_telepon'] = this.noTelepon;
    data['instansi_lembaga'] = this.instansiLembaga;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
