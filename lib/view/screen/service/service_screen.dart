import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/service/widget/service_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/service_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/no_internet_screen.dart';
import '../../basewidget/product_shimmer.dart';
import '../../basewidget/product_widget.dart';
import '../cart/cart_screen.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    loadData(true);
    super.initState();
  }

  loadData(bool  reload)async{
    await Provider.of<ServiceProvider>(Get.context!, listen: false)
        .getLProductList(1, reload: reload);
  }
  @override
  Widget build(BuildContext context) {

    int offset = 1;
    _scrollController.addListener(() {
      if(_scrollController.position.maxScrollExtent == _scrollController.position.pixels
          && Provider.of<ServiceProvider>(context, listen: false).serviceList!.isNotEmpty
          && !Provider.of<ServiceProvider>(context, listen: false).firstLoading) {
        late int pageSize;
        // if(productType == ProductType.bestSelling || productType == ProductType.topProduct || productType == ProductType.newArrival ||productType == ProductType.discountedProduct ) {
          pageSize = (Provider.of<ServiceProvider>(context, listen: false).latestPageSize!/10).ceil();
          offset = Provider.of<ServiceProvider>(context, listen: false).lOffset;
        // }

        if(offset < pageSize) {
          if (kDebugMode) {
            print('offset =====>$offset and page sige ====>$pageSize');
          }
          offset++;

          if (kDebugMode) {
            print('end of the page');
          }
          Provider.of<ServiceProvider>(context, listen: false).showBottomLoader();

            Provider.of<ServiceProvider>(context, listen: false).getLProductList(offset);

        }else{

        }
      }

    });

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await loadData(true);
            // await Provider.of<FlashDealProvider>(Get.context!, listen: false)
            //     .getMegaDealList(true, false);
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).highlightColor,
                    title: Image.asset(Images.logoWithNameImage, height: 35),
                    // actions: [
                    //   Padding(
                    //     padding: const EdgeInsets.only(right: 12.0),
                    //     child: IconButton(
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (_) => const CartScreen()));
                    //       },
                    //       icon: Stack(clipBehavior: Clip.none, children: [
                    //         Image.asset(
                    //           Images.cartArrowDownImage,
                    //           height: Dimensions.iconSizeDefault,
                    //           width: Dimensions.iconSizeDefault,
                    //           color: ColorResources.getPrimary(context),
                    //         ),
                    //         Positioned(
                    //           top: -4,
                    //           right: -4,
                    //           child: Consumer<CartProvider>(
                    //               builder: (context, cart, child) {
                    //                 return CircleAvatar(
                    //                   radius: 7,
                    //                   backgroundColor: ColorResources.red,
                    //                   child: Text(cart.cartList.length.toString(),
                    //                       style: titilliumSemiBold.copyWith(
                    //                         color: ColorResources.white,
                    //                         fontSize: Dimensions.fontSizeExtraSmall,
                    //                       )),
                    //                 );
                    //               }),
                    //         ),
                    //       ]),
                    //     ),
                    //   ),
                    // ],
                    //
                  ),

                  // Search Button

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.homePagePadding,
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeDefault,
                          Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          // Consumer<ServiceProvider>(
                          //     builder: (ctx, prodProvider, child) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: Dimensions.paddingSizeExtraSmall,
                          //             vertical: Dimensions.paddingSizeExtraSmall),
                          //         child: Row(children: [
                          //           // Expanded(
                          //           //     child: Text(
                          //           //         prodProvider.title == 'xyz'
                          //           //             ? getTranslated(
                          //           //             'new_arrival', context)!
                          //           //             : prodProvider.title!,
                          //           //         style: titleHeader)),
                          //           prodProvider.latestProductList != null
                          //               ? PopupMenuButton(
                          //               itemBuilder: (context) {
                          //                 return [
                          //                   PopupMenuItem(
                          //                       value: ProductType.newArrival,
                          //                       textStyle:
                          //                       robotoRegular.copyWith(
                          //                         color: Theme.of(context)
                          //                             .hintColor,
                          //                       ),
                          //                       child: Text(getTranslated(
                          //                           'new_arrival', context)!)),
                          //                   PopupMenuItem(
                          //                       value: ProductType.topProduct,
                          //                       textStyle:
                          //                       robotoRegular.copyWith(
                          //                         color: Theme.of(context)
                          //                             .hintColor,
                          //                       ),
                          //                       child: Text(getTranslated(
                          //                           'top_product', context)!)),
                          //                   PopupMenuItem(
                          //                       value: ProductType.bestSelling,
                          //                       textStyle:
                          //                       robotoRegular.copyWith(
                          //                         color: Theme.of(context)
                          //                             .hintColor,
                          //                       ),
                          //                       child: Text(getTranslated(
                          //                           'best_selling', context)!)),
                          //                   PopupMenuItem(
                          //                       value: ProductType
                          //                           .discountedProduct,
                          //                       textStyle:
                          //                       robotoRegular.copyWith(
                          //                         color: Theme.of(context)
                          //                             .hintColor,
                          //                       ),
                          //                       child: Text(getTranslated(
                          //                           'discounted_product',
                          //                           context)!)),
                          //                 ];
                          //               },
                          //               shape: RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.circular(
                          //                       Dimensions.paddingSizeSmall)),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     horizontal:
                          //                     Dimensions.paddingSizeSmall,
                          //                     vertical:
                          //                     Dimensions.paddingSizeSmall),
                          //                 child: Image.asset(
                          //                   Images.dropdown,
                          //                   scale: 3,
                          //                 ),
                          //               ),
                          //               onSelected: (dynamic value) {
                          //                 if (value == ProductType.newArrival) {
                          //                   Provider.of<ProductProvider>(
                          //                       context,
                          //                       listen: false)
                          //                       .changeTypeOfProduct(
                          //                       value, types[0]);
                          //                 } else if (value ==
                          //                     ProductType.topProduct) {
                          //                   Provider.of<ProductProvider>(
                          //                       context,
                          //                       listen: false)
                          //                       .changeTypeOfProduct(
                          //                       value, types[1]);
                          //                 } else if (value ==
                          //                     ProductType.bestSelling) {
                          //                   Provider.of<ProductProvider>(
                          //                       context,
                          //                       listen: false)
                          //                       .changeTypeOfProduct(
                          //                       value, types[2]);
                          //                 } else if (value ==
                          //                     ProductType.discountedProduct) {
                          //                   Provider.of<ProductProvider>(
                          //                       context,
                          //                       listen: false)
                          //                       .changeTypeOfProduct(
                          //                       value, types[3]);
                          //                 }
                          //
                          //                 ProductView(
                          //                     isHomePage: false,
                          //                     productType: value,
                          //                     scrollController:
                          //                     _scrollController);
                          //                 Provider.of<ProductProvider>(context,
                          //                     listen: false)
                          //                     .getLatestProductList(1,
                          //                     reload: true);
                          //               })
                          //               : const SizedBox(),
                          //         ]),
                          //       );
                          //     }),
                      Consumer<ServiceProvider>(
                      builder: (context, prodProvider, child) {
                    return Column(children: [
                    !prodProvider.isLoading ?
                    prodProvider.serviceList!.isNotEmpty ?
                    StaggeredGridView.countBuilder(
                    itemCount: prodProvider.serviceList.length,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                    itemBuilder: (BuildContext context, int index) {
                    return ServiceWidget(productModel: prodProvider.serviceList![index]);
                    },
                    ) :
                    const NoInternetOrDataScreen(isNoInternet: false):
                    ProductShimmer(isHomePage: false ,isEnabled: prodProvider.isLoading),

                    prodProvider.firstLoading ? Center(child: Padding(
                    padding: const EdgeInsets.all(Dimensions.iconSizeExtraSmall),
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                    )) : const SizedBox.shrink(),

                    ]);
                    },
                    ),
                      const SizedBox(height: Dimensions.homePagePadding),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
