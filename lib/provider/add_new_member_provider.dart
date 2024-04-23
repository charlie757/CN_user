import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/country_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/add_new_member_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';

class AddNewMemberProvider extends ChangeNotifier {
  final AddNewMemberRepo? addNewMemberRepo;
  AddNewMemberProvider({required this.addNewMemberRepo});
  bool isLoading = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController stateIdController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  List<Map<String, dynamic>> countryList = [];
  List<Map<String, dynamic>> stateList = [];
  List<Map<String, dynamic>> cityList = [];

  Map<String, dynamic>? countrydropdownvalue;
  Map<String, dynamic>? statedropdownvalue;
  Map<String, dynamic>? citydropdownvalue;

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  clearValues() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    stateIdController.clear();
    addressController.clear();
    zipCodeController.clear();
    // countryList.clear();
    stateList.clear();
    cityList.clear();
    countrydropdownvalue = null;
    statedropdownvalue = null;
    citydropdownvalue = null;
  }

  initClearValeus() {
    countryList.clear();
    stateList.clear();
    cityList.clear();
    countrydropdownvalue = null;
    statedropdownvalue = null;
    citydropdownvalue = null;
  }

  checkValidation(BuildContext context) {
    if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('EMAIL_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PHONE_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if ((passwordController.text.isEmpty ||
        passwordController.text.length < 8)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Password should be at least 8 character'),
          backgroundColor: ColorResources.red));
    } else if ((confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text.length < 8)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Confirm Password should be at least 8 character'),
          backgroundColor: ColorResources.red));
    } else if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_DID_NOT_MATCH', context)!),
          backgroundColor: ColorResources.red));
    } else if (stateIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('STATE_ID_MUSE_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('ADDRESS_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (countrydropdownvalue == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('COUNTRY_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (statedropdownvalue == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('STATE_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (citydropdownvalue == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('CITY_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else if (zipCodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(getTranslated('ZIPCODE_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.red));
    } else {
      addMemberApiFunction(context);
    }
  }

  Future<void> addMemberApiFunction(BuildContext context) async {
    updateLoading(true);
    var body = json.encode({
      "f_name": firstNameController.text,
      "l_name": lastNameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "password": passwordController.text,
      "con_password": confirmPasswordController.text,
      "state_id": stateIdController.text,
      // "dob": "29-10-1994",
      "address": addressController.text,
      "country": countrydropdownvalue!['title'],
      "state": statedropdownvalue!['title'],
      "city": citydropdownvalue!['title'],
      "zip": zipCodeController.text
    });
    print(body);
    ApiResponse apiResponse = await addNewMemberRepo!.addMember(body);
    updateLoading(false);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      clearValues();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse.response!.data['message'].toString()),
          backgroundColor: ColorResources.green));
    }
  }

  Future<void> initcountryApi() async {
    initClearValeus();
    ApiResponse apiResponse = await addNewMemberRepo!.getCountryList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        CountryModel model = CountryModel.fromJson(element);
        countryList.add({'id': model.id, 'title': model.title});
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initStateApi(String id) async {
    stateList.clear();
    cityList.clear();
    statedropdownvalue = null;
    citydropdownvalue = null;
    ApiResponse apiResponse = await addNewMemberRepo!.getStateList(id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        CountryModel model = CountryModel.fromJson(element);
        stateList.add({'id': model.id, 'title': model.title});
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> initcityApi(String id) async {
    cityList.clear();
    citydropdownvalue = null;
    ApiResponse apiResponse = await addNewMemberRepo!.getCityList(id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        CountryModel model = CountryModel.fromJson(element);
        cityList.add({'id': model.id, 'title': model.title});
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}
