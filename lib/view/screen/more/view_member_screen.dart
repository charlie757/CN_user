import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/view_member_provider.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/member_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/more/widget/member_shimmer_widget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../basewidget/show_custom_snakbar.dart';

class ViewMemberScreen extends StatefulWidget {
  final id;
   ViewMemberScreen({Key? key,this.id}) : super(key: key);

  @override
  State<ViewMemberScreen> createState() => _ViewMemberScreenState();
}

class _ViewMemberScreenState extends State<ViewMemberScreen> {

  @override
  void initState() {
    // TODO: implement initState
    callInitFunction();
    super.initState();
  }

  callInitFunction(){
    final provider = Provider.of<ViewMemberProvider>(context,listen: false);
    provider.getMemberApiFunction(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(getTranslated('teamMember', context)!),
      ),
      body: Consumer<ViewMemberProvider>(
        builder: (context,myProvider, child) {
          return Column(
            children: [
              searchBar(myProvider),
              const SizedBox(height: 10,),
              Expanded(child: myProvider.isLoading?
              shimmerMemberWidget():
              myProvider.memberList.isEmpty?
              Center(child: Text(getTranslated("no_data_found", context)!)):
              membersWidget(myProvider))
            ],
          );
        }
      ),
    );
    
  }

  membersWidget(ViewMemberProvider provider){
    return provider.isMemberSearch&&provider.searchMemberList.isEmpty?
    Center(
      child: Text(getTranslated('no_data_found', context)!),
    ): ListView.separated(
        separatorBuilder: (context,sp){
          return const SizedBox(height: 15,);
        },
        itemCount:provider.isMemberSearch?
        provider.searchMemberList.length:
        provider.memberList.length,
        shrinkWrap: true,
        padding:const EdgeInsets.only(left: 15,right: 15,bottom: 50),
        itemBuilder: (context,index) {
          var model = provider.isMemberSearch?
              provider.searchMemberList[index]:
              provider.memberList[index];
          return GestureDetector(
            onTap: (){
            },
            child: Container(
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
                  rowMemberWidget('memberId', provider.memberList[index].memberId??"", context),
                  const SizedBox(height: 10,),
                  rowMemberWidget('memberName', provider.memberList[index].memberName??"", context),
                  const SizedBox(height: 10,),
                  rowMemberWidget('EMAIL', provider.memberList[index].memberEmail??"", context),
                  const SizedBox(height: 10,),
                  rowMemberWidget('contactNumber', provider.memberList[index].memberNumber.toString()??"", context),
                  const SizedBox(height: 10,),
                  rowMemberWidget('REFERAL', provider.memberList[index].referralCode??"", context),
                  const SizedBox(height: 10,),
                  shareMemberWidget(context,(){
                    Share.share(
                        provider.memberList[index].referralUrl??
                            '');

                  }),

                ],
              ),
            ),
          );
        }
    );
  }


  searchBar(ViewMemberProvider provider){
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
                  controller: provider.searchMemberController,
                  textInputAction: TextInputAction.search,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: getTranslated('SEARCH_MEMBER', context)!,
                    isDense: true,
                    hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor),
                    border: InputBorder.none,
                    suffixIcon:provider.searchMemberText.isNotEmpty ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      onPressed: () {
                        provider.searchMemberController.clear();
                        provider.searchMemberText='';
                        provider.isMemberSearch=false;
                        provider.searchMemberList.clear();
                        setState(() {
                        });
                      },
                    ) :
                    null,
                  ),
                  onChanged: (val){
                      provider.searchMemberText = val;
                    setState(() {
                    });
                  },
                ),
              ),
            )),
            InkWell(
              onTap: (){
                // provider.getTotalMemberApiFunction();
               if(provider.searchMemberText.isEmpty){
                  showCustomSnackBar(getTranslated('enter_members_to_search', context), context);
                }
                else{
                    provider.isMemberSearch=true;
                    provider.getSearchMemberApiFunction(widget.id, provider.searchMemberText);
                    // provider.getSearchTotalMemberApiFunction(provider.searchTotalMemberText);
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
