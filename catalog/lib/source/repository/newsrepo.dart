import 'dart:io';
import 'dart:math';

import 'package:catalog/source/network/api.dart';
import 'package:dio/dio.dart';

class NewsRepository {
  final Dio dio = Dio();

  Future addNews({required String? title, required String? desc, required String? date, required File? image}) async {
    try {
      FormData formData = FormData.fromMap({
        "title": title,
        "desc": desc,
        "date": date,
        "url_image": await MultipartFile.fromFile(image!.path, filename: 'image.jpeg'),
      });
      print("FORM DATA: ${formData.fields}");
      Response response = await dio.post(Api.addNewsCatalog(), data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
      } else {
        print('Failed to add');
        // throw Exception('Failed to Add News Catalog');
      }
    } catch (e) {
      print('Error: $e');
      // throw Exception('ERROR: $e');
    }
  }
}
