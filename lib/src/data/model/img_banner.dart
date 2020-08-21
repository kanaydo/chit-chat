import 'package:flutter_base_app/src/utils/const.dart';

class ImgBanner {
  int _id;
  String _caption;
  String _title;
  String _imageUrl;

  ImgBanner.fromJSON(json) {
    _id = json['id'];
    _caption = json['caption'];
    _title = json['title'];
    _imageUrl = json['image_url'];
  }

  int get id => _id;
  String get caption => _caption;
  String get title => _title;
  String get imageUrl => 'http://$BASE_IP$_imageUrl';
}