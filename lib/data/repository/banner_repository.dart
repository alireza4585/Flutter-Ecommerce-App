import 'package:either_dart/either.dart';
import 'package:flutter_shopping_app_with_api/data/datasource/datasource_banner.dart';
import 'package:flutter_shopping_app_with_api/data/model/banner.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';
import 'package:flutter_shopping_app_with_api/util/exception.dart';

abstract class IbannerRepository {
  Future<Either<String, List<Banner_model>>> getbanner();
}

class BannerRepository extends IbannerRepository {
  final IBannerDataSource _bannerDataSource = locator.get();
  @override
  Future<Either<String, List<Banner_model>>> getbanner() async {
    try {
      var response = await _bannerDataSource.getbanner();
      return Right(response);
    } on ApiException catch (ex) {
      return Left(ex.message ?? 'error');
    }
  }
}
