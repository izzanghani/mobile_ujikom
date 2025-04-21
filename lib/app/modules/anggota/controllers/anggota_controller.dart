import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/anggota_response.dart';
import 'package:sislab/app/utils/api.dart';

class AnggotaController extends GetxController {
  var anggotaList = <AnggotaData>[].obs;
  var isLoading = false.obs;
  final authStorage = GetStorage();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final teleponController = TextEditingController();
  final instansiController = TextEditingController();
  final nimController = TextEditingController();  // Controller untuk NIM

  Rx<AnggotaData?> selectedAnggota = Rx<AnggotaData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAnggota();
  }

  void fetchAnggota() async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(BaseUrl.anggota),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = anggotaResponse.fromJson(data);
        anggotaList.value = result.data ?? [];
      } else {
        Get.snackbar("Error", "Gagal memuat data anggota");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> tambahAnggota() async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(BaseUrl.anggota),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "nim": nimController.text,  // NIM diisi manual
          "nama_peminjam": namaController.text,
          "email": emailController.text,
          "no_telepon": teleponController.text,
          "instansi_lembaga": instansiController.text,
        }),
      );

      if (response.statusCode == 201) {
        fetchAnggota();
        clearForm();
        Get.snackbar("Sukses", "Anggota berhasil ditambahkan");
        Get.offNamed('/anggota');
      } else {
        Get.snackbar("Gagal", "Gagal menambahkan anggota: ${response.body}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAnggota(String id) async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse("${BaseUrl.anggota}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "nama_peminjam": namaController.text,
          "email": emailController.text,
          "no_telepon": teleponController.text,
          "instansi_lembaga": instansiController.text,
        }),
      );

      if (response.statusCode == 200) {
        fetchAnggota();
        clearForm();
        Get.snackbar("Sukses", "Anggota berhasil diperbarui");
        Get.offNamed('/anggota');
      } else {
        Get.snackbar("Gagal", "Gagal memperbarui anggota: ${response.body}");
      }
    } catch (e) {
      // Penanganan exception
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAnggota(String id) async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse("${BaseUrl.anggota}/$id"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        fetchAnggota();
        Get.snackbar("Sukses", "Data berhasil dihapus");
      } else {
        Get.snackbar("Error", "Gagal menghapus anggota");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    }
  }

  void clearForm() {
    nimController.clear();  // Clear NIM field
    namaController.clear();
    emailController.clear();
    teleponController.clear();
    instansiController.clear();
    selectedAnggota.value = null;
  }

  void fillForm(AnggotaData anggota) {
    selectedAnggota.value = anggota;
    nimController.text = anggota.nim ?? '';  // NIM diisi dari data anggota
    namaController.text = anggota.namaPeminjam ?? '';
    emailController.text = anggota.email ?? '';
    teleponController.text = anggota.noTelepon ?? '';
    instansiController.text = anggota.instansiLembaga ?? '';
  }

  void goToEditAnggota(AnggotaData anggota) {
    fillForm(anggota);
    Get.toNamed('/anggota/edit', arguments: anggota);
  }

  void goToDetailAnggota(AnggotaData anggota) {
    selectedAnggota.value = anggota;
    Get.toNamed('/anggota/detail', arguments: anggota);
  }
}
