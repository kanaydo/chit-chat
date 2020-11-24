/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 8:12 PM
 */

import 'package:flutter/widgets.dart';
import 'package:flutter_base_app/views/chat/chat_page.dart';
import 'package:flutter_base_app/views/contacts/add_contact_page.dart';
import 'package:flutter_base_app/views/contacts/contact_detail_page.dart';
import 'package:flutter_base_app/views/contacts/contacts_page.dart';
import 'package:flutter_base_app/views/conversations/conversations_page.dart';
import 'package:flutter_base_app/views/profile/profile_page.dart';
import 'package:flutter_base_app/views/sign_in/sign_in_page.dart';
import 'package:flutter_base_app/views/sign_up/sign_up_page.dart';

class Routes {
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String dashboard = '/dashboard';
  static const String conversations = '/conversations';
  static const String contacts = '/contacts';
  static const String contactDetail = '/contact_detail';
  static const String addContact = '/add_contact';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.signIn: (context) => SignInPage(),
      Routes.signUp: (context) => SignUpPage(),
      Routes.conversations: (context) => ConversationPage(),
      Routes.contacts: (context) => ContactsPage(),
      Routes.contactDetail: (context) => ContactDetailPage(),
      Routes.addContact: (context) => AddContactPage(),
      Routes.chat: (context) => ChatPage(),
      Routes.profile: (context) => ProfilePage(),
    };
  }
}
