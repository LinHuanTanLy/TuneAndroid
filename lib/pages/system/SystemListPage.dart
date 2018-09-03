import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/domain/SystemClassBean.dart';
import 'package:flutterdemo/pages/system/SystemChildPage.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';

class SystemListPage extends StatefulWidget {
  List<SystemClassBean> _classList = [];

  var _title = '';
  SystemListPage(this._classList,this._title);

  @override
  _SystemListPageState createState() => _SystemListPageState(_classList,_title);
}

class _SystemListPageState extends State<SystemListPage> {
  WidgetsUtils widgetsUtils;
  List<SystemClassBean> classList = [];
  var _title = '';

  _SystemListPageState(this.classList,this._title){
    debugPrint('classList------------------------'+classList.toString());
  }

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
      appBar: new AppBar(
        title: widgetsUtils.getAppBar(_title),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new DefaultTabController(
        child: new Scaffold(
            appBar: new TabBar(
              isScrollable: true,
              tabs: _initTabs(),
            ),
            body: new TabBarView(children: _initBody())),
        length: classList.length,
      ),
    );
  }

  List<Widget> _initTabs() {
    List<Widget> _tempTabList = [];
    for (var i = 0; i < classList.length; i++) {
      _tempTabList.add(new Tab(text: classList[i].cName));
    }
    return _tempTabList;
  }

  List<Widget> _initBody() {
    List<Widget> _tempBodyList = [];
    for (var i = 0; i < classList.length; i++) {
      _tempBodyList.add(new SystemChildPage(classList[i].cId));
    }
    return _tempBodyList;
  }
}
