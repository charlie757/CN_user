import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/product/view_all_product_screen.dart';
import 'package:provider/provider.dart';
import '../../../helper/product_type.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/cart_provider.dart';
import '../../../provider/product_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../basewidget/title_row.dart';
import '../cart/cart_screen.dart';
import '../home/home_screens.dart';
import '../home/widget/latest_product_view.dart';
import '../home/widget/products_view.dart';

class NewArrivalProductScreen extends StatefulWidget {
  const NewArrivalProductScreen({Key? key}) : super(key: key);

  @override
  State<NewArrivalProductScreen> createState() => _NewArrivalProductScreenState();
}

class _NewArrivalProductScreenState extends State<NewArrivalProductScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(bool reload) async {
    await Provider.of<ProductProvider>(Get.context!, listen: false)
        .getLatestProductList(1, reload: reload);
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();

    _loadData(false);

    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).uploadToServer(context);
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String?> types = [
    getTranslated('new_arrival', context),
    getTranslated('top_product', context),
    getTranslated('best_selling', context),
    getTranslated('discounted_product', context)
  ];
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(true);
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
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CartScreen()));
                          },
                          icon: Stack(clipBehavior: Clip.none, children: [
                            Image.asset(
                              Images.cartArrowDownImage,
                              height: Dimensions.iconSizeDefault,
                              width: Dimensions.iconSizeDefault,
                              color: ColorResources.getPrimary(context),
                            ),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Consumer<CartProvider>(
                                  builder: (context, cart, child) {
                                    return CircleAvatar(
                                      radius: 7,
                                      backgroundColor: ColorResources.red,
                                      child: Text(cart.cartList.length.toString(),
                                          style: titilliumSemiBold.copyWith(
                                            color: ColorResources.white,
                                            fontSize: Dimensions.fontSizeExtraSmall,
                                          )),
                                    );
                                  }),
                            ),
                          ]),
                        ),
                      ),
                    ],
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
                          Consumer<ProductProvider>(
                              builder: (ctx, prodProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeExtraSmall,
                                      vertical: Dimensions.paddingSizeExtraSmall),
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(
                                            prodProvider.title == 'xyz'
                                                ? getTranslated(
                                                'new_arrival', context)!
                                                : prodProvider.title!,
                                            style: titleHeader)),
                                    prodProvider.latestProductList != null
                                        ? PopupMenuButton(
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                                value: ProductType.newArrival,
                                                textStyle:
                                                robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                                child: Text(getTranslated(
                                                    'new_arrival', context)!)),
                                            PopupMenuItem(
                                                value: ProductType.topProduct,
                                                textStyle:
                                                robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                                child: Text(getTranslated(
                                                    'top_product', context)!)),
                                            PopupMenuItem(
                                                value: ProductType.bestSelling,
                                                textStyle:
                                                robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                                child: Text(getTranslated(
                                                    'best_selling', context)!)),
                                            PopupMenuItem(
                                                value: ProductType
                                                    .discountedProduct,
                                                textStyle:
                                                robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                ),
                                                child: Text(getTranslated(
                                                    'discounted_product',
                                                    context)!)),
                                          ];
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                              Dimensions.paddingSizeSmall,
                                              vertical:
                                              Dimensions.paddingSizeSmall),
                                          child: Image.asset(
                                            Images.dropdown,
                                            scale: 3,
                                          ),
                                        ),
                                        onSelected: (dynamic value) {
                                          if (value == ProductType.newArrival) {
                                            Provider.of<ProductProvider>(
                                                context,
                                                listen: false)
                                                .changeTypeOfProduct(
                                                value, types[0]);
                                          } else if (value ==
                                              ProductType.topProduct) {
                                            Provider.of<ProductProvider>(
                                                context,
                                                listen: false)
                                                .changeTypeOfProduct(
                                                value, types[1]);
                                          } else if (value ==
                                              ProductType.bestSelling) {
                                            Provider.of<ProductProvider>(
                                                context,
                                                listen: false)
                                                .changeTypeOfProduct(
                                                value, types[2]);
                                          } else if (value ==
                                              ProductType.discountedProduct) {
                                            Provider.of<ProductProvider>(
                                                context,
                                                listen: false)
                                                .changeTypeOfProduct(
                                                value, types[3]);
                                          }

                                          ProductView(
                                              isHomePage: false,
                                              productType: value,
                                              scrollController:
                                              _scrollController);
                                          Provider.of<ProductProvider>(context,
                                              listen: false)
                                              .getLatestProductList(1,
                                              reload: true);
                                        })
                                        : const SizedBox(),
                                  ]),
                                );
                              }),
                          ProductView(
                              isHomePage: false,
                              productType: ProductType.newArrival,
                              scrollController: _scrollController),
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

