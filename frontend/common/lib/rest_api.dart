import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const DEBUG_HTTP = true; //print http responses from server

class RestAPI {
  // String serverIP = "http://127.0.0.1:3000";
  // String serverIP = "http://10.0.2.2:3000";
  String serverIP = "http://temporaryurl.ddnsking.com:3000";
  // String serverIP = "https://myschoolerp.azurewebsites.net";
  // CookieJar cookieJar = CookieJar();
  Dio dio = new Dio();
  Response lastResponse;
  Logger logger = new Logger();
  SharedPreferences prefs;
  static const String _defaultContentType = "application/json";
  RestAPI() {
    // dio.interceptors.add(CookieManager(PersistCookieJar(dir: "./cookies")));
    // dio.interceptors.add(PrettyDioLogger());
// customization
    if (DEBUG_HTTP)
      dio.interceptors.add(PrettyDioLogger(
        request: true,
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
        maxWidth: 120,
      ));
    if (!kIsWeb) {
      dio.interceptors.add(CookieManager(CookieJar()));
    } else {
      // dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) async {
      //   // to prevent other request enter this interceptor.
      //   dio.interceptors.requestLock.lock();
      //   // We use a new Dio(to avoid dead lock) instance to request token.
      //   //Set the cookie to headers
      //   options.headers["Authorization"] = "Bearer " + getToken();

      //   dio.interceptors.requestLock.unlock();
      //   return options; //continue
      // }));
    }

    init();
  }
  init() async {
    prefs = await SharedPreferences.getInstance();
    // _token = prefs.getString('token') ?? null;
    // prefs.setString(authTokenKey, token);
  }

  setToken(String token) async {
    await prefs.setString("jwt", token);
  }

  String getToken() {
    return prefs.getString('jwt') ?? '';
  }

  Future<Response> myDioGET({
    String url,
    Map<String, dynamic> queryParameters,
    String contentType = _defaultContentType,
    bool isAuthEnabled = true,
  }) async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    try {
      // if (DEBUG_HTTP) {
      //   print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      //   print("url = " + url);
      // }
      Map<String, dynamic> headers;
      if (isAuthEnabled)
        headers = {
          "Authorization": "Bearer " + getToken(),
        };
      Response response;
      response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          // followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );
      // if (DEBUG_HTTP) {
      //   // logger.d(response);
      //   print("response.statusCode = " + response.statusCode.toString());
      //   print("response.data = " + response.data.toString());
      // }
      lastResponse = response;
      return response;
    } on DioError catch (e) {
      print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      handleError(e);
      lastResponse = e.response;
      return e.response;
    }
  }

  Future<Response> myDioPOST({
    String url,
    dynamic data,
    Map<String, dynamic> queryParameters,
    String contentType = _defaultContentType,
    bool isAuthEnabled = true,
  }) async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    try {
      // if (DEBUG_HTTP) {
      //   print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      //   print("request.url = " + url);
      //   print("request.queryParameters = " + queryParameters.toString());
      //   print("request.data = " + data.toString());
      // }
      Response response;
      Map<String, dynamic> headers;
      if (isAuthEnabled)
        headers = {
          "Authorization": "Bearer " + getToken(),
        };
      response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
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
      // if (DEBUG_HTTP) {
      //   print("response.statusCode = " + response?.statusCode.toString());
      //   print("response.data = " + response?.data.toString());
      //   // logger.d(response.data,null, null);
      // }
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

  Future<Response> myDioPATCH({
    String url,
    dynamic data,
    Map<String, dynamic> queryParameters,
    String contentType = _defaultContentType,
    bool isAuthEnabled = true,
  }) async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    try {
      // if (DEBUG_HTTP) {
      //   print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      //   print("url = " + url);
      // }
      Map<String, dynamic> headers;
      if (isAuthEnabled)
        headers = {
          "Authorization": "Bearer " + getToken(),
        };
      Response response;
      response = await dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: contentType, // or whatever
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );
      // if (DEBUG_HTTP) {
      //   print("response.statusCode = " + response.statusCode.toString());
      //   print("request.queryParameters = " + response.request.queryParameters.toString());
      //   print("request.data = " + response.request.data.toString());
      //   print("response.data = " + response.data.toString());
      // }
      lastResponse = response;
      return response;
    } on DioError catch (e) {
      print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      handleError(e);
      lastResponse = e.response;
      return e.response;
    }
  }

  Future<Response> myDioDELETE({
    String url,
    Map<String, dynamic> queryParameters,
    String contentType = _defaultContentType,
    bool isAuthEnabled = true,
  }) async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    try {
      // if (DEBUG_HTTP) {
      //   print("-------------------- " + Trace.current().frames[1].member + "----------------------------");
      //   print("url = " + url);
      // }
      Map<String, dynamic> headers;
      if (isAuthEnabled)
        headers = {
          "Authorization": "Bearer " + getToken(),
        };
      Response response;
      response = await dio.delete(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          // followRedirects: false,
          validateStatus: (status) {
            return status <= 500;
          },
        ),
      );
      // if (DEBUG_HTTP) {
      //   // logger.d(response);
      //   print("response.statusCode = " + response.statusCode.toString());
      //   print("response.data = " + response.data.toString());
      // }
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
