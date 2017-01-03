//
//  RenewalModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "RenewalModel.h"

@implementation RenewalModel


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.cost = [NSString stringWithFormat:@"%@", keyedValues[@"cost"]];
    self.pay_type = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type"]];
    self.pay_type_text = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type_text"]];
    self.price = [NSString stringWithFormat:@"%@", keyedValues[@"price"]];
}
@end
