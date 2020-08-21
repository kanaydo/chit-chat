import 'package:flutter_base_app/src/core/api_exception.dart';
import 'package:flutter_base_app/src/data/model/city.dart';
import 'package:flutter_base_app/src/data/model/district.dart';
import 'package:flutter_base_app/src/data/model/gender.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/model/province.dart';
import 'package:flutter_base_app/src/data/model/village.dart';
import 'package:flutter_base_app/src/data/repository/member_repository.dart';
import 'package:flutter_base_app/src/data/repository/province_repository.dart';
import 'package:flutter_base_app/src/data/responses/member_responses.dart';
import 'package:flutter_base_app/src/utils/session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {

  SessionManager sessionManager = SessionManager();
  MemberRepository memberRepository = MemberRepository();
  ProvinceRepository provinceRepository = ProvinceRepository();
  Gender gender;
  Member member;
  List<Province> provinces = [];
  List<City> cities = [];
  List<District> districts = [];
  List<Village> villages = [];
  Province selectedProvince;
  City selectedCity;
  Gender selectedGender;
  District selectedDistrict;
  Village selectedVillage;
  List<Gender> genders = <Gender>[const Gender(1, "Laki-Laki"), const Gender(2, "Perempuan")];

  EditProfileCubit() : super(null) {
    sessionManager.getActiveMember().then((value) => {
      if (value != 0) {
        fetchCurrentMemberProfile(value)
      }
    });
  }

  void refreshEditProfilePage() async {
    int memberId = await sessionManager.getActiveMember();
    if (memberId != 0) {
      fetchCurrentMemberProfile(memberId);
    }
  }

  void fetchCurrentMemberProfile(int memberId) async {
    emit(EditProfileLoading(message: 'sedang mengambil profile..'));
    try {
      ProfileResponse response = await memberRepository.getMemberProfile(memberId);
      this.member = response.member;
      if (member.genderId != null) {
        int index = genders.indexWhere((element) => element.id == member.genderId);
        this.selectedGender = genders[index];
      }
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch (e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    fetchProvinceList() ;
  }

  void buildParamsForUpdate(int memberId, String fullName, String birthYear, String email, String phone, String password, String ig, String address) {
    if (fullName == "" || birthYear == "" || email == "" || phone == "") {
      emit(EditProfileError(message: "Mohon untuk mengisi semua field yang disediakan!"));
      emmitToIdle();
    } else {
      Map<String, dynamic> data;
      if (password == "") {
        data = {
          "full_name": fullName,
          "email": email,
          "gender_id": selectedGender?.id,
          "birth_year": birthYear,
          "phone_number": phone,
          "province_id": selectedProvince?.id,
          "city_id": selectedCity?.id,
          "district_id": selectedDistrict?.id,
          "village_id": selectedVillage?.id,
          "instagram": ig,
          "address": address
        };
      } else {
        data = {
          "full_name": fullName,
          "email": email,
          "gender_id": selectedGender?.id,
          "birth_year": birthYear,
          "phone_number": phone,
          "province_id": selectedProvince?.id,
          "city_id": selectedCity?.id,
          "district_id": selectedDistrict?.id,
          "village_id": selectedVillage?.id,
          "instagram": ig,
          "address": address,
          "password": password,
        };
      }

      Map<String, dynamic> params = {
        "member": data,
      };
      updateMemberProfile(params);
    }
  }

  void updateMemberProfile(Map<String, dynamic> params) async {
    emit(EditProfileLoading(message: 'sedang mengambil profile..'));
    try {
      ProfileResponse response = await memberRepository.updateMemberProfile(params, member.id);
      this.member = response.member;
      emit(EditProfileSuccess(message: "Berhasil memperbaharui profil anda!"));
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch (e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    emmitToIdle();
  }

  void fetchProvinceList() async {
    emit(EditProfileLoading(message: "sedang mengambil daftar provinsi.."));
    try {
      List<Province> provinces = await provinceRepository.getProvinceList();
      this.provinces = provinces;
      if (member.province != null) {
        int index = provinces.indexWhere((element) => element.id == member.province.id);
        this.selectedProvince = provinces[index];
      }
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch(e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    if (selectedProvince != null) {
      fetchCityByProvince(selectedProvince.id);
    } else {
      emmitToIdle();
    }
  }

  void fetchCityByProvince(int province) async {
    emit(EditProfileLoading(message: "sedang mengambil daftar kota.."));
    try {
      List<City> cities = await provinceRepository.getProvinceCities(province);
      this.cities = cities;
      if (member.city != null) {
        int index = cities.indexWhere((city) => city.id == member.city.id);
        this.selectedCity = cities[index];
      }
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch(e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    if (selectedCity != null) {
      fetchDistrictsByCity(selectedCity.id);
    } else {
      emmitToIdle();
    }
  }

  void setSelectedProvince(Province province) {
    this.selectedProvince = province;
    fetchCityByProvince(province.id);
  }

  void setSelectedCity(City city) {
    this.selectedCity = city;
    fetchDistrictsByCity(city.id);
  }

  void fetchDistrictsByCity(int city) async {
    emit(EditProfileLoading(message: "sedang mengambil daftar kecamatan.."));
    try {
      List<District> districts = await provinceRepository.getDistrictsByCity(city);
      this.districts = districts;
      if (member.district != null) {
        int index = districts.indexWhere((district) => district.id == member.district.id);
        this.selectedDistrict = districts[index];
      }
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch(e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    if (selectedDistrict != null) {
     fetchVillageByDistrict(selectedDistrict.id) ;
    } else {
      emmitToIdle();
    }
  }

  void setSelectedDistrict(District district) {
    this.selectedDistrict = district;
    fetchVillageByDistrict(district.id);
  }

  void fetchVillageByDistrict(int district) async {
    emit(EditProfileLoading(message: "sedang mengambil daftar kelurahan.."));
    try {
      List<Village> villages = await provinceRepository.getVillageByDistrict(district);
      this.villages = villages;
      if (member.village != null) {
        int index = villages.indexWhere((village) => village.id == member.village.id);
        this.selectedVillage = villages[index];
      }
    } on ApiException catch (apiException) {
      emit(EditProfileError(message: apiException.toString()));
    } catch(e) {
      emit(EditProfileFatalError(message: e.toString()));
    }
    emmitToIdle();
  }

  void setSelectedVillage(Village village) {
    this.selectedVillage = village;
  }

  void setSelectedGender(Gender gender) {
    this.selectedGender = gender;
    emmitToIdle();
  }

  void emmitToIdle() {
    emit(
        EditProfileIdle(
          provinces: provinces,
          member: member,
          selectedProvince: selectedProvince,
          cities: cities,
          selectedCity: selectedCity,
          selectedGender: selectedGender,
          genders: genders,
          districts: districts,
          selectedDistrict: selectedDistrict,
          villages: villages,
          selectedVillage: selectedVillage
        )
    );
  }


}