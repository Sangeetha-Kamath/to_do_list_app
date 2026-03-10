import 'package:dio/dio.dart';

import '../core/constants/api_constants.dart';


class DioService{
   static final DioService _instance = DioService._internal();
   factory DioService()=>_instance;
   DioService._internal();
   late final Dio _dio;
   Dio get dio {
    return _dio;
  }
   void initialize(){
    _dio= Dio(BaseOptions(baseUrl:ApiConstants.baseUrl,
    connectTimeout: const Duration(milliseconds: 3000),
    receiveTimeout: const Duration(milliseconds: 30000),
    responseType: ResponseType.json,
    headers: {
      "Content-Type":"application/json",
      
    } ))..interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      requestUrl: true,
      
    ));
   }
}