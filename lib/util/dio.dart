import 'package:dio/dio.dart';

class DioProvider {
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
        baseUrl: "https://pocketbase--bmabfep1.iran.liara.run/api/"));
    return dio;
  }
}
