//
//  PersonModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TeaShopModel;
@interface PersonModel : NSObject
@property (nonatomic, strong)NSString *user_id;
@property (nonatomic, strong)NSString *login_name;
@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, strong)NSString *gender;
@property (nonatomic, strong)NSString *portrait;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *phone;
@property (nonatomic, strong)NSString *longitude;
@property (nonatomic, strong)NSString *latitude;
@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *city;
@property (nonatomic, strong)NSString *district;
@property (nonatomic, strong)NSString *game_times;
@property (nonatomic, strong)NSString *escape_times;
@property (nonatomic, strong)NSString *name_py;
@property (nonatomic, strong)NSString *initial;
@property (nonatomic, strong)NSString *occupation;
@property (nonatomic, strong)NSString *sign;
@property (nonatomic, strong)NSString *smoking;
@property (nonatomic, strong)NSString *emotion;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *last_coords_time;
@property (nonatomic, strong)NSString *distance;
@property (nonatomic, strong)NSString *distance_text;
@property (nonatomic, strong)NSString *age;
@property (nonatomic, strong)NSString *firend;
@property (nonatomic, strong)TeaShopModel *teaShopModel;
@property (nonatomic, strong)NSMutableArray *stores;
@property (nonatomic, strong)NSString *month_game_times;


@end
