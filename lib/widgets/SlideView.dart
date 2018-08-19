import 'package:flutter/material.dart';

//滚动viewpager
class SlideView extends StatefulWidget {
  var data;

  SlideView(this.data);

  @override
  State<StatefulWidget> createState() {
    return new SlideViewState(data);
  }
}

class SlideViewState extends State<SlideView>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List slideData;

  SlideViewState(this.slideData);

  @override
  void initState() {
    super.initState();
    // 初始化控制器
    tabController = new TabController(
        length: slideData == null ? 0 : slideData.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  build(dynamic) {
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
                  width: MediaQuery.of(context).size.width,
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
    }
    return new TabBarView(
      children: items,
      controller: tabController,
    );
  }
}
