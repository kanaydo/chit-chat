import 'package:flutter_base_app/src/data/model/img_banner.dart';

class BannersResponse {
  List<ImgBanner> _banners;

  BannersResponse.fromJson(json) {
    _banners = List<ImgBanner>.of(
        json.map<ImgBanner>((banner) => new ImgBanner.fromJSON(banner))
    );
  }

  List<ImgBanner> get banners => _banners;
}