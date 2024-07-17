import 'package:either_dart/either.dart';
import 'package:flutter_shopping_app_with_api/data/datasource/datasource_auth.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';
import 'package:flutter_shopping_app_with_api/util/exception.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String Email, String Password, String ConfirmPassword, String name);
  Future<Either<String, String>> login(String Email, String Password);
}

class AuthenticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> login(String Email, String Password) async {
    try {
      String token = await _datasource.login(Email, Password);
      if (token.isNotEmpty) {
        return Right('login');
      } else {
        return Left('Error');
      }
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }

  @override
  Future<Either<String, String>> register(String Email, String Password,
      String ConfirmPassword, String name) async {
    try {
      await _datasource.register(Email, Password, ConfirmPassword, name);
      return Right('Done');
    } on ApiException catch (ex) {
      return Left('${ex.message}');
    }
  }
}
