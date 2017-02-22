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
//#define BASE_URL @"http://112.84.188.42:9999/DRBrower/"
#define BASE_URL @"http://61.160.250.174:8080/dr/"

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
#define URL_GETSORTLIST @"sort/getList?page_num=1&site_type="
//http://61.160.250.174:8080/dr/sort/getList?page_num=1&site_type=3&sort=visit_num


#endif /* AllUrls_h */
