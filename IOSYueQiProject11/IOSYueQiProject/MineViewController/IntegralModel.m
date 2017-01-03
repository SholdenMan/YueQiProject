//
//  IntegralModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "IntegralModel.h"

@implementation IntegralModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.integarl_id = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.user_id = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.remark = [NSString stringWithFormat:@"%@", keyedValues[@"remark"]];
    self.create_time = [NSString stringWithFormat:@"%@", keyedValues[@"create_time"]];
    self.score = [NSString stringWithFormat:@"%@", keyedValues[@"score"]];
}
@end
