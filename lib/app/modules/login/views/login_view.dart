import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final blueTheme = HexColor('#007AFF');

    return Scaffold(
      body: Stack(
        children: [
          /// 🌊 Wave Background - Fullscreen & Soft Waves
          Positioned.fill(
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [Colors.blue.shade200, Colors.blue.shade50],
                  [Colors.indigo.shade200, Colors.indigo.shade50],
                ],
                durations: [18000, 22000],
                heightPercentages: [0.08, 0.10], // Rendah agar tidak mengganggu UI
                blur: const MaskFilter.blur(BlurStyle.normal, 5),
                gradientBegin: Alignment.topLeft,
                gradientEnd: Alignment.bottomRight,
              ),
              waveAmplitude: 0,
              backgroundColor: Colors.white,
              size: const Size(double.infinity, double.infinity),
            ),
          ),

          /// 🔐 Login Form
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/1.json',
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Selamat Datang!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Silakan login ke akun Anda',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 32),

                  /// Email Input
                  TextField(
                    controller: controller.emailController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      hintText: 'Masukkan Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// Password Input
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey.shade800),
                      hintText: 'Masukkan Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Login Button
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : () => controller.loginNow(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueTheme,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.blueAccent,
                          elevation: 6,
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
