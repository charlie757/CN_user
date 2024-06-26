import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/seller_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class SellerProvider extends ChangeNotifier {
  final SellerRepo? sellerRepo;
  SellerProvider({required this.sellerRepo});

  bool isLoading = false;

  updateLoading(value){
    isLoading = value;
    notifyListeners();
  }
  List<SellerModel> _orderSellerList = [];
  SellerModel? _sellerModel;

  List<SellerModel> get orderSellerList => _orderSellerList;
  SellerModel? get sellerModel => _sellerModel;

  void initSeller(String sellerId, BuildContext context) async {
    _orderSellerList =[];
    // _sellerModel=null;
    updateLoading(true);
    ApiResponse apiResponse = await sellerRepo!.getSeller(sellerId);
    updateLoading(false);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderSellerList =[];
      print("fsgvdfgd....${apiResponse.response!.data}");
      _orderSellerList.add(SellerModel.fromJson(apiResponse.response!.data));
      _sellerModel = SellerModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

}
