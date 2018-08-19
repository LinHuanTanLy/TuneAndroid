import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';

class TweetsListPage extends StatelessWidget {
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

  TweetsListPage() {
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

    // 添加测试数据
    for (int i = 0; i < 20; i++) {
      Map<String, dynamic> map = new Map();
      // 动弹发布时间
      map['pubDate'] = '2018-7-30';
      // 动弹文字内容
      map['body'] =
          '早上七点十分起床，四十出门，花二十多分钟到公司，必须在八点半之前打卡；下午一点上班到六点，然后加班两个小时；八点左右离开公司，呼呼登自行车到健身房锻炼一个多小时。到家已经十点多，然后准备第二天的午饭，接着收拾厨房，然后洗澡，吹头发，等能坐下来吹头发时已经快十二点了。感觉很累。';
      // 动弹作者昵称
      map['author'] = '红薯';
      // 动弹评论数
      map['commentCount'] = 10;
      // 动弹作者头像URL
      map['portrait'] =
          'https://static.oschina.net/uploads/user/0/12_50.jpg?t=1421200584000';
      // 动弹中的图片，多张图片用英文逗号隔开
      map['imgSmall'] =
          'https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg,https://b-ssl.duitang.com/uploads/item/201508/27/20150827135810_hGjQ8.thumb.700_0.jpeg';
      hotList.add(map);
      normalList.add(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    mWidgetsUtils = new WidgetsUtils(context);
    return new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new TabBar(
            tabs: <Widget>[new Tab(text: "动弹列表"), new Tab(text: "热门动弹")],
          ),
          body: new TabBarView(
              children: <Widget>[getNormalList(), getNormalList()]),
        ));
  }

  //获取普通列表
  Widget getNormalList() {
    return new ListView.builder(
        itemCount: normalList.length * 2 - 1,
        itemBuilder: (context, i) => renderNormalRow(i));
  }

  renderNormalRow(i) {
    if (i.isOdd) {
      return new Divider(height: 1.0);
    } else {
      i = i ~/ 2;
      return new InkWell(child: getNormalItem(normalList[i]),onTap: (){
        print("this is the click Event");
      },);
    }
  }

  Widget getNormalItem(Map<String, dynamic> listItem) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          children: <Widget>[
            authorInfo(listItem),
            new Padding(
              padding: new EdgeInsets.fromLTRB(paddingLeft, 2.0, 6.0, 6.0),
              child: new Text(
                '${listItem['body']}',
                style: bodyStyle,
              ),
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
}
