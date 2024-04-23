import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/category.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: MediaQuery.of(context).size.width / 5,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).highlightColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child:
          CachedNetworkImage(
            imageUrl: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.categoryImageUrl}'
          '/${category.icon}',
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(Images.placeholder,fit: BoxFit.cover,),
            errorWidget: (context, url, error) => Image.asset(Images.placeholder_3x1, fit: BoxFit.cover),
          ),
        ),
      ),

      // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      Center(
        child: Text(
          category.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: titilliumRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.getTextTitle(context)),
        ),
      ),
    ]);
  }
}
