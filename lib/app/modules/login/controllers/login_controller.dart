import 'dart:convert'; // <- Wajib untuk jsonDecode

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:sislab/app/modules/dashboard/views/dashboard_view.dart';
import 'package:sislab/app/utils/api.dart';

class LoginController extends GetxController {
  final _getConnect = GetConnect();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final authStorage = GetStorage();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _getConnect.timeout = const Duration(seconds: 10);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void loginNow() async {
    isLoading.value = true;

    try {
      final response = await _getConnect.post(BaseUrl.login, {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });

      print("RAW LOGIN RESPONSE: ${response.bodyString}");

      isLoading.value = false;

      // Bersihkan karakter 'v' di awal jika ada
      final raw = response.bodyString ?? '';
      final clean = raw.startsWith('v') ? raw.substring(1) : raw;

      // Decode JSON manual karena response.body gagal diparse otomatis
      final Map<String, dynamic> decoded = jsonDecode(clean);
      final String token = decoded['access_token'];

      if (token.isNotEmpty) {
        authStorage.write('token', token);
        Get.offAll(() => const DashboardView());
      } else {
        Get.snackbar('Login Gagal', 'Token tidak ditemukan dalam respons.');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Gagal login: ${e.toString()}');
    }
  }

  String get token => "Bearer ${authStorage.read('token') ?? ''}";

  void logout() {
    authStorage.remove('token');
    Get.offAllNamed('/login');
  }
}
