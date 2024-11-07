import 'package:bloc/bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_event.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_state.dart';
import 'package:flutter_shopping_app_with_api/data/repository/banner_repository.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IbannerRepository _ibannerRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitilzeData>(
      (event, emit) async {
        emit(HomeLoadingState());
        var bannerList = await _ibannerRepository.getbanner();

        emit(HomeRequestSuccessState(bannerList));
      },
    );
  }
}
