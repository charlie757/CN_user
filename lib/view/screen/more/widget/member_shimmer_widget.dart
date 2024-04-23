

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utill/color_resources.dart';

shimmerMemberWidget(){
  return Shimmer.fromColors(
    baseColor: Colors.grey[200]!,
    highlightColor: Colors.grey[100]!,
    child: ListView.separated(
        padding:const EdgeInsets.only(left: 15,right: 15,bottom: 50),
        separatorBuilder: (context,sp){
          return const SizedBox(height: 15,);
        },
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context,index) {
          return  Container( decoration: BoxDecoration(
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 140,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 140,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 100,
                    ),
                  ],
                ),
                const  SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 140,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 140,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 140,
                    ),
                    Container(
                      color: Colors.grey,
                      height: 10,
                      width: 100,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    ),
  );
}
