import 'package:flutter_base_app/src/data/model/city.dart';
import 'package:flutter_base_app/src/data/model/district.dart';
import 'package:flutter_base_app/src/data/model/province.dart';
import 'package:flutter_base_app/src/data/model/village.dart';

class Member {
  int _id;
  String _fullName;
  String _email;
  int _genderId;
  int _birthYear;
  String _phoneNumber;
  Province _province;
  City _city;
  int _currentPoints;
  String _validUntil;
  District _district;
  Village _village;
  String _instagram;
  String _address;

  Member.fromJSON(member) {
    _id = member['id'];
    _fullName = member['full_name'];
    _email = member['email'];
    _genderId = member['gender_id'];
    _birthYear = member['birth_year'];
    _phoneNumber = member['phone_number'];
    if (member['province'] != null) {
      _province = new Province.fromJSON(member['province']);
    }
    if (member['city'] != null) {
      _city = new City.fromJSON(member['city']);
    }
    if (member['district'] != null) {
      _district = new District.fromJSON(member['district']);
    }
    if (member['village'] != null) {
      _village = new Village.fromJSON(member['village']);
    }
    _currentPoints = member['current_points'];
    _validUntil = member['valid_until'];
    _instagram = member['instagram'];
    _address = member['address'];
  }

  int get id => _id;
  String get fullName => _fullName;
  String get email => _email;
  int get genderId => _genderId;
  int get birthYear => _birthYear;
  String get phoneNumber => _phoneNumber;
  Province get province => _province;
  City get city => _city;
  int get currentPoints => _currentPoints;
  String get validUntil => _validUntil;
  District get district => _district;
  Village get village => _village;
  String get instagram => _instagram;
  String get address => _address;
  String get displayName {
    String display = "-";
    if(fullName == null) {
      if (email == null) {
        if (phoneNumber == null) {
          display = "-";
        } else {
          display = phoneNumber;
        }
      } else {
        display = email;
      }
    } else {
      display = fullName;
    }
    return display;
  }

  bool get profileCompleted {
    return fullName != null && email != null && genderId != null && birthYear != null && phoneNumber != null && province != null && city != null;
  }

  String regionAddress() {
    String region = "";
    region += "${village == null ? ' - ' : village.name}, ";
    region += "${district == null ? ' - ' : district.name}, ";
    region += "${city == null ? ' - ' : city.name}, ";
    region += "${province == null ? ' - ' : province.name}";
    return region;
  }

  String get gender => genderId == 1 ? "Laki-laki" : "Perempuan";

}