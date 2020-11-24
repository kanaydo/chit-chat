import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/const/app_color.dart';
import 'package:flutter_base_app/core/routes.dart';
import 'package:flutter_base_app/views/contacts/bloc/contacts_cubit.dart';
import 'package:flutter_base_app/views/contacts/contact_list.dart';
import 'package:flutter_base_app/views/conversations/user_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColor.BASE_COLOR,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Contacts',
              style: textTheme.headline5.apply(color: AppColor.BASE_COLOR),
            )),
            UserImage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Routes.addContact),
        child: Icon(Icons.person_add),
      ),
      body: BlocProvider(
        create: (context) => ContactsCubit(),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (contactsContext, state) {
            if (state is ContactsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ContactsError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ContactsFatalError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ContactsIdle) {
              return ContactList(contacts: state.contacts);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
