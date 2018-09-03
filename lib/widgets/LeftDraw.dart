import 'package:flutter/material.dart';
import 'package:flutterdemo/pages/menu/SetPage.dart';

//侧滑菜单
class LeftDraw extends StatelessWidget {
//  图标左边的图片大小
  static const double IMAGE_ICON_WIDTH = 30.0;

//  上面的图片大小
  static const double IMAGE_BANNER_HEIGHT = 304.0;
  static const double IMAGE_BANNER_WIDTH = 304.0;

//  图标后面的箭头
  static const double ARROW_IMAGE_ICON_WIDTH = 16.0;
  var rightArrowIcon = new Image.asset(
    'images/ic_arrow_right.png',
    width: ARROW_IMAGE_ICON_WIDTH,
    height: ARROW_IMAGE_ICON_WIDTH,
  );
  List menuTitles = ['发布动弹', '动弹小黑屋', '关于', '设置'];
  List menuIcons = [
    'images/leftmenu/ic_fabu.png',
    'images/leftmenu/ic_xiaoheiwu.png',
    'images/leftmenu/ic_about.png',
    'images/ic_set.png'
  ];

  // 菜单文本的样式
  TextStyle menuStyle = new TextStyle(
    fontSize: 15.0,
  );

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: const BoxConstraints.expand(width: IMAGE_BANNER_WIDTH),
      child: new Material(
        elevation: 16.0,
        child: new Container(
          decoration: new BoxDecoration(
            color: const Color(0x000000),
          ),
          child: new ListView.builder(
            itemCount: menuTitles.length * 2 + 1,
            itemBuilder: renderRow,
          ),
        ),
      ),
    );
  }

  Widget getIconImage(path) {
    return new Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 0.0, 6.0, 0.0),
        child: new Image.asset(path, width: 28.0, height: 28.0));
  }

  Widget renderRow(BuildContext con, int index) {
    if (index == 0) {
      var img = new Image.asset(
        'images/cover_img.jpg',
        width: IMAGE_BANNER_WIDTH,
        height: IMAGE_BANNER_HEIGHT,
        fit: BoxFit.fitWidth,
      );
      return new Container(
        width: IMAGE_BANNER_WIDTH,
        height: IMAGE_BANNER_HEIGHT,
        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        child: img,
      );
    }

    index -= 1;
    if (index.isOdd) {
      return new Divider();
    }
    index = index ~/ 2;
    var listItemContent = new Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 6.0),
      child: new Row(
        children: <Widget>[
          getIconImage(menuIcons[index]),
          new Expanded(
              child: new Text(
            menuTitles[index],
            style: menuStyle,
          )),
          rightArrowIcon
        ],
      ),
    );

    return new InkWell(
      child: listItemContent,
      onTap: () {
        debugPrint('the index is $index');
        switch (index) {
          case 3:
            Navigator.of(con).push(new MaterialPageRoute(builder: (con) {
              return new SetPage();
            }));
            break;
          case 2:
          case 1:
          case 0:
        }
      },
    );
  }
}
