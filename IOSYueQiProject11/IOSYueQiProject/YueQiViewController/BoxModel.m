//
//  BoxModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/22.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "BoxModel.h"

@implementation BoxModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.attention = [NSString stringWithFormat:@"%@",keyedValues[@"attention"]];
    self.descriptionss = [NSString stringWithFormat:@"%@",keyedValues[@"description"]];
    self.name = [NSString stringWithFormat:@"%@",keyedValues[@"name"]];
    self.idel_rooms = [NSString stringWithFormat:@"%@",keyedValues[@"idel_rooms"]];
    self.hours = [NSString stringWithFormat:@"%@",keyedValues[@"hours"]];
    self.cover = [NSString stringWithFormat:@"%@",keyedValues[@"cover"]];
    self.hours = [NSString stringWithFormat:@"%@",keyedValues[@"hours"]];
    self.original_price = [NSString stringWithFormat:@"%@", keyedValues[@"original_price"]];
    self.seat = [NSString stringWithFormat:@"%@", keyedValues[@"seat"]];
    self.price = [NSString stringWithFormat:@"%@", keyedValues[@"price"]];
}
@end
