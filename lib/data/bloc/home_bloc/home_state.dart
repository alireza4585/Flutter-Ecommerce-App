import 'package:either_dart/either.dart';
import 'package:flutter_shopping_app_with_api/data/model/banner.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<Banner_model>> bannerList;

  HomeRequestSuccessState(this.bannerList);
}
