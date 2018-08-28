import 'package:flutterdemo/utils/cache/SpUtils.dart';

class ParamsUtils {
  static var accessToken;



  static Map<String, String> getParams() {
    Map<String, String> params = new Map();
      SpUtils.getToken().then((token) {
        params['access_token'] = token;
        accessToken = token;
        print('ParamsUtils-----${params.toString()}');
        return params;
      });
  }
}
