import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sislab/app/data/peminjaman_response.dart';
import 'package:sislab/app/utils/api.dart';

class PeminjamanController extends GetxController {
  var peminjamanList = <PeminjamanResponse>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPeminjaman();
    super.onInit();
  }

  void fetchPeminjaman() async {
    String token = "Bearer 15|C1nNyihSTb09vWAmFmNbEZ0K4CLGe2fGa6ghDYud6d00aff1"; // ganti dengan token valid

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(BaseUrl.peminjaman),
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<dynamic> dataList = jsonData['data'] ?? [];

        peminjamanList.value = dataList
            .map((item) => PeminjamanResponse.fromJson(item))
            .toList();
      } else {
        Get.snackbar("Error", "Gagal mengambil data peminjaman");
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
