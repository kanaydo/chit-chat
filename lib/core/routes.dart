import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/views/dashboard/dashboard_page.dart';
import 'package:flutter_base_app/views/sign_in/sign_in_page.dart';
import 'package:flutter_base_app/views/sign_up/sign_up_page.dart';

class Routes {

  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.signIn : (context) => SignInPage(),
      Routes.signUp : (context) => SignUpPage(),
      Routes.dashboard : (context) => DashboardPage()
    };
  }

}