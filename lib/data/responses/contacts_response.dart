/*
 * Created by Batara Kanaydo on 24/11/2020
 * email: batara.girsang@outlook.com
 * Copyright © 2020 Batara Kanaydo. All rights reserved.
 * Last modified 11/21/20, 5:30 PM
 */

import 'package:flutter_base_app/data/model/contact.dart';

class ContactsResponse {
  List<Contact> _contacts;

  ContactsResponse.fromJSON(contactResponse) {
    _contacts = List<Contact>.of(
        contactResponse['contacts'].map<Contact>(
                (contact) => new Contact.fromJSON(contact)
        )
    );
  }

  List<Contact> get contacts => _contacts;
}