import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/onboarding_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({Key? key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  }) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<OnBoardingProvider>(
        builder: (context, onBoardingList, child) {
        return PageView.builder(
              itemCount: onBoardingList.onBoardingList.length,
              controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
                onBoardingList.changeSelectIndex(index);
                },
              itemBuilder: (context,index){
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(onBoardingList.onBoardingList[index]['image'],fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                      Positioned(
                        bottom:Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex==0||
                            Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex==1?
                        0+130:MediaQuery.of(context).size.height*.8,
                        right:Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex==0?
                        0+40:
                        Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex==1?
                        0+80:0+40,
                        child: Text(getTranslated(onBoardingList.onBoardingList[index]['title'], context)!,
                      textAlign: TextAlign.center,
                        style:const TextStyle(
                          fontSize: 40,
                            height: 0.90,
                            fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,color:ColorResources.onBoardingTextColor
                        ),
                        ),
                      ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 45,
                            margin: const EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.paddingSizeThirtyFive),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor,
                                ])),
                                      child: TextButton(
                                        onPressed: () {
                                          if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
                                            Provider.of<SplashProvider>(context, listen: false).disableIntro();
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
                                          } else {
                                            _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                          }
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1
                                              ? getTranslated('GET_STARTED', context)! : getTranslated('NEXT', context)!,
                                              style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
                                        ),
                                      ),
                                    ),
                        ),

                  ],
                );
              });
        }
      )
      // Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Provider.of<ThemeProvider>(context).darkTheme ? const SizedBox() : SizedBox(
      //       width: double.infinity,
      //       height: double.infinity,
      //       child: Image.asset(Images.background, fit: BoxFit.fill),
      //     ),
      //     Consumer<OnBoardingProvider>(
      //       builder: (context, onBoardingList, child) =>
      //           ListView(
      //         children: [
      //           // SizedBox(
      //           //   height: height*0.7,
      //           //   child: PageView.builder(
      //           //     itemCount: onBoardingList.onBoardingList.length,
      //           //     controller: _pageController,
      //           //     itemBuilder: (context, index) {
      //           //       return Padding(
      //           //         padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      //           //         child: Stack(
      //           //           children: [
      //           //             Image.asset(onBoardingList.onBoardingList[index]['image'], fit: BoxFit.cover,),
      //           //             // Text(onBoardingList.onBoardingList[index].title, style: titilliumBold.copyWith(fontSize: height*0.035), textAlign: TextAlign.center),
      //           //             // Text(onBoardingList.onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular.copyWith(
      //           //             //   fontSize: height*0.015,
      //           //             // )),
      //           //           ],
      //           //         ),
      //           //       );
      //           //     },
      //           //     onPageChanged: (index) {
      //           //       onBoardingList.changeSelectIndex(index);
      //           //     },
      //           //   ),
      //           // ),
      //           // Column(
      //           //   children: [
      //           //     const SizedBox(height: 50),
      //           //     Padding(
      //           //       padding: const EdgeInsets.only(bottom: 20),
      //           //       child: Row(
      //           //         mainAxisAlignment: MainAxisAlignment.center,
      //           //         children: _pageIndicators(onBoardingList.onBoardingList, context),
      //           //       ),
      //           //     ),
      //           //     Container(
      //           //       height: 45,
      //           //       margin: const EdgeInsets.symmetric(horizontal: 70, vertical: Dimensions.paddingSizeSmall),
      //           //       decoration: BoxDecoration(
      //           //           borderRadius: BorderRadius.circular(6),
      //           //           gradient: LinearGradient(colors: [
      //           //             Theme.of(context).primaryColor,
      //           //             Theme.of(context).primaryColor,
      //           //             Theme.of(context).primaryColor,
      //           //           ])),
      //           //       child: TextButton(
      //           //         onPressed: () {
      //           //           if (Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex == onBoardingList.onBoardingList.length - 1) {
      //           //             Provider.of<SplashProvider>(context, listen: false).disableIntro();
      //           //             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
      //           //           } else {
      //           //             _pageController.animateToPage(Provider.of<OnBoardingProvider>(context, listen: false).selectedIndex+1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      //           //           }
      //           //         },
      //           //         child: Container(
      //           //           width: double.infinity,
      //           //           alignment: Alignment.center,
      //           //           child: Text(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1
      //           //               ? getTranslated('GET_STARTED', context)! : getTranslated('NEXT', context)!,
      //           //               style: titilliumSemiBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
      //           //         ),
      //           //       ),
      //           //     ),
      //           //   ],
      //           // ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  List<Widget> _pageIndicators(var onBoardingList, BuildContext context) {
    List<Container> indicators = [];

    for (int i = 0; i < onBoardingList.length; i++) {
      indicators.add(
        Container(
          width: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? 18 : 7,
          height: 7,
          margin: const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            color: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: i == Provider.of<OnBoardingProvider>(context).selectedIndex ? BorderRadius.circular(50) : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return indicators;
  }
}
