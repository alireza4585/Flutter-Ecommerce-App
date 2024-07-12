import 'package:get_it/get_it.dart';
import 'package:loginapi/data/datasource/datasource_auth.dart';
import 'package:loginapi/data/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;

Future<void> getInitit() async {
  await _initComponents();
  await _initDatasources();
  await _initRepository();
}

Future<void> _initComponents() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _initDatasources() async {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
}

Future<void> _initRepository() async {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
}
