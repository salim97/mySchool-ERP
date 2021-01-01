import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart';

const DEBUG_HTTP = true; //print http responses from server

class RestAPI {
  String serverIP = "http://127.0.0.1:3000";
  // String serverIP = "http://10.0.2.2:3000";
  CookieJar cookieJar = CookieJar();
  Dio dio = new Dio();
  Response lastResponse;
  Logger logger = new Logger();

  static const String _defaultContentType = "application/json";
  RestAPI() {
    dio.interceptors.add(CookieManager(cookieJar));
    init();
  }
  init() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _token = prefs.getString('token') ?? null;
    // prefs.setString(authTokenKey, token);
  }

  Future<Response> myDioGET({String url, Map<String, dynamic> queryParameters, String contentType = _defaultContentType}) async {
    try {
      if (DEBUG_HTTP) {
        print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
        print("url = " + url);
      }
      Response response;
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          // followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );
      if (DEBUG_HTTP) {
        // logger.d(response);
        print("response.statusCode = " + response.statusCode.toString());
        print("response.data = " + response.data.toString());
      }
      lastResponse = response;
      return response;
    } on DioError catch (e) {
      print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      handleError(e);
      lastResponse = e.response;
      return e.response;
    }
  }

  Future<Response> myDioPOST(
      {String url,
      dynamic data,
      Map<String, dynamic> queryParameters,
      String contentType = _defaultContentType,
      }) async {
    try {
      if (DEBUG_HTTP) {
        print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
        print("request.url = " + url);
        print("request.queryParameters = " + queryParameters.toString());
        print("request.data = " + data.toString());
      }
      Response response;
      Map<String, dynamic> headers;

      response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType, // or whatever
          // followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
          // connectTimeout: 5000,
          // receiveTimeout: 5000,
          // sendTimeout: 5000,
        ),
      );
      if (DEBUG_HTTP) {
        // print("response.statusCode = " + response?.statusCode.toString());
        print("response.data = " + response?.data.toString());
      }
      lastResponse = response;
      return response;
    } catch (e) {
      print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      print(e);
      //handleError(e);
      lastResponse = e.response;
      return e.response;
    }
  }

  Future<Response> myDioPATCH(
      {String url, dynamic data, Map<String, dynamic> queryParameters, String contentType = _defaultContentType}) async {
    try {
      if (DEBUG_HTTP) {
        print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
        print("url = " + url);
      }
      Response response;
      response = await dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType, // or whatever
          validateStatus: (status) {
            return status <= 500;
          },

        ),
      );
      if (DEBUG_HTTP) {
        print("response.statusCode = " + response.statusCode.toString());
        print("request.queryParameters = " + response.request.queryParameters.toString());
        print("request.data = " + response.request.data.toString());
        print("response.data = " + response.data.toString());
      }
      lastResponse = response;
      return response;
    } on DioError catch (e) {
      print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      handleError(e);
      lastResponse = e.response;
      return e.response;
    }
  }

  void handleError(DioError error) {
    switch (error.response.statusCode) {
      case 403:
        print("You do not have the right privileges to access this resource.");
        break;
      case 422:
        print("The data you have provided is invalid.");
        break;
      case 401:
        print("Incorrect credentials.");
        break;
      case 404:
        print("Request not found.");
        break;
      case 500:
        print("There is something wrong with our servers, please report to the admin so it gets fixed.");
        break;
      default:
        print("Something went wrong. status code =" + error.response.statusCode.toString());
    }
  }
}
