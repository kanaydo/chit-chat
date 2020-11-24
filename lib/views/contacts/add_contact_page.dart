/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/24/20, 9:49 PM
 */

import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/arguments/contact_detail_arguments.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/views/contacts/bloc/add_contact_cubit.dart';
import 'package:flutter_base_app/views/contacts/contact_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddContactCubit(),
        child: BlocConsumer<AddContactCubit, AddContactState>(
          listener: (context, state) {
            if (state is AddContactContactFound) {
              var argument = ContactDetailArgument(user: state.user);
              Navigator.pushNamed(context, Routes.contactDetail, arguments: argument);
            }
          },
          builder: (context, state) {
            if (state is AddContactIdle) {
              return ContactScanner();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
