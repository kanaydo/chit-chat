import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/img_banner.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/repository/banner_repository.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/responses/banners_response.dart';
import 'package:flutter_base_app/src/data/responses/dashboard_response.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>{

  SessionManager _sessionManager = SessionManager();
  MemberRepository memberRepository = MemberRepository();
  BannerRepository _bannerRepository = new BannerRepository();
  Member member;
  List<ImgBanner> banners;

  DashboardCubit() : super(null) {
    getMemberProfile();
  }

  void getMemberProfile() {
    _sessionManager.getActiveMember().then((value){
      if (value != 0) {
        fetchCurrentMemberProfile(value);
      }
    });
  }
  
  void fetchCurrentMemberProfile(int memberId) async {
    emit(LoadingDashboard());
    try {
      DashboardResponse response = await memberRepository.getMember(memberId);
      this.member = response.member;
    } on ApiException catch (apiException) {
      emit(ErrorDashboard(apiException.toString()));
    } catch (e) {
      emit(ErrorDashboard(e.toString()));
    }
    getBanners();
  }

  void getBanners() async {
    emit(LoadingDashboard());
    try {
      BannersResponse response = await _bannerRepository.getBanners();
      this.banners = response.banners;
      emit(IdleDashboard(member: member, banners: banners));
    } catch (exception) {
      emit(ErrorDashboard(exception.toString()));
    }
  }



}