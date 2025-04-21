class RuanganResponse {
  final bool success;
  final String message;
  final RuanganPagination data;

  RuanganResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RuanganResponse.fromJson(Map<String, dynamic> json) {
    return RuanganResponse(
      success: json['success'],
      message: json['message'],
      data: RuanganPagination.fromJson(json['data']),
    );
  }
}

class RuanganPagination {
  final int currentPage;
  final List<RuanganData> data;
  final int from;
  final int lastPage;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int perPage;
  final int to;
  final int total;

  RuanganPagination({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory RuanganPagination.fromJson(Map<String, dynamic> json) {
    return RuanganPagination(
      currentPage: json['current_page'],
      data: List<RuanganData>.from(json['data'].map((x) => RuanganData.fromJson(x))),
      from: json['from'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      perPage: int.tryParse(json['per_page'].toString()) ?? 10,
      to: json['to'],
      total: json['total'],
    );
  }
}

class RuanganData {
  final int id;
  final String namaRuangan;
  final String namaPic;
  final String posisiRuangan;
  final DateTime createdAt;
  final DateTime updatedAt;

  RuanganData({
    required this.id,
    required this.namaRuangan,
    required this.namaPic,
    required this.posisiRuangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RuanganData.fromJson(Map<String, dynamic> json) {
    return RuanganData(
      id: json['id'],
      namaRuangan: json['nama_ruangan'],
      namaPic: json['nama_pic'],
      posisiRuangan: json['posisi_ruangan'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
