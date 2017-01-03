//
//  TeaDetailModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TeaDetailModel.h"

@implementation TeaDetailModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.ids = [NSString stringWithFormat:@"%@",keyedValues[@"id"]];
    self.style = [NSString stringWithFormat:@"%@",keyedValues[@"style"]];
    self.name = [NSString stringWithFormat:@"%@",keyedValues[@"name"]];
    self.descriptionsss = [NSString stringWithFormat:@"%@",keyedValues[@"description"]];
    self.original_price = [NSString stringWithFormat:@"%@",keyedValues[@"original_price"]];
    self.price = [NSString stringWithFormat:@"%@",keyedValues[@"price"]];
    self.hours = [NSString stringWithFormat:@"%@",keyedValues[@"hours"]];
    self.attention = [NSString stringWithFormat:@"%@", keyedValues[@"attention"]];
    self.seat = [NSString stringWithFormat:@"%@", keyedValues[@"seat"]];
    self.total_rooms = [NSString stringWithFormat:@"%@", keyedValues[@"total_rooms"]];
    self.idel_rooms = [NSString stringWithFormat:@"%@", keyedValues[@"idel_rooms"]];
}

@end
