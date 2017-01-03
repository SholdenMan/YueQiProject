//
//  FoodListModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FoodListModel.h"

@implementation FoodListModel


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    self.price = [NSString stringWithFormat:@"%@", keyedValues[@"price"]];
    self.ids = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.count = 0;
}

@end
