import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  // Mengatur index halaman/tab yang sedang aktif
  var selectedIndex = 0.obs;

  // Status loading jika dibutuhkan
  var isLoading = false.obs;

  // Token dari local storage
  final token = GetStorage().read('token');

  // Ganti tab ketika ditekan di bottom bar
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Tambahkan logika init jika perlu
  }

  @override
  void onReady() {
    super.onReady();
    // Misalnya fetch data awal kalau perlu
  }

  @override
  void onClose() {
    super.onClose();
  }
}
