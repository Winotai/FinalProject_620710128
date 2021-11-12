import 'dart:convert';
import 'package:final_620710128/models/api_result.dart';
import 'package:http/http.dart' as http;

class Api {
  static const BASE_URL = 'https://covid19.ddc.moph.go.th';

  Future<dynamic> submit(
    String endPoint,
    Map<String, dynamic> params,
  ) async {
    var url = Uri.parse('$BASE_URL/$endPoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(params),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      print('RESPONSE BODY: $jsonBody');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.success) {
        return apiResult.data;
      } else {
        throw apiResult.message!;
      }
    } else {
      throw 'Server connection failed!';
    }
  }

  Future<dynamic> fetch(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      String res =
          '{"success":true,"message":"Success","data":${response.body}}';

      Map<String, dynamic> jsonBody = json.decode(res);

      print('RESPONSE BODY: $jsonBody');

      var apiResult = ApiResult.fromJson(jsonBody);

      if (apiResult.success) {
        return apiResult.data;
      } else {
        throw apiResult.message!;
      }
    } else {
      throw 'Server connection failed!';
    }
  }
}
