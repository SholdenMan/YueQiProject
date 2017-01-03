//
//  LaunchModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "LaunchModel.h"

@implementation LaunchModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.subject = [NSString stringWithFormat:@"%@", keyedValues[@"subject"]];
    self.begin_time = [NSString stringWithFormat:@"%@", keyedValues[@"begin_time"]];
    self.hours = [NSString stringWithFormat:@"%@", keyedValues[@"hours"]];
    self.store = [NSString stringWithFormat:@"%@", keyedValues[@"store_id"]];
    self.teaID = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.pay_type = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type"]];
    self.address = [NSString stringWithFormat:@"%@", keyedValues[@"address"]];
}


@end
