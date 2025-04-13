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
    _getConnect.timeout = const Duration(seconds: 10); // optional
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

      print("LOGIN RESPONSE: ${response.body}");

      isLoading.value = false;

      if (response.statusCode == 200 && response.body != null) {
        final token = response.body['access_token'];
        if (token != null && token != "") {
          authStorage.write('token', token);
          Get.offAll(() => const DashboardView());
        } else {
          Get.snackbar('Login Gagal', 'Token tidak ditemukan dalam respons.');
        }
      } else {
        final errorMessage = response.body?['message'] ??
            response.body?['error'] ??
            "Login gagal. Periksa email dan password.";

        Get.snackbar(
          'Login Gagal',
          errorMessage.toString(),
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
