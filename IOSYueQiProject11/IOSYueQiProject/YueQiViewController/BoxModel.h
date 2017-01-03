//
//  BoxModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/22.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxModel : NSObject

/*
 attention = "\U4f7f\U7528\U987b\U77e5\U4f7f\U7528\U987b\U77e5\U4f7f\U7528\U987b\U77e5\U4f7f\U7528\U987b\U77e5\U4f7f\U7528\U987b\U77e5\U4f7f\U7528\U987b\U77e5";
 description = "\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0\U7b80\U4ecb\U63cf\U8ff0";
 hours = 4;
 id = 3;
 "idel_rooms" = 0;
 images =     (
 {
 height = 220;
 name = "\U8336\U9986\U56fe\U7247\U4e00.jpeg";
 url = "http://static.binvshe.com/static/test/20161028170816982171_330*220.jpg";
 width = 330;
 },
 {
 height = 487;
 name = "\U8336\U9986\U56fe\U7247\U4e8c.jpg";
 url = "http://static.binvshe.com/static/test/20161028170828463679_650*487.jpg";
 width = 650;
 },
 {
 height = 529;
 name = "\U8336\U9986\U56fe\U7247\U4e09.jpg";
 url = "http://static.binvshe.com/static/test/20161028170917675950_800*529.jpg";
 width = 800;
 },
 {
 height = 405;
 name = "\U8336\U9986\U56fe\U7247\U56db.jpg";
 url = "http://static.binvshe.com/static/test/20161028170939431549_669*405.jpg";
 width = 669;
 },
 {
 height = 421;
 name = "\U8336\U9986\U56fe\U7247\U4e94.jpg";
 url = "http://static.binvshe.com/static/test/20161028170952914957_600*421.jpg";
 width = 600;
 }
 );
 name = "\U5c0f\U5305\U53a2";
 "original_price" = 100;
 price = 60;
 seat = 4;
 store =     {
 address = "\U798f\U5efa\U7701\U53a6\U95e8\U5e02\U6e56\U91cc\U533a\U6bbf\U524d\U516d\U8def517\U53f7";
 "business_begin" = "09:30";
 "business_end" = "02:00";
 city = "\U53a6\U95e8";
 "comment_count" = 1;
 distance = 9544;
 "distance_text" = "9.5km";
 district = "\U6e56\U91cc\U533a";
 grade = "3.5";
 icon = "http://static.binvshe.com/static/test/20161030012332023636_233*220.jpg";
 id = 1;
 latitude = "24.539356";
 longitude = "118.116266";
 name = "\U722c\U866b\U8336\U9986-\U9ad8\U6bbf\U5206\U9986";
 province = "\U798f\U5efa";
 street = "\U6bbf\U524d";
 tel = "0592-2206888";
 };
 "total_rooms" = 0;
 }
 */
///购买须知
@property (nonatomic, strong)NSString *attention;
///套餐详情
@property (nonatomic, strong)NSString *descriptionss;
///剩余包厢数量
@property (nonatomic, strong)NSString *idel_rooms;
///包厢时常
@property (nonatomic, strong)NSString *hours;
///封面图
@property (nonatomic, strong)NSString *cover;
///包厢名称
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *original_price;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSString *seat;
@property (nonatomic, strong)NSString *nowtime;













@end
