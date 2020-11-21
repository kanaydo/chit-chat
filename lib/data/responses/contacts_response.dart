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