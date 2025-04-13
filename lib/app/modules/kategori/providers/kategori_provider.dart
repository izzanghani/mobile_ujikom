import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/utils/api.dart';

class KategoriProvider {
  // URL untuk API kategori
  final String baseUrl = BaseUrl.kategori; // Ganti dengan URL API yang benar

  // Mengambil data kategori
  Future<KategoriResponse> getKategori() async {
    final response = await http.get(
      Uri.parse('$baseUrl/getAll'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return KategoriResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load kategori');
    }
  }
}
