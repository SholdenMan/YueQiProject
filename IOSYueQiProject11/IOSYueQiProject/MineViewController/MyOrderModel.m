//
//  MyOrderModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.order_id = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.used = [NSString stringWithFormat:@"%@", keyedValues[@"used"]];
    self.price = [NSString stringWithFormat:@"%@", keyedValues[@"value"]];
    self.state = [NSString stringWithFormat:@"%@", keyedValues[@"state"]];
    self.store_name = [NSString stringWithFormat:@"%@", keyedValues[@"store_name"]];
    self.order_no = [NSString stringWithFormat:@"%@", keyedValues[@"order_no"]];
    self.trading_no = [NSString stringWithFormat:@"%@", keyedValues[@"trading_no"]];
    self.begin_time = [NSString stringWithFormat:@"%@", keyedValues[@"begin_time"]];
    self.end_time = [NSString stringWithFormat:@"%@", keyedValues[@"end_time"]];
    self.pay_type = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type"]];
    self.num = [NSString stringWithFormat:@"%@", keyedValues[@"num"]];
    self.fee = [NSString stringWithFormat:@"%@", keyedValues[@"fee"]];
    self.price_text = [NSString stringWithFormat:@"%@", keyedValues[@"price_text"]];
    self.fee_text = [NSString stringWithFormat:@"%@", keyedValues[@"fee_text"]];
    self.pay_type_text = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type_text"]];
    self.duration = [NSString stringWithFormat:@"%@", keyedValues[@"duration"]];
    self.portrait = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    
}
@end
