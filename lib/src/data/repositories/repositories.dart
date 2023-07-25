import 'package:get/get.dart';
import 'package:sql_with_api_testing/src/domain/models/remote_model_class/remote_model_class.dart';
import 'package:dio/dio.dart';

class ApiFunctions {
  Future<List<RemoteModelClass>> getData() async {
    try {
      final response = await Dio().get('https://jsonplaceholder.typicode.com/posts/1/comments');
      if (response.statusCode == 200) {
        List<RemoteModelClass> result = (response.data as List<dynamic>)
            .map((e) => RemoteModelClass.fromJson(e as Map<String, dynamic>))
            .toList();
        return result;
      } else {
        throw Exception();
      }
    } catch (e) {
      Get.snackbar('something went wrong', e.toString());
      throw Exception();
    }
  }
}
