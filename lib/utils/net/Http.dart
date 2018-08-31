import 'dart:convert';

import 'package:flutterdemo/app/OsApplication.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutterdemo/utils/toast/TsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';

class Http {
//  get 请求
  static Future<dynamic> get(String url,
      {Map<String, String> params, bool saveCookie = false}) async {
    if (params == null) {
      params = new Map();
    }
    String _url = Api.BASE_URL + url;
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=$value" + "&");
      });
      String paramStr = sb.toString();
      print('参数是$params');
      paramStr = paramStr.substring(0, paramStr.length - 1);
      _url += paramStr;
    }
    print('url是$url');
    http.Response res = await http.get(_url);
    if (res.statusCode == 200) {
      var cookie = res.headers['set-cookie'];
      if (saveCookie) {
        SpUtils.saveCookie(cookie);
        OsApplication.cookie = cookie;
      }
      String body = res.body;
      var jsonStr = json.decode(body);
      int errCode = jsonStr['errorCode'];
      if (errCode == 0) {
        dynamic data = jsonStr['data'];
        print('the data of method is $data');
        var result = data;
        return body;
      } else {
        TsUtils.showShort(jsonStr['errorMsg']);
      }
    } else {
      TsUtils.showShort('您的网络好像不太好哟~~~///(^v^)\\\~~~');
    }
//    if (OsApplication.cookie == null) {
//      SpUtils.getCookie().then((cookie) {
//        if (cookie != null) {
//          params['Cookie'] = cookie;
//        }
//        return _doGet(url, params: params, saveCookie: saveCookie);
//      });
//    } else {
//      params['Cookie'] = OsApplication.cookie;
//      return _doGet(url, params: params, saveCookie: saveCookie);
//    }
  }

//  post请求
  static Future<dynamic> post(String url,
      {Map<String, String> params, bool saveCookie = false}) async {
    if (params == null) {
      params = new Map();
    }
    if (OsApplication.cookie == null) {
      SpUtils.getCookie().then((cookie) {
        if (cookie != null) {
          params['Cookie'] = cookie;
        }
        _doPost(url, params: params, saveCookie: saveCookie);
      });
    } else {
      params['Cookie'] = OsApplication.cookie;
      _doPost(url, params: params, saveCookie: saveCookie);
    }
  }

  static Future<dynamic> _doGet(String url,
      {Map<String, String> params, bool saveCookie}) async {
    String _url = Api.BASE_URL + url;
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=$value" + "&");
      });
      String paramStr = sb.toString();
      print('参数是$params');
      paramStr = paramStr.substring(0, paramStr.length - 1);
      _url += paramStr;
    }
    print('url是$url');
    http.Response res = await http.get(_url);
    if (res.statusCode == 200) {
      var cookie = res.headers['set-cookie'];
      if (saveCookie) {
        SpUtils.saveCookie(cookie);
        OsApplication.cookie = cookie;
      }
      String body = res.body;
      var jsonStr = json.decode(body);
      int errCode = jsonStr['errorCode'];
      if (errCode == 0) {
        dynamic data = jsonStr['data'];
        print('the data of method is $data');
        var result = data.toString();
        return result;
      } else {
        TsUtils.showShort(jsonStr['errorMsg']);
      }
    } else {
      TsUtils.showShort('您的网络好像不太好哟~~~///(^v^)\\\~~~');
    }
  }

//  post请求
  static Future<dynamic> _doPost(String url,
      {Map<String, String> params, bool saveCookie}) async {
    print('the params is ${params.toString()}');
    String _url = Api.BASE_URL + url;
    http.Response res = await http.post(_url, body: params);
    if (res.statusCode == 200) {
      var cookie = res.headers['set-cookie'];
      if (saveCookie) {
        SpUtils.saveCookie(cookie);
        OsApplication.cookie = cookie;
      }
      String body = res.body;
      var jsonStr = json.decode(body);
      print('the jsonStr is $jsonStr');
      int errCode = jsonStr['errorCode'];
      if (errCode == 0) {
        var data = jsonStr['data'];
        return data;
      } else {
        TsUtils.showShort(jsonStr['errorMsg']);
      }
    } else {
      TsUtils.showShort('您的网络好像不太好哟~~~///(^v^)\\\~~~');
    }
  }
}
