import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/view_member_repo.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/member_model.dart';
import '../helper/api_checker.dart';

class ViewMemberProvider extends ChangeNotifier{
  final ViewMemberRepo? viewMemberRepo;
  ViewMemberProvider({required this.viewMemberRepo});
  List<MemberModel> memberList =[];
  bool isLoading = false;
final searchMemberController =TextEditingController();
String searchMemberText = '';
bool isMemberSearch = false;
List <MemberModel>searchMemberList = [];

  Future<void> getMemberApiFunction(String id) async {
    isMemberSearch=false;
    searchMemberController.clear();
    searchMemberText='';
    searchMemberList.clear();
    memberList.clear();
    isLoading=true;
    ApiResponse apiResponse = await viewMemberRepo!.getViewMemberList(id);
    isLoading=false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        MemberModel model = MemberModel.fromJson(element);
        memberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }


  Future<void> getSearchMemberApiFunction(String id, String query) async {
    searchMemberList.clear();
    isLoading = true;
    ApiResponse apiResponse = await viewMemberRepo!.getSearchMemberList(id, query);
    isLoading = false;
    // print(apiResponse.error);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      apiResponse.response!.data.forEach((element) {
        print("elem...$element");
        MemberModel model = MemberModel.fromJson(element);
        searchMemberList.add(model);
      });
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }
}