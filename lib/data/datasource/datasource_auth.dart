import 'package:dio/dio.dart';
import 'package:flutter_shopping_app_with_api/util/auth_manager.dart';
import 'package:flutter_shopping_app_with_api/util/dio.dart';
import 'package:flutter_shopping_app_with_api/util/exception.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String Email, String Password, String ConfirmPassword, String name);
  Future<String> login(String Email, String Password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  @override
  final Dio _dio = DioProvider.createDioWithoutHeader();
  @override
  Future<String> login(String Email, String Password) async {
    try {
      final response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': Email,
        'password': Password,
      });
      if (response.statusCode == 200) {
        AuthManager.saveToken(response.data?['token']);
        return response.data?['token'];
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.data['massage'] ?? 'error');
    }
    return '';
  }

  @override
  Future<void> register(String Email, String Password, String ConfirmPassword,
      String name) async {
    try {
      final response = await _dio.post('collections/users/records', data: {
        'email': Email,
        'username': name,
        'password': Password,
        'passwordConfirm': ConfirmPassword,
      });
      if (response.statusCode == 200) {
        login(Email, Password);
      }
    } on DioError catch (ex) {
      throw ApiException(ex.response?.data['massage'] ?? 'error');
    }
  }
}
