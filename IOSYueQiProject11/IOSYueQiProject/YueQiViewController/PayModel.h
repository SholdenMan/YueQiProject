//
//  PayModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject
/*
 "id": 6,
 "store_name": "爬虫茶馆-高殿分馆",
 "icon": "http://static.binvshe.com/static/test/20161030012332023636_233*220.jpg",
 "name": " 大包厢(4小时)",
 "order_no": "20161103000824245768",
 "trading_no": "20161103165923452",
 "begin_time": 1478101596000,
 "end_time": 1478115996000,
 "pay_type": 0,
 "num": 1,
 "price": 90,
 "fee": 22.5,
 "state": 4,
 "price_text": "90.00元",
 "fee_text": "22.50元",
 "pay_type_text": "AA制",
 "duration": "2016-11-02 23:46 ~ 2016-11-03 03:46"
 
 "id": 59,
 "store_name": "爬虫茶馆-高殿分馆",
 "icon": "http://static.binvshe.com/static/test/20161030012332023636_233*220.jpg",
 "title": "包厢费用",
 "order_no": "20161130155858740696",
 "trading_no": "",
 "begin_time": 1480492736000,
 "end_time": 1480507136000,
 "create_time": 1480492739000,
 "pay_type": 0,
 "items": [
 {
 "name": "爬虫茶馆-高殿分馆（4小时）",
 "price": 90,
 "num": 1,
 "total_price": 90
 }
 ],
 "fee": 90,
 "state": 0,
 "type": 1,
 "pay_type_text": "AA制",
 "fee_text": "90.00元",
 "duration": "2016-11-30 15:58 ~ 19:58"
 
 
 "begin_time" = 1480493463000;
 "create_time" = 1480493495415;
 duration = "2016-11-30 16:11 ~ 20:11";
 "end_time" = 1480507863000;
 fee = 90;
 "fee_text" = "90\U5143";
 icon = "http://static.binvshe.com/static/test/20161030012332023636_233*220.jpg";
 id = 62;
 items =     (
 {
 name = "\U722c\U866b\U8336\U9986-\U9ad8\U6bbf\U5206\U9986\Uff084\U5c0f\U65f6\Uff09";
 num = 1;
 price = 90;
 "total_price" = 90;
 }
 );
 "order_no" = 20161130161135415689;
 "pay_type" = 1;
 "pay_type_text" = "\U623f\U4e3b\U8bf7\U5ba2";
 state = 0;
 "store_name" = "\U722c\U866b\U8336\U9986-\U9ad8\U6bbf\U5206\U9986";
 title = "\U5305\U53a2\U8d39\U7528";
 "trading_no" = "";
 type = 1;
 
 */

@property (nonatomic, strong)NSString *payID;
@property (nonatomic, strong)NSString *store_name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *order_no;
@property (nonatomic, strong)NSString *trading_no;
@property (nonatomic, strong)NSString *begin_time;
@property (nonatomic, strong)NSString *end_time;
@property (nonatomic, strong)NSString *pay_type;
@property (nonatomic, strong)NSString *num;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *fee;
@property (nonatomic, strong)NSString *state;
@property (nonatomic, strong)NSString *price_text;
@property (nonatomic, strong)NSString *fee_text;
@property (nonatomic, strong)NSString *pay_type_text;
@property (nonatomic, strong)NSString *duration;
@property (nonatomic, strong)NSString *store_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSMutableArray *orderArray;
@property (nonatomic, strong)NSString *useCoup;



@end
