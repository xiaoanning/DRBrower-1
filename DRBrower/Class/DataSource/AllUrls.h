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
#define BASE_URL @"http://61.160.196.119:8080/dr/"//@"http://112.84.188.42:9999/DRBrower/"

///获取新闻分类标签
#define URL_GETTABS @"news/getTabs"
///根据标签ID获取新闻
#define URL_GETNEWS_CID @"news/getNews?cid="
//获取网站
#define URL_GETWEBSITE @"site/siteList"

//百度搜索关键字
#define URL_BAIDU_SEARCH @"https://m.baidu.com/from=2001a/s?word="

#endif /* AllUrls_h */
