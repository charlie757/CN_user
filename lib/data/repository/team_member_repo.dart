import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class TeamMemberRepo {
  final DioClient? dioClient;
  TeamMemberRepo({required this.dioClient});

  Future<ApiResponse> addMember(var body) async {
    try {
      final Response response =
      await dioClient!.post(AppConstants.addMemeberUrl, data: body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDirectMemberList() async {
    try {
      final response = await dioClient!.get(AppConstants.directMemberUri);
      // log(response.data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTotalMemberList(String pageCount) async {
    try {
      final response = await dioClient!.get("${AppConstants.totalMemberUri}page=$pageCount");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserMemberList(String id) async {
    try {
      final response = await dioClient!.get("${AppConstants.userTeamMemberUri}$id");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSearchMemberList(String name) async {
    try {
      final response = await dioClient!.get(AppConstants.searchDirectMemberUri + name);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getSearchTotalMemberList(String pageCount, String name) async {
    try {
      final response = await dioClient!.get("${AppConstants.searchTotalMemberUri}$pageCount&search=$name");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
