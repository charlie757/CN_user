import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/customDropDown.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/add_new_member_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/button/custom_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_password_textfield.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddNewMemberScreen extends StatefulWidget {
  const AddNewMemberScreen({Key? key}) : super(key: key);

  @override
  State<AddNewMemberScreen> createState() => _AddNewMemberScreenState();
}

class _AddNewMemberScreenState extends State<AddNewMemberScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _stateIdFocus = FocusNode();
  final FocusNode _zipCodeFocus = FocusNode();

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<AddNewMemberProvider>(context, listen: false);
    provider.clearValues();
    provider.initcountryApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMemberProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Text(getTranslated('addNewMember', context)!),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getTranslated('FIRST_NAME', context)!,
                            style: titilliumRegular),
                        const SizedBox(height: Dimensions.marginSizeSmall),
                        CustomTextField(
                          textInputType: TextInputType.name,
                          focusNode: _fNameFocus,
                          nextNode: _lNameFocus,
                          hintText: '',
                          controller: myProvider.firstNameController,
                        ),
                      ],
                    )),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getTranslated('LAST_NAME', context)!,
                            style: titilliumRegular),
                        const SizedBox(height: Dimensions.marginSizeSmall),
                        CustomTextField(
                          textInputType: TextInputType.name,
                          focusNode: _lNameFocus,
                          nextNode: _emailFocus,
                          hintText: '',
                          controller: myProvider.lastNameController,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('EMAIL', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      focusNode: _emailFocus,
                      nextNode: _phoneFocus,
                      hintText: '',
                      controller: myProvider.emailController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('PHONE_NO', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomTextField(
                      textInputType: TextInputType.phone,
                      focusNode: _phoneFocus,
                      hintText: "",
                      nextNode: _passwordFocus,
                      controller: myProvider.phoneController,
                      isPhoneNumber: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('PASSWORD', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomPasswordTextField(
                      controller: myProvider.passwordController,
                      focusNode: _passwordFocus,
                      nextNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('RE_ENTER_PASSWORD', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomPasswordTextField(
                      controller: myProvider.confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      nextNode: _stateIdFocus,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('stateId', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomTextField(
                      textInputType: TextInputType.name,
                      focusNode: _stateIdFocus,
                      nextNode: _addressFocus,
                      hintText: '',
                      controller: myProvider.stateIdController,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('address', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomTextField(
                      textInputType: TextInputType.name,
                      focusNode: _addressFocus,
                      // nextNode: _addressFocus,
                      hintText: '',
                      controller: myProvider.addressController,
                    ),
                  ],
                ),
              ),
              dropDownWidget(
                context: context,
                itemList: myProvider.countryList,
                value: myProvider.countrydropdownvalue,
                title: 'country',
                hintText: 'Select country',
                onChanged: (dynamic newValue) {
                  setState(() {
                    myProvider.countrydropdownvalue = newValue;
                    myProvider.initStateApi(newValue['id'].toString());
                  });
                },
              ),
              dropDownWidget(
                context: context,
                itemList: myProvider.stateList,
                value: myProvider.statedropdownvalue,
                title: 'state',
                hintText: 'Select state',
                onChanged: (newValue) {
                  setState(() {
                    myProvider.statedropdownvalue = newValue;
                    myProvider.initcityApi(newValue['id'].toString());
                  });
                },
              ),
              dropDownWidget(
                context: context,
                itemList: myProvider.cityList,
                value: myProvider.citydropdownvalue,
                title: 'city',
                hintText: 'Select city',
                onChanged: (newValue) {
                  setState(() {
                    myProvider.citydropdownvalue = newValue;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: Dimensions.marginSizeDefault,
                    left: Dimensions.marginSizeDefault,
                    right: Dimensions.marginSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated('zip', context)!,
                        style: titilliumRegular),
                    const SizedBox(height: Dimensions.marginSizeSmall),
                    CustomTextField(
                      textInputType: TextInputType.phone,
                      focusNode: _zipCodeFocus,
                      hintText: "",
                      // nextNode: _confirmPasswordFocus,
                      controller: myProvider.zipCodeController,
                      // isPhoneNumber: true,
                    ),
                  ],
                ),
              ),
              myProvider.isLoading
                  ? Container(
                      height: 48,
                      padding: const EdgeInsets.all(7),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.marginSizeLarge,
                          vertical: Dimensions.marginSizeExtraLarge),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).highlightColor)))
                  : Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.marginSizeLarge,
                          vertical: Dimensions.marginSizeExtraLarge),
                      child: CustomButton(
                        buttonText: 'submit',
                        onTap: () {
                          myProvider.checkValidation(context);
                        },
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }

  dropDownWidget(
      {required BuildContext context,
      required List<Map<String, dynamic>> itemList,
      value,
      var title,
      var hintText,
      Function(Map<String, dynamic>)? onChanged}) {
    return Container(
      margin: const EdgeInsets.only(
          top: Dimensions.marginSizeDefault,
          left: Dimensions.marginSizeDefault,
          right: Dimensions.marginSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTranslated(title, context)!, style: titilliumRegular),
          const SizedBox(height: Dimensions.marginSizeSmall),
          customDropDown(
              context: context,
              itemList: itemList,
              value: value,
              hintText: hintText,
              onChanged: onChanged)
        ],
      ),
    );
  }
}
