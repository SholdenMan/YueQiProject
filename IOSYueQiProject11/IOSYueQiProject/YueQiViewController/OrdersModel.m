//
//  OrdersModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OrdersModel.h"

@implementation OrdersModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.num = [NSString stringWithFormat:@"%@", keyedValues[@"num"]];
}
@end
