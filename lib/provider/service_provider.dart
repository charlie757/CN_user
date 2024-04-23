import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/service_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/service_repo.dart';

import '../data/model/response/base/api_response.dart';
import '../helper/api_checker.dart';

class ServiceProvider extends ChangeNotifier{
 final ServiceRepo? serviceRepo;
  ServiceProvider({required this.serviceRepo});

  bool isLoading =false;

 List<String> lOffsetList = [];
 List<Services> serviceList = [];
 int? lPageSize;
 bool firstLoading = false;
 int? _latestPageSize = 1;
 int _lOffset = 1;


 List<int> _offsetList = [];
 List<String> _lOffsetList = [];
 int? get latestPageSize => latestPageSize;
 int get lOffset => _lOffset;
 updateLoadingStatus(value){
  isLoading=value;
  notifyListeners();
 }
 void showBottomLoader() {
  isLoading = true;
  firstLoading = true;
  notifyListeners();
 }

 Future<void> getLProductList(int offset, {bool reload = false}) async {
  if(reload) {
   _lOffsetList = [];
   serviceList=[];
   // _lProductList = [];
  }
  _lOffset = offset;
  if(!lOffsetList.contains(offset)) {
   lOffsetList.add(offset.toString());
   updateLoadingStatus(true);
   ApiResponse apiResponse = await serviceRepo!.getServiceList(offset.toString());
   updateLoadingStatus(false);
   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
    serviceList.addAll(ServiceModel.fromJson(apiResponse.response!.data).services!);
    lPageSize = ServiceModel.fromJson(apiResponse.response!.data).totalSize;
    // firstLoading = false;
    // isLoading = false;
   } else {
    ApiChecker.checkApi( apiResponse);
   }
   notifyListeners();
  }else {
   if(isLoading) {
    isLoading = false;
    notifyListeners();
   }
  }

 }


}