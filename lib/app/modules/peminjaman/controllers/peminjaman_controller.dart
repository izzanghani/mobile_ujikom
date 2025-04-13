import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/peminjaman_response.dart';
import 'package:sislab/app/utils/api.dart';

class PeminjamanController extends GetxController {
  var peminjamanList = <PeminjamanResponse>[].obs;
  var isLoading = false.obs;

  final authStorage = GetStorage();

  @override
  void onInit() {
    fetchPeminjaman();
    super.onInit();
  }

  Future<void> fetchPeminjaman() async {
    final token = authStorage.read('token');
    if (token == null || token == '') {
      Get.snackbar("Error", "Token tidak ditemukan. Silakan login ulang.");
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(BaseUrl.peminjaman),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['data'] ?? [];

        peminjamanList.value = list.map((e) => PeminjamanResponse.fromJson(e)).toList();
      } else {
        Get.snackbar("Gagal", "Gagal memuat data peminjaman");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPeminjaman(PeminjamanResponse data) async {
    final token = authStorage.read('token');

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(BaseUrl.peminjaman),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id_anggota": data.idAnggota,
          "jenis_kegiatan": data.jenisKegiatan,
          "id_ruangan": data.idRuangan,
          "tanggal_peminjaman": data.tanggalPeminjaman,
          "waktu_peminjaman": data.waktuPeminjaman,
          "id_barang": data.idBarang,
          "jumlah_pinjam": data.jumlahPinjam,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        fetchPeminjaman();
        Get.snackbar("Sukses", "Peminjaman berhasil ditambahkan");
      } else {
        final err = json.decode(response.body);
        Get.snackbar("Gagal", err['message'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePeminjaman(int id, PeminjamanResponse data) async {
    final token = authStorage.read('token');

    try {
      isLoading.value = true;

      final response = await http.put(
        Uri.parse("${BaseUrl.peminjaman}/$id"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id_anggota": data.idAnggota,
          "jenis_kegiatan": data.jenisKegiatan,
          "id_ruangan": data.idRuangan,
          "tanggal_peminjaman": data.tanggalPeminjaman,
          "waktu_peminjaman": data.waktuPeminjaman,
          "id_barang": data.idBarang,
          "jumlah_pinjam": data.jumlahPinjam,
        }),
      );

      if (response.statusCode == 200) {
        Get.back();
        fetchPeminjaman();
        Get.snackbar("Sukses", "Peminjaman berhasil diperbarui");
      } else {
        final err = json.decode(response.body);
        Get.snackbar("Gagal", err['message'] ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePeminjaman(int id) async {
    final token = authStorage.read('token');

    try {
      isLoading.value = true;

      final response = await http.delete(
        Uri.parse("${BaseUrl.peminjaman}/$id"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        fetchPeminjaman();
        Get.snackbar("Sukses", "Data peminjaman berhasil dihapus");
      } else {
        final err = json.decode(response.body);
        Get.snackbar("Gagal", err['message'] ?? 'Terjadi kesalahan saat menghapus');
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showDetail(PeminjamanResponse data) {
    Get.toNamed('/peminjaman-detail', arguments: data);
  }
}
