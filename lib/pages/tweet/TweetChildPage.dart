import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutterdemo/pages/tweet/TweetDetailPage.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';

class TweetChildPage extends StatefulWidget {
  var user=0;


  TweetChildPage(this.user);

  @override
  _TweetChildPageState createState() => _TweetChildPageState(user);
}

class _TweetChildPageState extends State<TweetChildPage> with AutomaticKeepAliveClientMixin {


  _TweetChildPageState(this._user);

  var _user;
  var normalList = [];
  var hotList = [];
  WidgetsUtils mWidgetsUtils;

  // 动弹作者文本样式
  TextStyle authorTextStyle;

  // 动弹时间文本样式
  TextStyle subtitleStyle;

  // 动弹评论数列表
  TextStyle commentsStyle;

  // 动弹body样式
  TextStyle bodyStyle;


  double paddingLeft = 42.0;

  int _mCurPage = 1;

  var _tweetsList = [];

  @override
  void initState() {
    super.initState();
    authorTextStyle = new TextStyle(
        fontSize: 15.0, fontWeight: FontWeight.normal, color: Colors.black);
    subtitleStyle =
        new TextStyle(fontSize: 12.0, color: const Color(0xFFB5BDC0));
    commentsStyle =
        new TextStyle(fontSize: 12.0, color: const Color(0XFF1a1a1a));
    bodyStyle = new TextStyle(
      fontSize: 14.0,
      color: const Color(0XFF1a1a1a),
      letterSpacing: 1.2,
    );
    getTweetList();
  }

  @override
  Widget build(BuildContext context) {
    mWidgetsUtils = new WidgetsUtils(context);
    return getNormalList();
  }

//获取普通列表
  Widget getNormalList() {
    return new Refresh(
      onFooterRefresh: onFooterRefresh,
      onHeaderRefresh: onHeaderRefresh,
      childBuilder: (BuildContext context,
          {ScrollController controller, ScrollPhysics physics}) {
        return new ListView.builder(
            itemCount: _tweetsList.length * 2 - 1,
            controller: controller,
            physics: physics,
            itemBuilder: (context, i) => renderNormalRow(i));
      },
    );
  }

  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _mCurPage++;
        getTweetList();
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _mCurPage = 1;
        getTweetList();
      });
    });
  }

  getTweetList() {
    String url = Api.TWEET_LIST;
//    SpUtils.getToken().then((str) {
//      if(str!=null) {
//        Map<String, String> params = Map();
//        params['access_token'] = str;
//        params['page/pageIndex'] = _mCurPage.toString();
//        params['user'] = _user.toString();
//        Http.get(url, params: params).then((result) {
//          Map<String, dynamic> map = json.decode(result);
//          var _tempTweetList = map['tweetlist'];
//          setState(() {
//            if (_mCurPage == 1) {
//              _tweetsList.clear();
//              _tweetsList.addAll(_tempTweetList);
//            } else {
//              _tweetsList.addAll(_tempTweetList);
//            }
//            debugPrint('_tweetsList length is ${_tweetsList.length}');
//          });
//        });
//      }else{
//
//      }
//    });
  }

  toTweetDetail(var id){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new TweetDetailPage(id);
    }));
  }
  renderNormalRow(i) {
    if (i.isOdd) {
      return new Divider(height: 1.0);
    } else {
      i = i ~/ 2;
      return new InkWell(
        child: getNormalItem(_tweetsList[i]),
        onTap: () {
          toTweetDetail(_tweetsList[i]['id']);
          print("this is the click Event ${_tweetsList[i].toString()}");
        },
      );
    }
  }

  Widget getNormalItem(Map<String, dynamic> listItem) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            authorInfo(listItem),
            new Padding(
              padding: new EdgeInsets.fromLTRB(paddingLeft, 10.0, 6.0, 6.0),
              child: new Container(
                  child: new Text(
                '${listItem['body']}',
                textAlign: TextAlign.start,
                style: bodyStyle,
              ),alignment: Alignment.centerLeft,),
            ),
            new Padding(
                padding: new EdgeInsets.fromLTRB(paddingLeft, 2.0, 6.0, 6.0),
                child: new Column(
                  children: mWidgetsUtils.initImgGridView(listItem['imgSmall']),
                )),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  '${listItem['pubDate']}',
                  style: subtitleStyle,
                )
              ],
            )
          ],
        ));
  }

//  作者信息
  Widget authorInfo(Map<String, dynamic> listItem) {
    return new Row(
      children: <Widget>[
        new Container(
          width: 35.0,
          height: 35.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: new DecorationImage(
                image: new NetworkImage(listItem['portrait']),
                fit: BoxFit.cover),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 0.0),
          child: new Text(
            '${listItem['author']}',
            style: authorTextStyle,
          ),
        ),
        new Expanded(
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Text(
              '${listItem['commentCount']}',
              style: commentsStyle,
            ),
            new Padding(
              padding: new EdgeInsets.all(3.0),
              child: new Image.asset(
                'images/ic_comment.png',
                width: 16.0,
                height: 16.0,
              ),
            )
          ],
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
