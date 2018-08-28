import 'package:flutter/material.dart';

class WidgetsUtils {
  // 屏幕宽度
  double screenWidth;

  WidgetsUtils(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
  }

  //根据图片list返回一个9宫格的东西
  List<Widget> initImgGridView(String imgStr) {
    List<Widget> widgetList = [];
    if (imgStr != null && imgStr.length > 0) {
      List<String> imgList = imgStr.split(",");
      List<String> imgUrl = new List<String>();
      for (String s in imgList) {
        if (s.startsWith('http')) {
          imgUrl.add(s);
        } else {
          imgUrl.add('https://static.oschina.net/uploads/space/' + s);
        }
      }
      List<List<Widget>> rows = [];
      num len = imgUrl.length;
      if (len > 1) {
        for (var row = 0; row < getRow(len); row++) {
          List<Widget> rowArr = [];
          for (var col = 0; col < 3; col++) {
            num index = row * 3 + col;
            double cellWidth = (screenWidth - 100) / 3;
            if (index < len) {
              rowArr.add(new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Image.network(
                  imgUrl[index],
                  width: cellWidth,
                  height: cellWidth,
                ),
              ));
            }
          }
          rows.add(rowArr);
        }
        for (var row in rows) {
          widgetList.add(new Row(
            children: row,
          ));
        }
      }
    }
    return widgetList;
  }

  // 获取行数，n表示图片的张数
  // 如果n取余不为0，则行数为n取整+1，否则n取整就是行数
  int getRow(int n) {
    int a = n % 3; // 取余
    int b = n ~/ 3; // 取整
    if (a != 0) {
      return b + 1;
    }
    return b;
  }

  // banner图片
  List<Widget> getBannerChild(List slideData) {
    List<Widget> items = [];
    if (slideData != null && slideData.length > 0) {
      for (var i = 0; i < slideData.length; i++) {
        var item = slideData[i];
        var imgUrl = item['imgUrl'];
        var title = item['title'];
        var detailUrl = item['detailUrl'];
        items.add(new GestureDetector(
          onTap: () {
            // 详情跳转
          },
          child: new Stack(
            children: <Widget>[
              new Image.network(imgUrl),
              new Container(
                  width: screenWidth,
                  color: const Color(0x50000000),
                  child: new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(title,
                        maxLines: 1,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 15.0)),
                  )),
            ],
          ),
        ));
      }
      return items;
    }
  }

// 获取appBar
  Widget getAppBar(var title) {
    return new Text(title, style: new TextStyle(color: Colors.white));
  }


}
