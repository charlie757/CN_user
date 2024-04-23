import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/member_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/team_member_repo.dart';

import '../data/model/response/base/api_response.dart';
import '../helper/api_checker.dart';

class TeamMemberProvider extends ChangeNotifier{
  final TeamMemberRepo teamMemberRepo;
  TeamMemberProvider({required this.teamMemberRepo});

  // DirectMemberModel? model;
  List<MemberModel> directMemberList = [];
  List<MemberModel> totalMemberList =[];

  List<MemberModel> searchDirectMemberList = [];
  List<MemberModel> searchTotalMemberList =[];

  final searchDirectMemberController = TextEditingController();
  final searchTotalMemberController = TextEditingController();
  String searchDirectMemberText = '';
  String searchTotalMemberText = '';
  bool isDirectMemberSearch = false;
  bool isTotalMemberSearch = false;
  int isSelectedTabBar = 0;
  int pageCount = 1;
  int totalItems = 0;
  int searchTotalItems = 0;
  bool isDirectLoading = false;
  bool isTeamMemberLoading= false;
  bool isScrollDownData = false;

  clearValues(){
     isSelectedTabBar = 0;
     pageCount = 1;
     searchTotalItems=0;
     searchDirectMemberText ='';
     searchTotalMemberText ='';
     searchDirectMemberController.clear();
     searchTotalMemberController.clear();
     isTotalMemberSearch=false;
     isDirectMemberSearch=false;
     totalItems = 0;
     isDirectLoading = false;
     isTeamMemberLoading= false;
     isScrollDownData = false;

  }

  updateSelectedTabBar(value){
    isSelectedTabBar=value;
    notifyListeners();
  }

  updateIsScrollDown(value){
    isScrollDownData=value;
    notifyListeners();
  }

updateDirectLoading(value, bool isListener){
  isDirectLoading=value;
  isListener?
  notifyListeners():null;
}

  updateTotalMemberLoading(value,bool isListener){
    isTeamMemberLoading=value;
    isListener?
    notifyListeners():null;
  }

  Future<void> getDirectMemberApiFunction() async {
    directMemberList.clear();
    updateDirectLoading(true,false);
    ApiResponse apiResponse = await teamMemberRepo!.getDirectMemberList();
    updateDirectLoading(false,false);
    print("direct...${apiResponse.error}");
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        MemberModel model = MemberModel.fromJson(element);
        directMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> getSearchMemberApiFunction(String query) async {
    searchDirectMemberList.clear();
    updateDirectLoading(true,true);
    ApiResponse apiResponse = await teamMemberRepo!.getSearchMemberList(query);
    updateDirectLoading(false,true);
    // print(apiResponse.error);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        print("elem...$element");
        MemberModel model = MemberModel.fromJson(element);
        searchDirectMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }

  Future<void> getSearchTotalMemberApiFunction(String query) async {
    // totalMemberList.clear();
    pageCount=1;
    searchTotalMemberList.clear();
    updateTotalMemberLoading(true,true);
    ApiResponse apiResponse = await teamMemberRepo!.getSearchTotalMemberList(pageCount.toString(), query);
    updateTotalMemberLoading(false,true);
    // print(apiResponse.error);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print("total...${apiResponse.response!.data['total']}");
      searchTotalItems = int.parse(apiResponse.response!.data['total'].toString());
      apiResponse.response!.data['data'].forEach((element) {
        print("elem...$element");
        MemberModel model = MemberModel.fromJson(element);
        searchTotalMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> getSearchTotalMemberPaginationApiFunction(String query) async {
    if(searchTotalItems > searchTotalMemberList.length&&isScrollDownData==false){
      pageCount += 1;
    updateTotalMemberLoading(true,true);
    ApiResponse apiResponse = await teamMemberRepo!.getSearchTotalMemberList(pageCount.toString(), query);
    updateTotalMemberLoading(false,true);
    // print(apiResponse.error);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data['data'].forEach((element) {
        print("elem...$element");
        MemberModel model = MemberModel.fromJson(element);
        searchTotalMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }}

  Future<void>  getTotalMemberApiFunction() async {
    totalMemberList.clear();
    pageCount=1;
    updateTotalMemberLoading(true,false);
    ApiResponse apiResponse = await teamMemberRepo!.getTotalMemberList(pageCount.toString());
    updateTotalMemberLoading(false,false);
    // print(apiResponse.error);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      print("total...${apiResponse.response!.data['total']}");
      totalItems = int.parse(apiResponse.response!.data['total'].toString());
      apiResponse.response!.data['data'].forEach((element) {
        print("elem...$element");
        MemberModel model = MemberModel.fromJson(element);
        totalMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> getTotalMemberPaginationApiFunction() async {
    List<MemberModel> list =[];
    if (totalItems > totalMemberList.length&&isScrollDownData==false) {
      updateIsScrollDown(true);
      pageCount += 1;
      print(pageCount);
      ApiResponse apiResponse = await teamMemberRepo!.getTotalMemberList(pageCount.toString());
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        updateIsScrollDown(false);
        apiResponse.response!.data['data'].forEach((element) {
          print("elem...$element");
          MemberModel model = MemberModel.fromJson(element);
          totalMemberList.add(model);
          print(list.length);
          // totalMemberList = totalMemberList+list;
        });
      } else {
        updateIsScrollDown(false);
        ApiChecker.checkApi(apiResponse);
      }
      notifyListeners();
    }
  }
}