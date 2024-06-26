import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/onboarding_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/onboarding_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

class OnBoardingProvider with ChangeNotifier {
  final OnBoardingRepo? onboardingRepo;

  OnBoardingProvider({required this.onboardingRepo});
List onBoardingList = [
  {
    'image':Images.onboardingImage1,
    'title':'onboardingTitle1',
  },{
    'image':Images.onboardingImage2,
    'title':'onboardingTitle2',
  },{
    'image':Images.onboardingImage3,
    'title':'onboardingTitle3',
  }
];

  // final List<OnboardingModel> _onBoardingList = [];
  // List<OnboardingModel> get onBoardingList => _onBoardingList;

  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  changeSelectIndex(int index){
    _selectedIndex=index;
    notifyListeners();
  }

  void initBoardingList(BuildContext context) async {
    // ApiResponse apiResponse = await onboardingRepo!.getOnBoardingList(context);
    // if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    //   _onBoardingList.clear();
    //   _onBoardingList.addAll(apiResponse.response!.data);
    // } else {
    //   ApiChecker.checkApi( apiResponse);
    // }
    notifyListeners();
  }
}
