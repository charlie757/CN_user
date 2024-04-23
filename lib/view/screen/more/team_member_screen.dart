import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/team_member_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/view_member_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/member_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/member_shimmer_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/button/custom_button.dart';
import '../../basewidget/search_widget.dart';
import '../../basewidget/show_custom_snakbar.dart';

class TeamMemberScreen extends StatefulWidget {
  const TeamMemberScreen({Key? key}) : super(key: key);

  @override
  State<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends State<TeamMemberScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<TeamMemberProvider>(context,listen: false);
    provider.clearValues();
    provider.getDirectMemberApiFunction();
    provider.getTotalMemberApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    // print(profileProvider.userInfoModel!.totalDirectMember??'');
    return Consumer<TeamMemberProvider>(
      builder: (context,myProvider, child) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            title: Text(getTranslated('teamMember', context)!),
          ),
          body: Column(
            children: [
              customTabBar(myProvider,profileProvider),
              searchBar(myProvider),
              const SizedBox(height: 10,),
              Expanded(child:
              myProvider.isSelectedTabBar==0?
                  myProvider.isDirectLoading?
                  shimmerMemberWidget():
              directMembersWidget(myProvider,):
              myProvider.isTeamMemberLoading?
              shimmerMemberWidget():
              totalMemberWidget(myProvider),)
            ],
          ),
        );
      }
    );
  }


  customTabBar(TeamMemberProvider provider, ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10,top: 15),
      child: Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provider.isSelectedTabBar != 0) {
                  provider.updateSelectedTabBar(0);
                }
              },
              child: Column(
                children: [
                  Text("${getTranslated('directMember', context)!} (${
            profileProvider.userInfoModel!!=null&&profileProvider.userInfoModel!.totalDirectMember!=null?
                      profileProvider.userInfoModel!.totalDirectMember.toString():'0'})",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        color: provider.isSelectedTabBar == 0
                            ? ColorResources.black
                            : ColorResources.black.withOpacity(.6),
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 1,
                    color: provider.isSelectedTabBar == 0
                        ? ColorResources.black
                        : ColorResources.borderD9Color,
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provider.isSelectedTabBar != 1) {
                  provider.updateSelectedTabBar(1);
                }
              },
              child: Column(
                children: [
                  Text("${getTranslated('totalMembersTo', context)!} (${
                      profileProvider.userInfoModel!!=null&&profileProvider.userInfoModel!.totalMember!=null?
                      profileProvider.userInfoModel!.totalMember.toString():'0'})",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Ubuntu',
                        color: provider.isSelectedTabBar == 1
                            ? ColorResources.black
                            : ColorResources.black.withOpacity(.6),
                        fontWeight: FontWeight.w500),

                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 1,
                    color: provider.isSelectedTabBar == 1
                        ? ColorResources.black
                        : ColorResources.borderD9Color,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  directMembersWidget(TeamMemberProvider provider,){
    return provider.isDirectMemberSearch&&provider.searchDirectMemberList.isEmpty?
    Center(
      child: Text(getTranslated('no_data_found', context)!),
    ):
    provider.directMemberList.isEmpty?
    Center(
      child: Text(getTranslated('no_data_found', context)!),
    ):
    ListView.separated(
      separatorBuilder: (context,sp){
        return const SizedBox(height: 15,);
      },
      itemCount:provider.isDirectMemberSearch?
      provider.searchDirectMemberList.length:
      provider.directMemberList.length,
      shrinkWrap: true,
        padding:const EdgeInsets.only(left: 15,right: 15,bottom: 50),
      itemBuilder: (context,index) {
        var model = provider.isDirectMemberSearch?
        provider.searchDirectMemberList[index]:
        provider.directMemberList[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorResources.white,
            boxShadow: [
              BoxShadow(
                offset:const Offset(0, -2),
                color: ColorResources.black.withOpacity(.1),
                blurRadius: 10
              )
            ]
          ),
          padding:const EdgeInsets.only(left: 12,right: 12,top: 15,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowMemberWidget('memberId', model.memberId??"", context),
              const SizedBox(height: 10,),
              rowMemberWidget('memberName', model.memberName??"", context),
              const SizedBox(height: 10,),
              rowMemberWidget('EMAIL', model.memberEmail??"", context),
              const SizedBox(height: 10,),
              rowMemberWidget('contactNumber', model.memberNumber.toString()??"", context),
              const SizedBox(height: 10,),
              rowMemberWidget('REFERAL', model.referralCode??"", context),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  viewMemberButton(model.memberId.toString()),
                 shareMemberWidget(context,(){
                    Share.share(model.referralUrl??
                        '');
                  }),
                ],
              )
             ],
          ),
        );
      }
    );
  }

  totalMemberWidget(TeamMemberProvider provider){
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollStartNotification) {
        } else if (scrollNotification is ScrollUpdateNotification) {
        } else if (scrollNotification is ScrollEndNotification) {
          if (scrollNotification.metrics.pixels >=
              scrollNotification.metrics.maxScrollExtent - 20) {
            print('object');
            provider.isTotalMemberSearch?
                provider.getSearchTotalMemberPaginationApiFunction(provider.searchTotalMemberText):
            provider.getTotalMemberPaginationApiFunction();
          }
        }
        return true;
      },

      child: provider.isTotalMemberSearch&&provider.searchTotalMemberList.isEmpty?
      Center(
        child: Text(getTranslated('no_data_found', context)!),
      ):provider.totalMemberList.isEmpty?
      Center(
        child: Text(getTranslated('no_data_found', context)!),
      ): Stack(
        children: [
          ListView.separated(
              separatorBuilder: (context,sp){
                return const SizedBox(height: 15,);
              },
              itemCount:provider.isTotalMemberSearch?
              provider.searchTotalMemberList.length:
              provider.totalMemberList.length,
              shrinkWrap: true,
              physics:const ScrollPhysics(),
              padding:const EdgeInsets.only(left: 15,right: 15,bottom: 50),
              itemBuilder: (context,index) {
                var model = provider.isTotalMemberSearch?
                provider.searchTotalMemberList[index]:
                provider.totalMemberList[index];
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorResources.white,
                      boxShadow: [
                        BoxShadow(
                            offset:const Offset(0, -2),
                            color: ColorResources.black.withOpacity(.1),
                            blurRadius: 10
                        )
                      ]
                  ),
                  padding:const EdgeInsets.only(left: 12,right: 12,top: 15,bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowMemberWidget('memberId', model.memberId??"", context),
                      const SizedBox(height: 10,),
                      rowMemberWidget('memberName', model.memberName??"", context),
                      const SizedBox(height: 10,),
                      rowMemberWidget('EMAIL', model.memberEmail??"", context),
                      const SizedBox(height: 10,),
                      rowMemberWidget('contactNumber', model.memberNumber.toString()??"", context),
                      const SizedBox(height: 10,),
                      rowMemberWidget('REFERAL', model.referralCode??"", context),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          viewMemberButton(model.memberId.toString()),
                          shareMemberWidget(context,(){
                            Share.share(
                                model.referralUrl??
                                    '');

                          }),
                        ],
                      )

                    ],
                  ),
                );
              }
          ),
          provider.isScrollDownData?
          const  Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator()):Container()
        ],
      ),
    );

  }

  viewMemberButton(String id){
    return  GestureDetector(
      onTap: (){
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => ViewMemberScreen(
          id: id,
        )));
      },
      child: Container(
        // width: 100,
        height: 40,
        padding:const EdgeInsets.only(left: 8,right: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorResources.appThemeColor,
        ),
        child:  Text(getTranslated('view_member', context)!,
            style:
            titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault,color: ColorResources.white)),
      ),
    );
  }

  searchBar(TeamMemberProvider provider){
    return  Container(
      margin:const EdgeInsets.only(left: 15,right: 15),
      decoration: BoxDecoration(color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2),)],
      ),
      child: Row(
        children: [
          Expanded(child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.paddingSizeSmall),
                    bottomLeft: Radius.circular(Dimensions.paddingSizeSmall))
            ),
            child: Padding(
              padding:const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: Dimensions.paddingSizeSmall,
              ),
              child: TextFormField(
                controller: provider.isSelectedTabBar==0?
                provider.searchDirectMemberController:provider.searchTotalMemberController,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: getTranslated('SEARCH_MEMBER', context)!,
                  isDense: true,
                  hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                  border: InputBorder.none,
                  suffixIcon:provider.isSelectedTabBar==0&& provider.searchDirectMemberText.isNotEmpty ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      provider.searchDirectMemberController.clear();
                      provider.searchDirectMemberText='';
                      provider.isDirectMemberSearch=false;
                      provider.searchDirectMemberList.clear();
                      setState(() {
                      });
                    },
                  ) :
                  provider.isSelectedTabBar==1&& provider.searchTotalMemberText.isNotEmpty ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      provider.searchTotalMemberController.clear();
                      provider.searchTotalMemberText='';
                      provider.isTotalMemberSearch=false;
                      provider.searchTotalMemberList.clear();
                      setState(() {
                      });
                    },
                  ):
                  null,
                ),
                onChanged: (val){
                  if(provider.isSelectedTabBar==0){
                    provider.searchDirectMemberText = val;
                  }
                  else{
                    provider.searchTotalMemberText = val;
                  }
                  setState(() {

                  });
                },
              ),
            ),
          )),
          InkWell(
            onTap: (){
              // provider.getTotalMemberApiFunction();
              if(provider.isSelectedTabBar==0&& provider.searchDirectMemberText.isEmpty){
                showCustomSnackBar(getTranslated('enter_members_to_search', context), context);
              }
              else if(provider.isSelectedTabBar==1&& provider.searchTotalMemberText.isEmpty){
                showCustomSnackBar(getTranslated('enter_members_to_search', context), context);
              }
              else{
                if(provider.isSelectedTabBar==0){
                  provider.isDirectMemberSearch=true;
                  provider.getSearchMemberApiFunction(provider.searchDirectMemberText);
              }
                else{
                  provider.isTotalMemberSearch=true;
                  provider.getSearchTotalMemberApiFunction(provider.searchTotalMemberText);
                }
              }
              setState(() {

              });
            },
            child: Container(
              width: 55,height: 50,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeSmall),
                    bottomRight: Radius.circular(Dimensions.paddingSizeSmall))
            ),
              child: Icon(Icons.search, color: Theme.of(context).cardColor, size: Dimensions.iconSizeSmall),
            ),
          )
        ],
      )
    );
  }

}
