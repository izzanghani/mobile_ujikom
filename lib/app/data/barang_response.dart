class BarangResponse {
  final bool success;
  final List<DataBarang> data;

  BarangResponse({required this.success, required this.data});

  factory BarangResponse.fromJson(Map<String, dynamic> json) {
    return BarangResponse(
      success: json['success'],
      data: List<DataBarang>.from(json['data'].map((x) => DataBarang.fromJson(x))),
    );
  }
}

class DataBarang {
  final int id;
  final String codeBarang;
  final String namaBarang;
  final String merk;
  final int idKategori;
  final String detail;
  final int jumlah;

  DataBarang({
    required this.id,
    required this.codeBarang,
    required this.namaBarang,
    required this.merk,
    required this.idKategori,
    required this.detail,
    required this.jumlah,
  });

  factory DataBarang.fromJson(Map<String, dynamic> json) {
    return DataBarang(
      id: json['id'],
      codeBarang: json['code_barang'],
      namaBarang: json['nama_barang'],
      merk: json['merk'],
      idKategori: json['id_kategori'],
      detail: json['detail'],
      jumlah: json['jumlah'],
    );
  }
}
