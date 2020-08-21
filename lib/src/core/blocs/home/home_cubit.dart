import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  SessionManager sessionManager = SessionManager();
  int memberId = 0;
  bool loggedIn = false;

  HomeCubit() : super(null){
    checkMemberAuth();
  }

  void checkMemberAuth() async {
    emit(CheckAuthenticate(message: "sedang memeriksa login.."));
    this.memberId = await sessionManager.getActiveMember();
    this.loggedIn = await sessionManager.getLoggedInStatus();
    if (memberId != 0 && loggedIn != false) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

}