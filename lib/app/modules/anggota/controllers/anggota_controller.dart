import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/anggota_response.dart';
import 'dart:convert';

import 'package:sislab/app/utils/api.dart';

class AnggotaController extends GetxController {
  var anggotaList = <Data>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchAnggota();
    super.onInit();
  }

  void fetchAnggota() async {
  String token = "Bearer QLkb43Qbcd4j8sek5pk6xMNahcjIQoiEo6178RTI128e09d7"; // Gantilah dengan token yang benar
  try {
    isLoading(true);
    var response = await http.get(
      Uri.parse(BaseUrl.anggota), // Pastikan URL benar
      headers: {
        "Accept": "application/json",
        "Authorization": token,
      },
    );

    // ✅ Debugging: Cek status respons dan isi respons
    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      
      print("JSON Decoded: $jsonData"); // Debugging

      var anggotaResponse = AnggotaResponse.fromJson(jsonData);

      print("Parsed Data: ${anggotaResponse.data}");

      if (anggotaResponse.data != null && anggotaResponse.data!.isNotEmpty) {
        anggotaList.value = anggotaResponse.data!;
        print("Jumlah data anggota: ${anggotaList.length}");
      } else {
        print("Data anggota kosong setelah parsing");
      }
    } else {
      print("Gagal mengambil data, status code: ${response.statusCode}");
      Get.snackbar("Error", "Gagal mengambil data anggota");
    }
  } catch (e) {
    print("Error: $e");
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading(false);
  }
}
}
