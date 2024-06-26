import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class ViewMemberRepo {
  final DioClient? dioClient;
  ViewMemberRepo({required this.dioClient});

  Future<ApiResponse> getViewMemberList(String id) async {
    try {
      final response = await dioClient!.get("${AppConstants.userTeamMemberUri}$id");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSearchMemberList(String id, String name) async {
    try {
      final response = await dioClient!.get("${AppConstants.userTeamMemberUri}$id&search=$name");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
