class DiscoveryBean {
//  菜单的资源文件
  var menuRes;

//  菜单的按钮文字
  var menuMsg;

//  是否跳转到webView
  bool isLinkWebPage;

//  跳转地址
  String linkUrl;

//  菜单是否有顶部高间距
  bool isMarginTop;

//  菜单是否是长长的分割线
  bool isLongLine;

  DiscoveryBean(
    this.menuRes,
    this.menuMsg,
    this.isMarginTop,
    this.isLongLine, {
    this.isLinkWebPage=false,
    this.linkUrl,
  });
}
