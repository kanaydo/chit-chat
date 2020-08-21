import 'package:flutter_base_app/src/data/model/img_banner.dart';
import 'package:flutter_base_app/src/data/repository/banner_repository.dart';
import 'package:flutter_base_app/src/data/responses/banners_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {

  BannerRepository _bannerRepository = new BannerRepository();
  
  WelcomeCubit() : super(null) {
    getBanners();
  }

  void getBanners() async {
    emit(LoadingBanner());
    try {
      BannersResponse response = await _bannerRepository.getBanners();
      emit(IdleBanner(response.banners));
    } catch (exception) {
      emit(ErrorBanner(exception.toString()));
    }
  }

}