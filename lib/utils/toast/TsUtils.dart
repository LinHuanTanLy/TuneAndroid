import 'package:fluttertoast/fluttertoast.dart';
class TsUtils{
  static showShort(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        bgcolor: "#63CA6C",
        textcolor: '#ffffff'
    );
  }
}