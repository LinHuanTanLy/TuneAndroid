import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/net/Api.dart';
import 'package:flutterdemo/utils/net/Http.dart';

class SystemPage extends StatefulWidget {
  @override
  _SystemPageState createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  var _treeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSystemTree();
  }

  @override
  Widget build(BuildContext context) {
    return new CustomScrollView(
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
//        new ListView.builder(itemBuilder: (context, i) => initItem(i),
//        itemCount: _treeList.length,),
        new SliverFixedExtentList(
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              var _tempItems = _treeList[index];
              return new Container(
                  alignment: Alignment.centerLeft,
                  child: new InkWell(
                    onTap: () {},
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                            child:
                            new Column(
                              children: <Widget>[
                                new Container(child:  new Text(_tempItems['name']),alignment: Alignment.centerLeft,),
                                new Text(_childStr(_tempItems)),
                              ],
                            )),
                        new Divider(
                          height: 1.0,
                        )
                      ],
                    ),
                  ));
            }, childCount: _treeList.length),
            itemExtent: 100.0),
      ],
    );
  }

  String _childStr(var _tempItems) {
    var childList = _tempItems['children'] as List;
    StringBuffer _resultStr = new StringBuffer();
    for (var i = 0; i < childList.length; i++) {
      _resultStr.write(childList[i]['name']);
      _resultStr.write('               ');
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
}
