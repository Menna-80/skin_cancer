import 'package:dio/dio.dart';

/*class DioHelper{
  static Dio? dio;
  static init(){
    dio =Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        //connectTimeout: 500,
       // receiveTimeout: 500,
    ),
    );
  }
  static Future<Response?> getData({
  required String url,
  required  Map<String,dynamic> query,
}) async
  {
    return await dio?.get(url,queryParameters: query,);
  }
}*/
class DioHelper {
  static Dio dio=Dio();
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
         ),
    );
  }

  static Future<Response?> getData({
    required String url,
     Map<String, dynamic>? query,
     String lang='en',
    String? token,
  }) async {
    dio.options.headers=
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };

    return await dio.get(
      url,
      queryParameters: query??null,
    );
  }
  static Future<Response?> postData({
    required String url,
    required  Map<dynamic, dynamic> data,
    Map<String , dynamic>? query,
    String lang='en',
    String? token,
  }) async {
    dio.options.headers=
    {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token??'',
    };


    return  dio.post(
      url,
      data: data,
      queryParameters: query??null,

    );
  }
}
