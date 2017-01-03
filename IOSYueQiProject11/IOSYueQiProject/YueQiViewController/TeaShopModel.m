//
//  TeaShopModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/4.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TeaShopModel.h"

@implementation TeaShopModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    NSString *str = [NSString stringWithFormat:@"%@", keyedValues.class];
    NSLog(@"%@", str);
    if ([str isEqualToString:@"NSNull"]) {
        return;
    }
    self.tea_id = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.distance_text = [NSString stringWithFormat:@"%@", keyedValues[@"distance_text"]];
    self.grade = [NSString stringWithFormat:@"%@", keyedValues[@"grade"]];
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.street = [NSString stringWithFormat:@"%@", keyedValues[@"street"]];
}
@end
