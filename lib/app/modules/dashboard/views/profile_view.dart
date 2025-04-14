import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislab/app/modules/profile/controllers/profile_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sislab/app/routes/app_pages.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF1F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profil',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              _confirmLogout(context);
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4e54c8), Color(0xFF8f94fb)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;

        if (user == null || user.id == null) {
          return const Center(child: Text("Data pengguna tidak ditemukan."));
        }

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // 🔹 Header Profil
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4e54c8), Color(0xFF8f94fb)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Text(
                        (user.name?.isNotEmpty ?? false) ? user.name![0].toUpperCase() : '?',
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name ?? '-',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email ?? '-',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔸 Informasi Tambahan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.indigo),
                      title: const Text('Tanggal Pembuatan Akun'),
                      subtitle: Text(user.createdAt ?? '-'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.verified_user, color: Colors.green),
                      title: const Text('Status'),
                      subtitle: const Text('Pengguna Terdaftar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _confirmLogout(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.exit_to_app, size: 50, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Apakah Anda yakin ingin keluar?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back(); // Menutup dialog
                        },
                        child: const Text('Batal', style: TextStyle(color: Colors.blue)),
                      ),
                      TextButton(
                        onPressed: () async {
                          await _logout(context);
                        },
                        child: const Text('Logout', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Menghapus token atau data autentikasi yang tersimpan
    await GetStorage().erase();

    // Arahkan pengguna ke halaman login setelah logout
    Get.offAllNamed(Routes.LOGIN);
  }
}
