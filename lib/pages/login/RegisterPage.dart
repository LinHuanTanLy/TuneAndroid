import 'package:flutter/material.dart';
import 'package:flutterdemo/app/OsApplication.dart';
import 'package:flutterdemo/domain/event/LoginEvent.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';
import 'package:flutterdemo/utils/toast/TsUtils.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  WidgetsUtils widgetsUtils;
  var _userPassController = new TextEditingController();
  var _userNameController = new TextEditingController();
  var _passWordConfirmController = new TextEditingController();

  var leftRightPadding = 40.0;
  var topBottomPadding = 4.0;
  var textTips = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black26);
  static const LOGO = "images/android.jpg";

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
            new Padding(
              padding: new EdgeInsets.fromLTRB(
                  leftRightPadding, 30.0, leftRightPadding, topBottomPadding),
              child: new TextField(
                style: hintTips,
                controller: _passWordConfirmController,
                decoration: new InputDecoration(hintText: "请再次输入用户密码"),
                obscureText: true,
              ),
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
                      _postRegister(
                          _userNameController.text,
                          _userPassController.text,
                          _passWordConfirmController.text);
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

  void _postRegister(
      String userName, String password, String passWordConfirm) {
    if (userName.isNotEmpty && password.isNotEmpty && passWordConfirm.isNotEmpty) {
        if(password==passWordConfirm){
          Map<String, String> params = new Map();
          params['username'] = userName;
          params['password'] = password;
          params['repassword'] = passWordConfirm;
          Http.post(Api.USER_REGISTER, params: params, saveCookie: true)
              .then((result) {
            SpUtils.map2UserInfo(result).then((userInfoBean) {
              if (userInfoBean != null) {
                OsApplication.eventBus.fire(new LoginEvent(userInfoBean.username));
                SpUtils.saveUserInfo(userInfoBean);
                Navigator.pop(context);
              }
            });
          });
        }else{
          TsUtils.showShort('两次密码不一致哟~');
        }
    } else {
      TsUtils.showShort('请输入用户名和密码');
    }
  }
}
