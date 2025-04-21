import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/utils/api.dart'; // URL API

class KategoriController extends GetxController {
  var kategoriList = <KategoriData>[].obs;
  var isLoading = false.obs;
  final authStorage = GetStorage();

  final namaKategoriController = TextEditingController();
  
  Rx<KategoriData?> selectedKategori = Rx<KategoriData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchKategori();
  }

  // Mengambil data kategori dari API
  void fetchKategori() async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(BaseUrl.kategori),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = KategoriResponse.fromJson(data);
        kategoriList.value = result.data;
      } else {
        Get.snackbar("Error", "Gagal memuat data kategori");
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Menambahkan kategori baru
  Future<void> tambahKategori() async {
    final token = authStorage.read('token');
    if (token == null) return;

    // Validasi input
    if (namaKategoriController.text.isEmpty) {
      Get.snackbar("Error", "Nama kategori tidak boleh kosong");
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(BaseUrl.kategori),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "nama_kategori": namaKategoriController.text,
        }),
      );

      if (response.statusCode == 201) {
        fetchKategori();
        clearForm();
        Get.snackbar("Sukses", "Kategori berhasil ditambahkan");
        Get.offNamed('/kategori');
      } else {
        Get.snackbar("Gagal", "Gagal menambahkan kategori: ${response.body}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Mengupdate kategori yang sudah ada
  Future<void> updateKategori(int id) async {
    final token = authStorage.read('token');
    if (token == null) return;

    // Validasi input
    if (namaKategoriController.text.isEmpty) {
      Get.snackbar("Error", "Nama kategori tidak boleh kosong");
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse("${BaseUrl.kategori}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "nama_kategori": namaKategoriController.text,
        }),
      );

      if (response.statusCode == 200) {
        fetchKategori();
        clearForm();
        Get.snackbar("Sukses", "Kategori berhasil diperbarui");
        Get.offNamed('/kategori');
      } else {
        Get.snackbar("Gagal", "Gagal memperbarui kategori: ${response.body}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Menghapus kategori
  Future<void> deleteKategori(int id) async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse("${BaseUrl.kategori}/$id"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        fetchKategori();
        Get.snackbar("Sukses", "Kategori berhasil dihapus");
      } else {
        Get.snackbar("Error", "Gagal menghapus kategori");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    }
  }

  // Mengosongkan form input
  void clearForm() {
    namaKategoriController.clear();
    selectedKategori.value = null;
  }

  // Mengisi form untuk edit kategori
  void fillForm(KategoriData kategori) {
    selectedKategori.value = kategori;
    namaKategoriController.text = kategori.namaKategori;
  }

  // Menavigasi ke halaman tambah kategori
  void goToAddKategori() {
    clearForm();
    Get.toNamed('/kategori/add', arguments: {'isEdit': false});
  }

  // Menavigasi ke halaman edit kategori
  void goToEditKategori(KategoriData kategori) {
    Get.toNamed('/kategori/edit', arguments: {'kategori': kategori});
    fillForm(kategori);
  }

  // Menavigasi ke halaman detail kategori
  void goToDetailKategori(KategoriData kategori) {
    selectedKategori.value = kategori;
    Get.toNamed('/kategori/detail', arguments: kategori);
  }
}
