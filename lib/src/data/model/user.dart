class User {
  int _id;
  String _fullName;
  String _email;
  int _genderId;
  int _birthYear;
  String _phoneNumber;
  int _currentPoints;
  String _validUntil;
  String _address;

  User.fromJSON(member) {
    _id = member['id'];
    _fullName = member['full_name'];
    _email = member['email'];
    _genderId = member['gender_id'];
    _birthYear = member['birth_year'];
    _phoneNumber = member['phone_number'];
    _currentPoints = member['current_points'];
    _validUntil = member['valid_until'];
    _address = member['address'];
  }

  int get id => _id;
  String get fullName => _fullName;
  String get email => _email;
  int get genderId => _genderId;
  int get birthYear => _birthYear;
  String get phoneNumber => _phoneNumber;
  int get currentPoints => _currentPoints;
  String get validUntil => _validUntil;
  String get address => _address;

}