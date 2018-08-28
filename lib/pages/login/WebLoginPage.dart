import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterdemo/domain/UserInfoBean.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';
import 'package:flutterdemo/utils/net/Api.dart';

class WebLoginPage extends StatefulWidget {
  @override
  _WebLoginPageState createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  WidgetsUtils widgetsUtils;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // URL变化监听器
  StreamSubscription<String> _onUrlChanged;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  bool _isShowLoading = true;

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Container(child: homeBody());
  }

  Widget homeBody() {
    return new WebviewScaffold(
      appBar: new AppBar(
        title: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: appBarWidget(),
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      url: Api.LOGIN_URL,
      key: _scaffoldKey,
    );
  }

  List<Widget> appBarWidget() {
    List<Widget> widgets = [];
    widgets.add(widgetsUtils.getAppBar('登录'));
    if (_isShowLoading) {
      widgets.add(new CupertinoActivityIndicator());
    }
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((url) {
      setState(() {
        _isShowLoading = false;
      });
      if (url != null && url.length > 0 && url.contains('osc/osc.php?code=')) {
        new Timer(const Duration(seconds: 1), parseResult());
      }
    });
  }

  parseResult() {
    flutterWebViewPlugin.evalJavascript('get();').then((result) {
      if (result != null && result.length > 0) {
        var map = json.decode(result);
        if (map is String) {
          map = json.decode(map);
        }
        if (map != null) {
          SpUtils.saveTokenInfo(map);
//      使用Navigator的pop返回可返回上一级，并携带一个参数 @link https://www.jianshu.com/p/cb0af52376ba
          Navigator.pop(context, 'refresh');
        }
      } else {
        new Timer(const Duration(seconds: 1), parseResult());
      }
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
