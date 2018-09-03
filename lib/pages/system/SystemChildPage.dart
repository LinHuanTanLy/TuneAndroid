import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:flutterdemo/pages/news/NewsDetailPage.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';
import 'package:flutterdemo/utils/toast/TsUtils.dart';

class SystemChildPage extends StatefulWidget {
  var _cId;

  SystemChildPage( this._cId);

  @override
  _SystemChildPageState createState() => _SystemChildPageState( _cId);
}

class _SystemChildPageState extends State<SystemChildPage>
    with AutomaticKeepAliveClientMixin {
  List _listData = [];
  var _mCurPage = 0;
  var _cId;

  _SystemChildPageState(this._cId); // 列表中资讯标题的样式
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);

//  作者style
  TextStyle authorStyle =
      new TextStyle(color: const Color(0xFF000000), fontSize: 12.0);

  @override
  void initState() {
    _getSystemList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Refresh(
      onFooterRefresh: onFooterRefresh,
      onHeaderRefresh: onHeaderRefresh,
      childBuilder: (BuildContext context,
          {ScrollController controller, ScrollPhysics physics}) {
        return new Container(
          child: new ListView.builder(
            itemBuilder: (context, i) => _initItem(i),
            controller: controller,
            physics: physics,
            itemCount: _listData.length,
          ),
        );
      },
    );
  }
  Future<Null> onFooterRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _mCurPage++;
        _getSystemList();
      });
    });
  }

  Future<Null> onHeaderRefresh() {
    return new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _mCurPage = 0;
        _getSystemList();

      });
    });
  }

  Widget _initItem(int i) {
    var _data = _listData[i];
    return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return NewsDetailPage(_data['link'], _data['title']);
        }));
      },
      child: new Card(
        elevation: 1.0,
        child: new Container(
          alignment: Alignment.centerLeft,
          padding: new EdgeInsets.all(4.0),
          margin: new EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new Text(
                  '作者：${_data['author']}',
                  style: authorStyle,
                  textAlign: TextAlign.left,
                ),
                alignment: Alignment.centerLeft,
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 6.0),
                child: new Text(
                  '${_data['title']}',
                  textAlign: TextAlign.start,
                  style: titleTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getSystemList() {
    String _url = Api.HOME_SYSTEM_CHILD +
        _mCurPage.toString() +
        "/json?cid=" +
        _cId.toString();
    Http.get(_url).then((res) {
      Map<String, dynamic> map = jsonDecode(res);
      var _tempList = map['data']['datas'] as List;
      if(_tempList.isEmpty){
        TsUtils.showShort('没有更多数据咯~~~///(^v^)\\\~~~');
      }
      setState(() {
        if (_mCurPage == 0) {
          _listData.clear();
          _listData.addAll(_tempList);
        } else {
          _listData.addAll(_tempList);
        }
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
