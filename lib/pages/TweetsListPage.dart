import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutterdemo/pages/login/LoginPage.dart';
import 'package:flutterdemo/pages/tweet/TweetChildPage.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';

class TweetsListPage extends StatefulWidget {
  @override
  _TweetsListPageState createState() => _TweetsListPageState();
}

class _TweetsListPageState extends State<TweetsListPage> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new TabBar(
            tabs: <Widget>[new Tab(text: "最新动弹"), new Tab(text: "热门动弹"),new Tab(text: "我的动弹")],
          ),
          body: new TabBarView(
              children: <Widget>[new TweetChildPage(0), new TweetChildPage(-1),new TweetChildPage(1)]),
        ));
  }
}
