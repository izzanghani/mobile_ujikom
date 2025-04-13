import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/barang_response.dart';
import 'package:sislab/app/modules/barang/views/AddEditBarangview.dart';
import 'package:sislab/app/utils/api.dart';

class BarangProvider {
  // URL untuk API barang
  final String baseUrl = BaseUrl.barang; // Ganti dengan URL API yang benar

  // Menambah barang
  Future<barangRespose> tambahBarang({
    required String namaBarang,
    required String merk,
    required int idKategori,
    required String detail,
    required String jumlah,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      body: json.encode({
        'nama_barang': namaBarang,
        'merk': merk,
        'id_kategori': idKategori,
        'detail': detail,
        'jumlah': jumlah,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return barangRespose.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add barang');
    }
  }

  // Mengambil data barang berdasarkan ID
  Future<DataBarang?> getBarangById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return DataBarang.fromJson(responseData);
    } else {
      throw Exception('Failed to load barang by ID');
    }
  }

  // Mengedit barang
  Future<barangRespose> editBarang({
    required int id,
    required String namaBarang,
    required String merk,
    required int idKategori,
    required String detail,
    required String jumlah,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update/$id'),
      body: json.encode({
        'nama_barang': namaBarang,
        'merk': merk,
        'id_kategori': idKategori,
        'detail': detail,
        'jumlah': jumlah,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return barangRespose.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update barang');
    }
  }

  // Menghapus barang
  Future<barangRespose> hapusBarang(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return barangRespose.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete barang');
    }
  }
}
