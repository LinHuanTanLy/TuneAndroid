import 'package:flutterdemo/domain/UserInfoBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SpUtils {
  static const SP_ID = 'sp_id';
  static const SP_NAME = 'sp_name';
  static const SP_GENDER = 'sp_gender';
  static const SP_AVATAR = 'sp_avatar';
  static const SP_EMAIL = 'sp_email';
  static const SP_URL = 'sp_url';

  static const SP_ACCESS_TOKEN = 'sp_access_token';
  static const SP_REFRESH_TOKEN = 'sp_refresh_token';
  static const SP_UID = 'sp_uid';
  static const SP_TOKEN_TYPE = 'sp_token_type';
  static const SP_EXPIRES_IN = 'sp_expires_in';

  static const SP_COOKIE = 'sp_cookie';

// 保存用户信息
  static void saveUserInfo(UserInfoBean userInfo) async {
    if (userInfo != null) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(SP_ID, userInfo.id.toString());
      sharedPreferences.setString(SP_NAME, userInfo.name);
      sharedPreferences.setString(SP_GENDER, userInfo.gender);
      sharedPreferences.setString(SP_AVATAR, userInfo.avatar);
      sharedPreferences.setString(SP_EMAIL, userInfo.email);
      sharedPreferences.setString(SP_URL, userInfo.url);
    }
  }

//  获取用户信息
  static Future<UserInfoBean> getUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString(SP_ID);
    var name = sharedPreferences.getString(SP_NAME);
    var gender = sharedPreferences.getString(SP_GENDER);
    var avatar = sharedPreferences.getString(SP_AVATAR);
    var email = sharedPreferences.getString(SP_EMAIL);
    var url = sharedPreferences.getString(SP_URL);
    UserInfoBean userInfoBean =
        new UserInfoBean(id, name, gender, avatar, email, url);
    return userInfoBean;
  }

//  把map转为UserInfoBean
  static Future<UserInfoBean> map2UserInfo(Map map) async {
    if (map != null) {
      var id = map['id'];
      var name = map['name'];
      var gender = map['gender'];
      var avatar = map['avatar'];
      var email = map['email'];
      var url = map['url'];
      UserInfoBean userInfoBean =
          new UserInfoBean(id, name, gender, avatar, email, url);
      return userInfoBean;
    } else {
      return null;
    }
  }

//  保存token等信息
  static void saveTokenInfo(Map map) async {
    if (map != null) {
      var accessToken = map['access_token'];
      var refreshToken = map['refresh_token'];
      var uid = map['uid'];
      var tokenType = map['token_type'];
      var expiresIn = map['expires_in'];

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString(SP_ACCESS_TOKEN, accessToken);
      sp.setString(SP_REFRESH_TOKEN, refreshToken);
      sp.setString(SP_UID, uid.toString());
      sp.setString(SP_TOKEN_TYPE, tokenType);
      sp.setString(SP_EXPIRES_IN, expiresIn.toString());
    }
  }

//获取accessToken;
  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var accessToken = sharedPreferences.getString(SP_ACCESS_TOKEN);
    return accessToken;
  }

  static void saveCookie(var cookie) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(SP_COOKIE, cookie);
  }

  static Future<String> getCookie() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var cookieStr = sharedPreferences.getString(SP_COOKIE);
    return cookieStr;
  }
}
