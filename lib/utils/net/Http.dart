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
        return body;
      } else {
        TsUtils.showShort(jsonStr['errorMsg']);
      }
    } else {
      TsUtils.showShort('您的网络好像不太好哟~~~///(^v^)\\\~~~');
    }
  }

//  post请求
  static Future<Map> post(String url,
      {Map<String, String> params, bool saveCookie = false}) async {
    if (params == null) {
      params = new Map();
    }
    String _url = Api.BASE_URL + url;
    if (OsApplication.cookie != null) {
      params['Cookie'] = OsApplication.cookie;
    }
    http.Response res = await http.post(_url, body: params);
    return _dealWithRes(res, saveCookie: saveCookie);
  }

  static Map<String, dynamic> _dealWithRes(var res, {bool saveCookie}) {
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
