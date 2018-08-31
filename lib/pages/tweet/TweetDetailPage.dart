import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';

class TweetDetailPage extends StatefulWidget {
  var _id;

  TweetDetailPage(this._id) {
    debugPrint('the id  is $_id');
  }

  @override
  _TweetDetailPageState createState() => _TweetDetailPageState(_id);
}

class _TweetDetailPageState extends State<TweetDetailPage> {
  WidgetsUtils widgetsUtils;
  var _id;

  _TweetDetailPageState(this._id);

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
      appBar: new AppBar(
        title: widgetsUtils.getAppBar('动弹详情'),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Center(
        child: new Text('the id is$_id'),
      ),
    );
  }
}
