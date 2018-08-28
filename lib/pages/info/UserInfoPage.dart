import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterdemo/utils/WidgetsUtils.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  File _image;
  WidgetsUtils widgetsUtils;

  var _userNameController = new TextEditingController();
  var _userRealNameController = new TextEditingController();
  var _userJobController = new TextEditingController();
  var _userMobileController = new TextEditingController();
  var _userIntroController = new TextEditingController();

  var leftRes = new TextStyle(fontSize: 16.0, color: Colors.black);
  var hintRes = new TextStyle(fontSize: 15.0, color: Color(0xff969696));

  @override
  Widget build(BuildContext context) {
    widgetsUtils = new WidgetsUtils(context);
    return new Scaffold(
      appBar: new AppBar(
        title: widgetsUtils.getAppBar('用户信息'),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: initInputBody(),
    );
  }

  Widget initInputBody() {
    List<Widget> items = [];
    items.addAll(initHeaderItem(null));
    items.addAll(initInputItem('用户名', '请输入用户名', _userNameController));
    items.addAll(initInputItem('手机', '请输入手机号码', _userMobileController));
    items.addAll(initInputItem('真实姓名', '请输入真实姓名', _userRealNameController));
    items.addAll(initInputItem('职业', '请输入职业', _userJobController));
    items.addAll(
        initInputItem('简介', '介绍下自己吧', _userIntroController, maxLines: 6));
    items.add(initSubmitBtn());
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items,
    );
  }

  // 显示弹窗
  showPickDialog() {
    showModalBottomSheet(context: context, builder: _bottomPick);
  }

// 构建弹窗
  Widget _bottomPick(BuildContext context) {
    return initImgPick();
  }

  Future<String> getImgPick(ImageSource source) async {
    var tempImg = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = tempImg;
    });
  }

  List<Widget> initHeaderItem(var userAvatar) {
    List<Widget> item = [];
    item.add(new InkWell(
      onTap: (() {
        showPickDialog();
      }),
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  '头像',
                  style: leftRes,
                ),
                alignment: Alignment.centerLeft,
                height: 80.0,
              ),
            ),
            initHeaderView(userAvatar)
          ],
        ),
      ),
    ));
    item.add(new Divider(
      height: 1.0,
    ));
    return item;
  }

  Widget initHeaderView(var userAvatar) {
    if (_image == null) {
      if (userAvatar == null) {
        return new Image.asset(
          "images/ic_avatar_default.png",
          width: 60.0,
          height: 60.0,
        );
      } else {
        return new Container(
          width: 60.0,
          height: 60.0,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              image: new DecorationImage(
                  image: new NetworkImage(userAvatar), fit: BoxFit.cover),
              border: new Border.all(color: Colors.white, width: 2.0)),
        );
      }
    } else {
      return new Container(
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                image: new FileImage(_image), fit: BoxFit.cover),
            border: new Border.all(color: Colors.white, width: 2.0)),
      );
    }
  }

//  初始化输入的item
  List<Widget> initInputItem(var leftMsg, var hintMsg, var controller,
      {var maxLines = 1}) {
    List<Widget> item = [];
    item.add(
      new Padding(
        padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Text(
                  leftMsg,
                  style: leftRes,
                ),
                alignment: Alignment.centerLeft,
                height: 50.0,
              ),
            ),
            new Expanded(
                flex: 2,
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                  child: new TextField(
                    style: hintRes,
                    maxLines: maxLines,
                    textAlign: maxLines == 1 ? TextAlign.end : TextAlign.end,
                    controller: controller,
                    decoration: InputDecoration.collapsed(hintText: hintMsg),
                    obscureText: false,
                  ),
                ))
          ],
        ),
      ),
    );
    item.add(new Divider(
      height: 1.0,
    ));
    return item;
  }

  Widget initSubmitBtn() {
    return new Container(
      width: 360.0,
      margin: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
      child: new Card(
        color: Colors.green,
        elevation: 2.0,
        child: new MaterialButton(
          onPressed: () {

          },
          child: new Text(
            '确认修改',
            style: new TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget initImgPick() {
    return new Container(
        height: 170.0,
        child: new Column(
          children: <Widget>[
            new InkWell(
              child: new Container(
                child: new Text(
                  '拍照',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.camera);
              }),
            ),
            new Divider(
              height: 1.0,
            ),
            new InkWell(
              onTap: (() {
                Navigator.of(context).pop();
                getImgPick(ImageSource.gallery);
              }),
              child: new Container(
                child: new Text(
                  '从手机相册选择',
                  style: new TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                height: 60.0,
                alignment: Alignment.center,
              ),
            ),
            new Container(
              height: 5.0,
              color: new Color(0xfff2f2f2),
            ),
            new Container(
              child: new Text(
                '取消',
                style: new TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              height: 40.0,
              alignment: Alignment.center,
            )
          ],
        ));
  }
}
