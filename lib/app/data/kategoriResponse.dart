class KategoriResponse {
  bool success;
  String message;
  List<KategoriData> data;

  KategoriResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory KategoriResponse.fromJson(Map<String, dynamic> json) {
    return KategoriResponse(
      success: json['success'],
      message: json['message'],
      data: List<KategoriData>.from(
        json['data'].map((x) => KategoriData.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class KategoriData {
  int id;
  String namaKategori;
  DateTime createdAt;
  DateTime updatedAt;

  KategoriData({
    required this.id,
    required this.namaKategori,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KategoriData.fromJson(Map<String, dynamic> json) {
    return KategoriData(
      id: json['id'],
      namaKategori: json['nama_kategori'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
