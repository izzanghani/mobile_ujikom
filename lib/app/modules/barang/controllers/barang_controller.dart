import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/barang_response.dart';
import 'package:sislab/app/data/kategoriResponse.dart';
import 'package:sislab/app/utils/api.dart';

class BarangController extends GetxController {
  var barangList = <DataBarang>[].obs;
  var kategoriList = <KategoriData>[].obs;
  var isLoading = false.obs;

  final authStorage = GetStorage();

  // Controller untuk form
  final codeController = TextEditingController();
  final namaController = TextEditingController();
  final merkController = TextEditingController();
  final detailController = TextEditingController();
  final jumlahController = TextEditingController();

  Rx<KategoriData?> selectedKategori = Rx<KategoriData?>(null);
  Rx<DataBarang?> selectedBarang = Rx<DataBarang?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
    fetchKategori();
  }

  Future<void> fetchBarang() async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(BaseUrl.barang),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = BarangResponse.fromJson(data);
        barangList.value = result.dataBarang ?? [];
      } else {
        Get.snackbar("Error", "Gagal memuat data barang.");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchKategori() async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
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
        kategoriList.value = result.data ?? [];
      } else {
        Get.snackbar("Error", "Gagal memuat kategori.");
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat kategori: $e");
    }
  }

  Future<void> tambahBarang() async {
    final token = authStorage.read('token');
    if (token == null || selectedKategori.value == null) return;

    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(BaseUrl.barang),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "code_barang": codeController.text,
          "nama_barang": namaController.text,
          "merk": merkController.text,
          "id_kategori": selectedKategori.value!.id,
          "detail": detailController.text,
          "jumlah": int.tryParse(jumlahController.text) ?? 0,
        }),
      );

      if (response.statusCode == 201) {
        fetchBarang();
        clearForm();
        Get.back();
        Get.snackbar("Sukses", "Barang berhasil ditambahkan");
      } else {
        final error = json.decode(response.body);
        Get.snackbar("Gagal", error['message'] ?? "Gagal menambahkan barang");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateBarang(int id) async {
    final token = authStorage.read('token');
    if (token == null || selectedKategori.value == null) return;

    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse("${BaseUrl.barang}/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          "nama_barang": namaController.text,
          "merk": merkController.text,
          "id_kategori": selectedKategori.value!.id,
          "detail": detailController.text,
          "jumlah": int.tryParse(jumlahController.text) ?? 0,
        }),
      );

      if (response.statusCode == 200) {
        fetchBarang();
        clearForm();
        Get.back();
        Get.snackbar("Sukses", "Barang berhasil diperbarui");
      } else {
        final error = json.decode(response.body);
        Get.snackbar("Gagal", error['message'] ?? "Gagal memperbarui barang");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBarang(int id) async {
    final token = authStorage.read('token');
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse("${BaseUrl.barang}/$id"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        fetchBarang();
        Get.snackbar("Sukses", "Barang berhasil dihapus");
      } else {
        Get.snackbar("Error", "Gagal menghapus barang");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: ${e.toString()}");
    }
  }

  void clearForm() {
    codeController.clear();
    namaController.clear();
    merkController.clear();
    detailController.clear();
    jumlahController.clear();
    selectedKategori.value = null;
    selectedBarang.value = null;
  }

  void initAddForm() {
    clearForm();
    codeController.text = generateKodeBarang();
  }

  void fillForm(DataBarang barang) {
    selectedBarang.value = barang;
    codeController.text = barang.codeBarang ?? '';
    namaController.text = barang.namaBarang ?? '';
    merkController.text = barang.merk ?? '';
    detailController.text = barang.detail ?? '';
    jumlahController.text = barang.jumlah?.toString() ?? '';

    // Ambil ID kategori dari objek nested kategori
    if (barang.kategori != null) {
      selectedKategori.value = kategoriList.firstWhereOrNull(
        (kategori) => kategori.id == barang.kategori!.id,
      );
    } else {
      selectedKategori.value = null;
    }
  }

  String generateKodeBarang() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'BRG$timestamp';
  }
}
