import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/profile_response.dart';
import 'package:sislab/app/utils/api.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<User?>(null);
  final authStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    final token = authStorage.read('token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token tidak ditemukan. Silakan login ulang.');
      isLoading.value = false;
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("${BaseUrl.profile}"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final profileResponse = ProfileResponse.fromJson(data);
        user.value = profileResponse.user;
      } else {
        Get.snackbar('Error', 'Gagal memuat profil: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    authStorage.erase(); // hapus semua data token
    Get.offAllNamed('/login');
  }
}
