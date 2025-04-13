import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/barang_response.dart';
import 'package:sislab/app/utils/api.dart';

class BarangController extends GetxController {
  final box = GetStorage();

  var listBarang = <DataBarang>[].obs;
  var listKategori = [].obs;
  var isLoading = false.obs;

  final namaController = TextEditingController();
  final merkController = TextEditingController();
  final detailController = TextEditingController();
  final jumlahController = TextEditingController();

  int? selectedKategori;

  @override
  void onInit() {
    super.onInit();
    getBarang();
    getKategori();
  }

  void getBarang() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(BaseUrl.barang),
        headers: {
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = BarangResponse.fromJson(jsonDecode(response.body));
        listBarang.value = data.data;
      }
    } finally {
      isLoading(false);
    }
  }

  void getKategori() async {
    final response = await http.get(
      Uri.parse(BaseUrl.kategori),
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      listKategori.value = data['data'];
    }
  }

  void tambahBarang(Function onSuccess) async {
    final response = await http.post(
      Uri.parse(BaseUrl.barang),
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
        'Accept': 'application/json',
      },
      body: {
        'nama_barang': namaController.text,
        'merk': merkController.text,
        'id_kategori': selectedKategori.toString(),
        'detail': detailController.text,
        'jumlah': jumlahController.text,
      },
    );

    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      Get.snackbar("Berhasil", "Barang berhasil ditambahkan");
      onSuccess();
      getBarang();
    } else {
      Get.snackbar("Gagal tambah barang", data['errors'].toString());
    }
  }

  void editBarang(int id, Function onSuccess) async {
    final response = await http.post(
      Uri.parse('${BaseUrl.barang}/$id?_method=PUT'),
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
        'Accept': 'application/json',
      },
      body: {
        'nama_barang': namaController.text,
        'merk': merkController.text,
        'id_kategori': selectedKategori.toString(),
        'detail': detailController.text,
        'jumlah': jumlahController.text,
      },
    );

    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      Get.snackbar("Berhasil", "Barang berhasil diupdate");
      onSuccess();
      getBarang();
    } else {
      Get.snackbar("Gagal edit barang", data['errors'].toString());
    }
  }

  void hapusBarang(int id) async {
    final response = await http.delete(
      Uri.parse('${BaseUrl.barang}/$id'),
      headers: {
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    if (response.statusCode == 200) {
      Get.snackbar("Berhasil", "Barang berhasil dihapus");
      getBarang();
    } else {
      final error = jsonDecode(response.body);
      if (error['message'] != null &&
          error['message'].toString().contains('foreign key constraint')) {
        Get.snackbar("Gagal Hapus", "Barang sedang digunakan dan tidak bisa dihapus.");
      } else {
        Get.snackbar("Gagal Hapus", error['message'] ?? 'Terjadi kesalahan');
      }
    }
  }
}
