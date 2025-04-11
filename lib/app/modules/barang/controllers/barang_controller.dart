import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sislab/app/utils/api.dart';
import 'package:sislab/app/data/barang_response.dart';

class BarangController extends GetxController {
  var barangList = <Data>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchBarang();
    super.onInit();
  }

  void fetchBarang() async {
    String token = "Bearer 11|QsTfMwMgwfxZqAChCN4TX66IAHBr5dcWnRcR8C28c1cfe781"; // Ganti dengan token valid

    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse(BaseUrl.barang), // Ganti dengan endpoint API barang kamu
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        var barangResponse = BarangResponse.fromJson(jsonData);

        if (barangResponse.data != null && barangResponse.data!.isNotEmpty) {
          barangList.value = barangResponse.data!;
          print("Jumlah data barang: ${barangList.length}");
        } else {
          print("Data barang kosong setelah parsing");
        }
      } else {
        print("Gagal mengambil data barang, status code: ${response.statusCode}");
        Get.snackbar("Error", "Gagal mengambil data barang");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
