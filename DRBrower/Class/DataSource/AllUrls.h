//
//  AllUrls.h
//  DRBrower
//
//  Created by QiQi on 2016/12/21.
//  Copyright © 2016年 QiQi. All rights reserved.
//

#ifndef AllUrls_h
#define AllUrls_h


/**
 Base Url
 @return Base Url
 */
#define BASE_URL @"http://61.160.250.174:8080/dr/"//@"http://61.160.196.119:8080/dr/"//@"http://112.84.188.42:9999/DRBrower/"
#define PHP_BASE_URL @"http://admin.drliulanqi.com/index.php?g=api&"

///获取新闻分类标签
#define URL_GETTABS @"news/getTabs"
///根据标签ID获取新闻
#define URL_GETNEWS_CID @"news/getNews?cid="
//获取网站
#define URL_GETWEBSITE @"site/siteList"

//百度搜索关键字
#define URL_BAIDU_SEARCH @"https://m.baidu.com/from=2001a/s?word="

//获取排行分类标签
#define URL_GETSORTTAG @"sort/cateList"
//获取排行列表标签
#define URL_GETSORTLIST @"sort/getList?page_num="

//天气
#define URL_GETWEATHER @"http://admin.drliulanqi.com/index.php?g=api&m=weather&a=get_weather&token=brower*@forapi@*&name="

//分享下载链接
#define URL_SHARE @"http://www.drliulanqi.com/dr/index.html"

//点赞
#define URL_ADDLOVE @"sort/addLove"
//举报
#define URL_ADDCOMPLAIN @"sort/addComplain?dev_id="
//获取评论列表
#define URL_GETCOMMENTLIST @"comment/list?md5="
//发表评论
#define URL_ADDCOMMENT @"comment/save?tel="

//吐槽程序员
#define URL_ADVICE @"m=suggest&a=add&dev_id="

//获取短信验证码
#define URL_GETCODE @"m=user&a=get_send_message&devtype=2&tel="
//注册
#define URL_REGSIT @"m=user&a=register&sigtype=1&devtype=2&token="
//重置密码
#define URL_FINDPWD @"m=user&a=findpwd&devtype=2&token="
//登录
#define URL_LOGIN @"m=user&a=login&devtype=2&token="





#endif /* AllUrls_h */

















