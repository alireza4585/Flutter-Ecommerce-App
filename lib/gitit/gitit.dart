import 'package:flutter_shopping_app_with_api/data/datasource/datasource_auth.dart';
import 'package:flutter_shopping_app_with_api/data/datasource/datasource_banner.dart';
import 'package:flutter_shopping_app_with_api/data/repository/auth_repository.dart';
import 'package:flutter_shopping_app_with_api/data/repository/banner_repository.dart';
import 'package:flutter_shopping_app_with_api/util/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

var locator = GetIt.instance;

Future<void> getInitit() async {
  await _initComponents();
  await _initDatasources();
  await _initRepository();
}

Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(DioProvider.createDioWithoutHeader());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _initDatasources() async {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator.registerFactory<IBannerDataSource>(() => BannerRemoteDateSource());
}

Future<void> _initRepository() async {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<IbannerRepository>(() => BannerRepository());
}
