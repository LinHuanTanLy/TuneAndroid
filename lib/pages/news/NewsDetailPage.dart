import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsDetailPage extends StatefulWidget {
  String _url,_title;


  NewsDetailPage(this._url,this._title);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState(_url,_title);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  WidgetsUtils widgetsUtils;

  bool _isLoading = true;
  String _url ,_title;

  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();
  // URL变化监听器
  StreamSubscription<String> _onUrlChanged;


  _NewsDetailPageState(this._url,this._title);

  @override
  void initState() {
    super.initState();
    _onUrlChanged=flutterWebViewPlugin.onUrlChanged.listen((url){
        setState(() {
          _isLoading=false;
        });
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new WebviewScaffold(
      appBar: new AppBar(
        title: new Column( mainAxisAlignment: MainAxisAlignment.center,children: _getAppBar(),),
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          new IconButton( // action button
            icon: new Icon( Icons.more_vert),
            onPressed: () {  },
          ),
        ],
      ),
      url: _url,);
  }

  // 获取appbar
  List<Widget> _getAppBar() {
    List<Widget> appbarChildList = [];
    appbarChildList.add(widgetsUtils.getAppBar(_title));
    if (_isLoading) {
      appbarChildList.add(new CupertinoActivityIndicator());
    }
    return appbarChildList;
  }
}
