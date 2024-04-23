
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';

rowMemberWidget(String title, String subTitle, BuildContext context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 115,
        child: Text(getTranslated(title, context)!,
            style:
            titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),
      ),
      Expanded(
        child: Text(subTitle,
            textAlign: TextAlign.end,
            style:
            titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w500,
                color: Colors.grey
            )),
      ),

    ],
  );
}

shareMemberWidget(BuildContext context,Function()onTap){
  return Align(
    alignment: Alignment.centerRight,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorResources.appThemeColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getTranslated('SHARE', context)!,
                style:
                titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.white)),
          const SizedBox(width: 10,),
            Icon(Icons.share,size: 20,color: ColorResources.white,)
          ],
        ),
      ),
    ),
  );
}