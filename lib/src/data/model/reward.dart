import 'package:flutter_base_app/src/utils/const.dart';

class Reward {
  int _id;
  String _caption;
  String _description;
  int _requiredPoint;
  String _title;
  String _validDate;
  String _imageUrl;

  Reward.fromJSON(json) {
    _id = json['id'];
    _caption = json['caption'];
    _description = json['description'];
    _requiredPoint = json['required_point'];
    _title = json['title'];
    _validDate = json['valid_date'];
    _imageUrl = json['image_url'];
  }

  int get id => _id;
  String get caption => _caption;
  String get description => _description;
  int get requiredPoint => _requiredPoint;
  String get title => _title;
  String get validDate => _validDate;
  String get imageUrl => 'http://$BASE_IP$_imageUrl';

}