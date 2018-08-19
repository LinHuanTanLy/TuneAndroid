import 'package:flutter/material.dart';

import 'package:flutterdemo/domain/DiscoveryBean.dart';

class DiscoveryPage extends StatelessWidget {
  //数据源
  List<DiscoveryBean> discoveryDataSource = [];
//  菜单字体样式
  var menuStyle = new TextStyle(color: const Color(0xff333333), fontSize: 16.0);
//  listView的item的左右margin
 static const itemMarginLeftRight=16.0;
//  listView的菜单图标的宽高  这里狂暴地定义为正方形
  static const itemResWidthHeight=30.0;
//  listView的文字的左右margin;
  static const textMarginLeftRight=10.0;
//  短的分割线应该是左右margin+图标宽高+文字margin
  static const shortDivisionPaddingLeft=itemMarginLeftRight+itemResWidthHeight+textMarginLeftRight;
  DiscoveryPage() {
    var osSoft = new DiscoveryBean(
        'images/ic_discover_softwares.png', '开源软件', true, false);
    var recommend = new DiscoveryBean(
        'images/ic_discover_git.png', '码云推荐', false, false);
    var fragment = new DiscoveryBean(
        'images/ic_discover_gist.png', '代码片段', false, true);
    var qr = new DiscoveryBean(
        'images/ic_discover_scan.png', '扫一扫', true, false);
    var wave = new DiscoveryBean(
        'images/ic_discover_shake.png', '摇一摇', false, true);
    var nearby = new DiscoveryBean(
        'images/ic_discover_nearby.png', '码云封面人物', true, false);
    var offline = new DiscoveryBean(
        'images/ic_discover_pos.png', '线下活动', false, true);
    discoveryDataSource.add(osSoft);
    discoveryDataSource.add(recommend);
    discoveryDataSource.add(fragment);
    discoveryDataSource.add(qr);
    discoveryDataSource.add(wave);
    discoveryDataSource.add(nearby);
    discoveryDataSource.add(offline);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: initDiscoveryList(),
    );
  }

// 定义发现页面列表
  Widget initDiscoveryList() {
    return new ListView.builder(
      itemBuilder: renderRow,
      itemCount: discoveryDataSource.length,
    );
  }

  Widget renderRow(BuildContext con, int index) {
    DiscoveryBean bean = discoveryDataSource[index];
    var marginTop = bean.isMarginTop ? 20.0 : 0.0;
    var paddingLeft = bean.isLongLine ? 00.0 : shortDivisionPaddingLeft;
    return new InkWell(child: new Column(
      children: <Widget>[
        new Container(
          height: 50.0,
          margin: new EdgeInsets.fromLTRB(itemMarginLeftRight, marginTop, itemMarginLeftRight, 0.0),
          child: new Row(
            children: <Widget>[
              new Image.asset(bean.menuRes,width: itemResWidthHeight,height: itemResWidthHeight,),
              new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.fromLTRB(textMarginLeftRight, 0.0, textMarginLeftRight, 0.0),
                    child: new Text(
                      bean.menuMsg,
                      style: menuStyle,
                    ),
                  )),
              new Image.asset(
                'images/ic_arrow_right.png',
                width: 16.0,
                height: 16.0,
              )
            ],
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(paddingLeft, 0.0, 0.0, 0.0),
          child: new Divider(
            height: 1.0,
          ),
        )
      ],
    ),onTap: (){
      print("item is $index");
    },);
  }
}
