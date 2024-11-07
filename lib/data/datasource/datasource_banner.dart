import 'package:flutter_shopping_app_with_api/data/model/banner.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';
import 'package:flutter_shopping_app_with_api/util/exception.dart';

abstract class IBannerDataSource {
  Future<List<Banner_model>> getbanner();
}

class BannerRemoteDateSource extends IBannerDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Banner_model>> getbanner() async {
    var respones = await _dio.get('collections/Banner/records');
    try {
      return respones.data["items"]
          .map<Banner_model>((Json) => Banner_model.fromJson(Json))
          .toList();
    } on DioError catch (ex) {
      throw ApiException(ex.response?.data['message']);
    } catch (ex) {
      throw ApiException('unkown erorr');
    }
  }
}
