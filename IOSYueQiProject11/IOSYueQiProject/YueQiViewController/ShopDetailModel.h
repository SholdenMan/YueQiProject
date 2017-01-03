//
//  ShopDetailModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailModel : NSObject
/*
 "id": 1,
 "name": "爬虫茶馆-高殿分馆",
 "icon": "http://static.binvshe.com/static/test/20161030012332023636_233*220.jpg",
 "province": "福建",
 "city": "厦门",
 "district": "湖里区",
 "street": "殿前",
 "address": "福建省厦门市湖里区殿前六路517号",
 "longitude": 118.116266,
 "latitude": 24.539356,
 "tel": "0592-2206888",
 "grade": 3.5,
 "comment_count": 1,
 "business_begin": "09:30",
 "business_end": "02:00",
 "categories":包厢分类
  "images":所有图片
 "distance": 4401,
 "distance_text": "4.4km"
 */
@property (nonatomic, strong)NSString *teaID;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *region;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *grade;
@property (nonatomic, strong)NSMutableArray *detailArray;
@property (nonatomic, strong)NSString *categories;
@property (nonatomic, strong)NSString *distance;
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong)NSString *tel;
@property (nonatomic, strong)NSString *business_begin;
@property (nonatomic, strong)NSString *business_end;
@property (nonatomic, strong)NSString *comment_count;
@property (nonatomic, strong)NSString *favorite;








@end
