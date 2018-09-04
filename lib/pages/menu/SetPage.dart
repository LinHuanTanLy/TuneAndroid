import 'package:flutter/material.dart';
import 'package:flutterdemo/app/OsApplication.dart';
import 'package:flutterdemo/domain/event/LoginEvent.dart';
import 'package:flutterdemo/pages/news/NewsDetailPage.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:flutterdemo/utils/cache/SpUtils.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  List<String> _menuList = [];
  WidgetsUtils widgetsUtils;
  TextStyle leftMenuStyle = new TextStyle(fontSize: 16.0, color: Colors.black);

  @override
  void initState() {
    super.initState();
    _menuList.add('清除缓存');
    _menuList.add('关于我们');
    _menuList.add('退出登录');
  }

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return Scaffold(
      appBar: new AppBar(
        title: widgetsUtils.getAppBar('设置'),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new ListView.builder(
        itemBuilder: (context, index) => initItem(index),
        itemCount: _menuList.length,
      ),
    );
  }

  initItem(int index) {
    return new InkWell(
      onTap: () {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.push(context, new MaterialPageRoute(builder: (context){
              return NewsDetailPage('https://github.com/LinHuanTanLy','凌宇Ly');
            }));
            break;
          case 2:
            _showDialog();
            break;
        }
      },
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text(
                  _menuList[index],
                  style: leftMenuStyle,
                )
              ],
            ),
            margin: new EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
          ),
          new Divider(
            height: 1.0,
          )
        ],
      ),
    );
  }




  _showDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
              title: new Text('提示'),
              content: new Text('是否要退出登录'),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text('取消')),
                new FlatButton(
                    onPressed: () {
                      SpUtils.cleanUserInfo();
                      OsApplication.eventBus.fire(new LoginEvent(null));
                      Navigator.pop(context);
                    },
                    child: new Text('是的'))
              ],
            ),
        context: context);
  }
}
