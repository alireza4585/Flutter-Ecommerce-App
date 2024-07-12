import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? message;
  Response<dynamic>? response;
  ApiException(this.message, {this.response}) {
    if (message == 'Failed to authenticate.') {
      message = 'passworld or username is incorrect';
    }
    if (message == 'Failed to create record.') {
      if (response?.data['data']['username'] != null) {
        if (response?.data['data']['username']['message'] ==
            'The username is invalid or already in use.') {
          message = 'username is already in use';
        }
      }
      if (response?.data['data']['email'] != null) {
        if (response?.data['data']['email']['message'] ==
            'The email is invalid or already in use.') {
          message = 'email is already in use';
        }
      }
    }
  }
}
