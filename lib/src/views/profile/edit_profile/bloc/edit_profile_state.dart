part of 'edit_profile_cubit.dart';


@immutable
abstract class EditProfileState {}

class EditProfileIdle extends EditProfileState {
  final Member member;
  final Gender selectedGender;
  final List<Province> provinces;
  final List<City> cities;
  final List<Gender> genders;
  final List<District> districts;
  final Province selectedProvince;
  final City selectedCity;
  final District selectedDistrict;
  final List<Village> villages;
  final Village selectedVillage;

  EditProfileIdle({
    this.member,
    this.provinces,
    this.selectedProvince,
    this.cities,
    this.selectedCity,
    this.genders,
    this.selectedGender,
    this.districts,
    this.selectedDistrict,
    this.villages,
    this.selectedVillage
  });
}

class EditProfileLoading extends EditProfileState {
  final String message;
  EditProfileLoading({this.message});
}

class EditProfileSuccess extends EditProfileState {
  final String message;
  EditProfileSuccess({this.message});
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError({this.message});
}

class EditProfileFatalError extends EditProfileState {
  final String message;
  EditProfileFatalError({this.message});
}
