import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/animated_custom_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/guest_dialog.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/chat/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/seller/seller_screen.dart';
import 'package:provider/provider.dart';

class SellerView extends StatelessWidget {
  final String sellerId;
  const SellerView({Key? key, required this.sellerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sellerIconSize = 50;
    Provider.of<SellerProvider>(context, listen: false).initSeller(sellerId, context);

    return Consumer<SellerProvider>(
      builder: (context, seller, child) {
        return
          seller.sellerModel != null ?
        Container(
          margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: sellerIconSize,height: sellerIconSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sellerIconSize),
                  border: Border.all(width: .5,color: Theme.of(context).hintColor)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(sellerIconSize),
                  child:
                  CachedNetworkImage(
                    imageUrl:'${Provider.of<SplashProvider>(context,listen: false).baseUrls!.shopImageUrl}/${seller.sellerModel!.seller!.shop!.image}',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(Images.placeholder,fit: BoxFit.cover,height: MediaQuery.of(context).size.width),
                    errorWidget: (context, url, error) => Image.asset(Images.placeholder_3x1, fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
                  ),

                ),

              ),
              const SizedBox(width: Dimensions.paddingSizeSmall,),


              Expanded(
                child: Column(children: [
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SellerScreen(seller: seller.sellerModel))),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(seller.sellerModel != null ? seller.sellerModel!.seller!.shop!.name ?? ''  : '',
                              style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                            ),

                            Text(seller.sellerModel != null ?
                            '${seller.sellerModel!.seller!.fName ?? ''} ${seller.sellerModel!.seller!.lName ?? ''}'  : '',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
                            ),
                            Text(seller.sellerModel != null ?
                            seller.sellerModel!.seller!.email ?? '' : '',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
                            ),
                            Text(seller.sellerModel != null ?
                            seller.sellerModel!.seller!.phone ?? '' : '',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
                            ),
                            Text(seller.sellerModel != null&&seller.sellerModel!.seller!.shop!=null ?
                            "${seller.sellerModel!.seller!.shop!.address ?? ''}""${seller.sellerModel!.seller!.shop!.city!=null? ", ${seller.sellerModel!.seller!.shop!.city}": ''}"
                                " ${seller.sellerModel!.seller!.shop!.state!=null?", ${seller.sellerModel!.seller!.shop!.state}":'' }"
                                " ${seller.sellerModel!.seller!.shop!.country!=null?", ${seller.sellerModel!.seller!.shop!.country}" : ''}"
                                " ${seller.sellerModel!.seller!.shop!.zipCode!=null?", ${seller.sellerModel!.seller!.shop!.zipCode}" : ''}" : '',
                              style: titleRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),
                            ),

                          ],
                        ),
                      ),
                    ),


                    // InkWell(
                    //   onTap: () {
                    //     if(!Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
                    //       showAnimatedDialog(context, const GuestDialog(), isFlip: true);
                    //     }else if(seller.sellerModel != null) {
                    //       Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(
                    //           id: seller.sellerModel!.seller!.id,
                    //           name: seller.sellerModel!.seller!.shop!.name,
                    //       )));
                    //     }
                    //   },
                    //   child: Image.asset(Images.chatImage, height: Dimensions.iconSizeDefault),
                    // ),
                  ]),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


                  seller.sellerModel != null?
                  Row(children: [
                    Column(children: [
                      Text(seller.sellerModel!.totalReview.toString(),
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                      Text(getTranslated('reviews', context)!,
                        style: titleRegular.copyWith(color: Theme.of(context).hintColor),),
                    ],),
                    const SizedBox(width: Dimensions.paddingSizeExtraLarge),


                    Column(children: [
                      Text(seller.sellerModel!.totalProduct.toString(),
                        style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                      Text(getTranslated('products', context)!,
                        style: titleRegular.copyWith(color: Theme.of(context).hintColor),),

                    ],),
                    const Spacer(),


                   InkWell(
                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SellerScreen(seller: seller.sellerModel))),
                     child: Container(
                       width: 100,height: 30,
                       decoration: BoxDecoration(
                         color: ColorResources.visitShop(context),
                         borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge)
                       ),
                       child: Center(child: Text(getTranslated('visit_store', context)!,
                         style: titleRegular.copyWith(color: Theme.of(context).primaryColor),)),
                     ),
                   )
                  ]):const SizedBox(),
                ]),
              ),
            ],
          ),
        ):const SizedBox();
      },
    );
  }
}
