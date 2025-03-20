import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/anggota_response.dart';
import 'dart:convert';

class AnggotaController extends GetxController {
  var AnggotaList = <Data>[].obs;
  var isLoading = true.obs;
//   final box = GetStorage();
// String? token = box.read('token');

  @override
  void onInit() {
    fetchAnggota();
    super.onInit();
  }

 void fetchAnggota() async {
  String token = "Bearer token"; 
    try {
      isLoading(true);
      var response =
          await http.get(Uri.parse('http://172.20.10.2:8000/api/anggota'),
          headers: {
            "Accept": "application/json",
            "Authorization": token, // Tambahkan header autentikasi
          },
        );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var anggotaResponse = AnggotaResponse.fromJson(jsonData);

        if (anggotaResponse.data != null) {
          AnggotaList.value = anggotaResponse.data!;
        }
      } else {
        Get.snackbar("Error", "Gagal mengambil data anggota");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
