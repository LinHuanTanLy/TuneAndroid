import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';
import 'package:flutterdemo/utils/toast/TsUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var leftRightPadding = 40.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "images/android.jpg";

  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();

  WidgetsUtils widgetsUtils;

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
        appBar: new AppBar(
          title: widgetsUtils.getAppBar('登录'),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new Image.asset(
                LOGO,
                fit: BoxFit.fitWidth,
              ),
              width: widgetsUtils.screenWidth,
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 40.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userNameController,
                decoration: new InputDecoration(hintText: "请输入用户名"),
                obscureText: false,
              ),
            ),
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _userPassController,
                decoration: new InputDecoration(hintText: "请输入用户密码"),
                obscureText: true,
              ),
            ),
            new InkWell(
              child: new Container(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    '没有账号？马上注册',
                    style: hintTips,
                  ),
                  padding: new EdgeInsets.fromLTRB(
                      leftRightPadding, 10.0, leftRightPadding, 0.0)),
              onTap: (() {}),
            ),
            new Container(
              width: 360.0,
              margin: new EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
              padding: new EdgeInsets.fromLTRB(leftRightPadding,
                  topBottomPadding, leftRightPadding, topBottomPadding),
              child: new Card(
                color: Color(0xFF63CA6C),
                elevation: 6.0,
                child: new FlatButton(
                    onPressed: () {
                      _postLogin(
                          _userNameController.text, _userPassController.text);
                    },
                    child: new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text(
                        '马上登录',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    )),
              ),
            )
          ],
        ));
  }

  _postLogin(String userName, String userPassword) {
    userName='15622715239';
    userPassword='123456';
    if (userName.isNotEmpty && userPassword.isNotEmpty) {
      Map<String, String> params = new Map();
      params['username'] = userName;
      params['password'] = userPassword;
      Http.post(Api.USER_LOGIN, params: params,saveCookie: true).then((result) {

      });
    } else {
      TsUtils.showShort('请输入用户名和密码');
    }
  }
}
