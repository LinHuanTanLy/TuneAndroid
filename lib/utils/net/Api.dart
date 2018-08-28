class Api {
  // baseUrl  开源中国接口
  static final BASE_URL = "https://www.oschina.net";

//  获取用户信息
  static final String USER_INFO = BASE_URL + "/action/openapi/user";
//  更新头像
  static final String UPDATE_AVATAR=BASE_URL+"/action/openapi/portrait_update";
// 获取动弹列表
  static final String TWEET_LIST=BASE_URL+'/action/openapi/tweet_list';
//  回调地址
  static final String REDIRECT_URL = "http://yubo725.top/osc/osc.php";

//首页地址  根据网上博客资源
  static const NEWS_LIST_BASE_URL = "http://osc.yubo725.top/news/list";

//  登录接口
  static final String LOGIN_URL =
      "https://www.oschina.net/action/oauth2/authorize?client_id=4rWcDXCNTV5gMWxtagxI&response_type=code&redirect_uri=" +
          REDIRECT_URL;
}
