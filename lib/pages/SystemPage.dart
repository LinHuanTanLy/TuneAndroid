import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdemo/domain/SystemClassBean.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';
import 'package:flutterdemo/pages/system/SystemListPage.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  var _treeList = [];

  var _titleStyle = new TextStyle(color: Colors.black, fontSize: 16.0);
  var _childStyle = new TextStyle(color: Color(0xFFB5BDC0), fontSize: 14.0);

  @override
  void initState() {
    super.initState();
    _getSystemTree();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: new CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        new SliverAppBar(
            pinned: false,
            expandedHeight: 180.0,
            iconTheme: new IconThemeData(color: Colors.transparent),
            flexibleSpace: new Image.asset(
              './images/ic_xiaoxin.jpg',
              fit: BoxFit.fill,
            )),
        new SliverList(
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
          var _tempItems = _treeList[index];
          return new Container(
              alignment: Alignment.centerLeft,
              child: new InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return _initClassData(_tempItems);
                  }));
                },
                child: new Column(
                  children: <Widget>[
                    new Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: new Text(
                                _tempItems['name'],
                                style: _titleStyle,
                              ),
                              alignment: Alignment.centerLeft,
                              margin:
                                  new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            ),
                            new Container(
                              margin:
                                  new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: new Text(
                                _childStr(_tempItems),
                                style: _childStyle,
                                textAlign: TextAlign.start,
                              ),
                              alignment: Alignment.topLeft,
                            )
                          ],
                        )),
                    new Divider(
                      height: 1.0,
                    )
                  ],
                ),
              ));
        }, childCount: _treeList.length))
      ],
    ));
  }

  String _childStr(var _tempItems) {
    var childList = _tempItems['children'] as List;
    StringBuffer _resultStr = new StringBuffer();
    for (var i = 0; i < childList.length; i++) {
      String name = childList[i]['name'];
      if (name.isNotEmpty) {
        _resultStr.write(name);
        _resultStr.write('         ');
      }
    }
    return _resultStr.toString();
  }

  _getSystemTree() {
    Http.get(Api.HOME_SYSTEM).then((res) {
      Map<String, dynamic> map = jsonDecode(res);
      var _tempTreeList = map['data'];
      if (_tempTreeList != null) {
        _treeList.addAll(_tempTreeList);
      }
    });
  }

  initItem(int i) {
    var _tempItems = _treeList[i];
    return new Container(
        alignment: Alignment.centerLeft,
        child: new InkWell(
          onTap: () {},
          child: new Column(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(_tempItems['name']),
                      new Text(_childStr(_tempItems)),
                    ],
                  )),
              new Divider(
                height: 1.0,
              )
            ],
          ),
        ));
  }

  Widget _initClassData(var tempData) {
    var childList = tempData['children'] as List;
    List<SystemClassBean> systemCBean = [];
    for (var tempItem in childList) {
      systemCBean.add(new SystemClassBean(tempItem['id'], tempItem['name']));
    }
    return new SystemListPage(systemCBean,tempData['name']);
  }
}
