import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/data/model/city.dart';
import 'package:flutter_base_app/src/data/model/district.dart';
import 'package:flutter_base_app/src/data/model/gender.dart';
import 'package:flutter_base_app/src/data/model/member.dart';
import 'package:flutter_base_app/src/data/model/province.dart';
import 'package:flutter_base_app/src/data/model/village.dart';
import 'package:flutter_base_app/src/utils/const.dart';
import 'package:flutter_base_app/src/utils/fade_animation.dart';
import 'package:flutter_base_app/src/views/profile/edit_profile/bloc/edit_profile_cubit.dart';
import 'package:flutter_base_app/src/widget/loa_body.dart';
import 'package:flutter_base_app/src/widget/loa_button.dart';
import 'package:flutter_base_app/src/widget/loa_container.dart';
import 'package:flutter_base_app/src/widget/loa_loading.dart';
import 'package:flutter_base_app/src/widget/loa_no_connection.dart';
import 'package:flutter_base_app/src/widget/loa_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditProfilePage extends StatelessWidget {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _yobController = TextEditingController();
  final _igController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BASE_COLOR,
            ),
            onPressed: () => Navigator.pop(context)
        ),
      ),
      body: LoaBody(
        child: BlocProvider(
          create: (context) => EditProfileCubit(),
          child: BlocListener<EditProfileCubit, EditProfileState>(
              listener: (listenerContext, state) {
                if (state is EditProfileError) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                  );
                  Scaffold.of(listenerContext).showSnackBar(snackBar);
                } else if (state is EditProfileSuccess) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                  );
                  Scaffold.of(listenerContext).showSnackBar(snackBar);
                }
              },
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (builderContext, state) {
                  if (state is EditProfileIdle) {
                    Member member = state.member;
                    if (_fullNameController.text == "") {
                      _fullNameController.text = member.fullName == null ? "" : member.fullName;
                    }
                    if (_emailController.text == "") {
                      _emailController.text = member.email == null ? "" : member.email;
                    }
                    if(_phoneController.text == "") {
                      _phoneController.text = member.phoneNumber == null ? "" : member.phoneNumber;
                    }
                    if (_yobController.text == "") {
                      _yobController.text = member.birthYear == null ? "" : member.birthYear.toString();
                    }
                    if (_igController.text == "") {
                      _igController.text = member.instagram == null ? "" : member.instagram;
                    }
                    if (_addressController.text == "") {
                      _addressController.text = member.address == null ? "" : member.address;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Edit Profil',
                          style: textTheme.headline4.apply(
                              color: BASE_COLOR
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(
                          delay: 1,
                          widget: Text(
                            "Data Member",
                            style: textTheme.bodyText2.apply(
                                color: Colors.grey
                            ),
                          ),
                        ),
                        LoaTextField(controller: _fullNameController, label: "Nama", obscureText: false),
                        LoaTextField(controller: _yobController, label: "Tahun Lahir", obscureText: false, keyboardType: TextInputType.number,),
                        LoaContainer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Jenis Kelamin',
                                        style: TextStyle(
                                            color: Colors.grey
                                        ),
                                      )
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<Gender>(
                                    style: TextStyle(
                                        color: Colors.grey
                                    ),
                                    selectedItemBuilder: (BuildContext context) {
                                      return state.genders.map((Gender gender) {
                                        return Align(
                                          alignment: Alignment.centerRight,
                                          child: (
                                              Text(
                                                '${gender.toString()}',
                                                style: TextStyle(
                                                    color: BASE_COLOR
                                                ),
                                              )
                                          ),
                                        );
                                      }).toList();
                                    },
                                    isExpanded: true,
                                    value: state.selectedGender,
                                    underline: null,
                                    onChanged: (Gender gender) {
                                      builderContext.bloc<EditProfileCubit>().setSelectedGender(gender);
                                    },
                                    items: state.genders.map((Gender gender) {
                                      return new DropdownMenuItem<Gender>(
                                        value: gender,
                                        child: new Text(
                                          gender.name,
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        LoaTextField(controller: _addressController, label: "Alamat", obscureText: false),
                        LoaContainer(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Provinsi',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SearchableDropdown.single(
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                  underline: "",
                                  selectedValueWidgetFn: (item) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${item.toString()}',
                                        style: TextStyle(
                                            color: BASE_COLOR
                                        ),
                                      ),
                                    );
                                  },
                                  items: state.provinces.map((prov) {
                                    return (
                                        DropdownMenuItem<Province>(
                                            child: Text(
                                                prov.name
                                            ),
                                            value: prov
                                        )
                                    );
                                  }).toList(),
                                  displayClearIcon: false,
                                  searchHint: "Pilih provinsi",
                                  value: state.selectedProvince,
                                  onChanged: (value) {
                                    if (value != null) {
                                      builderContext.bloc<EditProfileCubit>().setSelectedProvince(value);
                                    }
                                  },
                                  dialogBox: true,
                                  isExpanded: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoaContainer(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Kota',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SearchableDropdown.single(
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                  selectedValueWidgetFn: (item) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: (
                                          Text(
                                            '${item.toString()}',
                                            style: TextStyle(
                                                color: BASE_COLOR
                                            ),
                                          )
                                      ),
                                    );
                                  },
                                  underline: "",
                                  items: state.cities.map((city) {
                                    return (
                                        DropdownMenuItem<City>(
                                            child: Text(
                                                city.name
                                            ),
                                            value: city
                                        )
                                    );
                                  }).toList(),
                                  searchHint: "Pilih kota",
                                  value: state.selectedCity,
                                  displayClearIcon: false,
                                  onChanged: (value) {
                                    if (value != null) {
                                      builderContext.bloc<EditProfileCubit>().setSelectedCity(value);
                                    }
                                  },
                                  dialogBox: true,
                                  isExpanded: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoaContainer(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Kecamatan',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SearchableDropdown.single(
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                  selectedValueWidgetFn: (item) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: (
                                          Text(
                                            '${item.toString()}',
                                            style: TextStyle(
                                                color: BASE_COLOR
                                            ),
                                          )
                                      ),
                                    );
                                  },
                                  underline: "",
                                  items: state.districts.map((district) {
                                    return (
                                        DropdownMenuItem<District>(
                                            child: Text(
                                                district.name
                                            ),
                                            value: district
                                        )
                                    );
                                  }).toList(),
                                  searchHint: "Pilih Kecamatan",
                                  value: state.selectedDistrict,
                                  displayClearIcon: false,
                                  onChanged: (value) {
                                    if (value != null) {
                                      builderContext.bloc<EditProfileCubit>().setSelectedDistrict(value);
                                    }
                                  },
                                  dialogBox: true,
                                  isExpanded: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        LoaContainer(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  'Kelurahan',
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SearchableDropdown.single(
                                  style: TextStyle(
                                      color: Colors.grey
                                  ),
                                  selectedValueWidgetFn: (item) {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: (
                                          Text(
                                            '${item.toString()}',
                                            style: TextStyle(
                                                color: BASE_COLOR
                                            ),
                                          )
                                      ),
                                    );
                                  },
                                  underline: "",
                                  items: state.villages.map((village) {
                                    return (
                                        DropdownMenuItem<Village>(
                                            child: Text(
                                                village.name
                                            ),
                                            value: village
                                        )
                                    );
                                  }).toList(),
                                  searchHint: "Pilih Kelurahan",
                                  value: state.selectedVillage,
                                  displayClearIcon: false,
                                  onChanged: (value) {
                                    if (value != null) {
                                      builderContext.bloc<EditProfileCubit>().setSelectedVillage(value);
                                    }
                                  },
                                  dialogBox: true,
                                  isExpanded: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:16),
                          child: FadeAnimation(
                            delay: 1,
                            widget: Text(
                              "Kredensial",
                              style: textTheme.bodyText2.apply(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                        LoaTextField(controller: _emailController, label: "Email", obscureText: false),
                        LoaTextField(controller: _igController, label: "Instagram", obscureText: false),
                        LoaTextField(controller: _phoneController, label: "Telepon", obscureText: false),
                        LoaTextField(controller: _passwordController, label: "Password", obscureText: true),
                        Text(
                            '* kosongkan jika tidak ingin mengubah password',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.redAccent[200]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: <Widget>[
                              LoaButton(
                                  color: BASE_COLOR,
                                  title: "Perbaharui Profile",
                                  titleColor: Colors.white,
                                  minWidth: double.infinity,
                                  borderColor: BASE_COLOR,
                                  action: () {
                                    int memberId = member.id;
                                    String fullName = _fullNameController.text.trim();
                                    String birthYear = _yobController.text.trim();
                                    String email = _emailController.text.trim();
                                    String phone = _phoneController.text.trim();
                                    String password = _passwordController.text.trim();
                                    String ig = _igController.text.trim();
                                    String address = _addressController.text.trim();
                                    builderContext.bloc<EditProfileCubit>().buildParamsForUpdate(memberId, fullName, birthYear, email, phone, password, ig, address);
                                  }
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is EditProfileLoading) {
                    return LoaLoading(message: state.message);
                  } else if (state is EditProfileFatalError) {
                    return LoaNoConnection(
                        message: "Terjadi kesalahan",
                        action: () => builderContext.bloc<EditProfileCubit>().refreshEditProfilePage()
                    );
                  } else{
                    return Container();
                  }
                }
            ),
          ),
        ),
      ),
    );
  }
}
