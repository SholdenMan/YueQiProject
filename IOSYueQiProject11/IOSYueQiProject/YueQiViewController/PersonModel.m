//
//  PersonModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PersonModel.h"
#import "TeaShopModel.h"

@implementation PersonModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    NSString *str = [NSString stringWithFormat:@"%@", keyedValues.class];
    NSLog(@"%@", str);
    if ([str isEqualToString:@"NSNull"]) {
        return;
    }
    self.user_id = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.login_name = [NSString stringWithFormat:@"%@", keyedValues[@"login_name"]];
    self.nick_name = [NSString stringWithFormat:@"%@", keyedValues[@"nick_name"]];
    self.gender = [NSString stringWithFormat:@"%@", keyedValues[@"gender"]];
    self.portrait = [NSString stringWithFormat:@"%@", keyedValues[@"portrait"]];
    self.birthday = [NSString stringWithFormat:@"%@", keyedValues[@"birthday"]];
    self.phone = [NSString stringWithFormat:@"%@", keyedValues[@"phone"]];
    self.longitude = [NSString stringWithFormat:@"%@", keyedValues[@"longitude"]];
    self.latitude = [NSString stringWithFormat:@"%@", keyedValues[@"latitude"]];
    self.province = [NSString stringWithFormat:@"%@", keyedValues[@"province"]];
    self.city = [NSString stringWithFormat:@"%@", keyedValues[@"city"]];
    self.distance = [NSString stringWithFormat:@"%@", keyedValues[@"distance"]];;
    self.game_times = [NSString stringWithFormat:@"%@", keyedValues[@"game_times"]];;
    self.escape_times = [NSString stringWithFormat:@"%@", keyedValues[@"escape_times"]];
    self.name_py = [NSString stringWithFormat:@"%@", keyedValues[@"name_py"]];
    self.initial = [NSString stringWithFormat:@"%@", keyedValues[@"initial"]];
    self.occupation = [NSString stringWithFormat:@"%@", keyedValues[@"occupation"]];
    self.sign = [NSString stringWithFormat:@"%@", keyedValues[@"sign"]];
    self.smoking = [NSString stringWithFormat:@"%@", keyedValues[@"smoking"]];
    self.emotion = [NSString stringWithFormat:@"%@", keyedValues[@"emotion"]];
    self.create_time = [NSString stringWithFormat:@"%@", keyedValues[@"create_time"]];
    self.last_coords_time = [NSString stringWithFormat:@"%@", keyedValues[@"last_coords_time"]];
    self.distance = [NSString stringWithFormat:@"%@", keyedValues[@"distance"]];
    self.distance_text = [NSString stringWithFormat:@"%@", keyedValues[@"distance_text"]];
    self.age = [NSString stringWithFormat:@"%@", keyedValues[@"age"]];
    self.stores = [NSMutableArray array];
    self.stores = keyedValues[@"stores"];
    self.firend = [NSString stringWithFormat:@"%@", keyedValues[@"friend"]];
    self.month_game_times = [NSString stringWithFormat:@"%@", keyedValues[@"month_game_times"]];
    
}

@end
