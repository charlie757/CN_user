  import 'package:dio/dio.dart';
  import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
  import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
  import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
  import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

  class AddNewMemberRepo {
    final DioClient? dioClient;
    AddNewMemberRepo({required this.dioClient});

    Future<ApiResponse> addMember(var body) async {
      try {
        final Response response =
            await dioClient!.post(AppConstants.addMemeberUrl, data: body);
        return ApiResponse.withSuccess(response);
      } catch (e) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }

    Future<ApiResponse> getCountryList() async {
      try {
        final response = await dioClient!.get(AppConstants.countryUri);
        return ApiResponse.withSuccess(response);
      } catch (e) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }

    Future<ApiResponse> getStateList(String id) async {
      try {
        final response = await dioClient!.get("${AppConstants.stateUri}$id");
        return ApiResponse.withSuccess(response);
      } catch (e) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }

    Future<ApiResponse> getCityList(String id) async {
      try {
        final response = await dioClient!.get("${AppConstants.cityUri}$id");
        return ApiResponse.withSuccess(response);
      } catch (e) {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }
