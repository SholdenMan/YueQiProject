//
//  PayModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PayModel.h"
#import "OrdersModel.h"

@implementation PayModel
-(NSMutableArray *)orderArray{
    if (!_orderArray) {
        self.orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.payID = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.store_name = [NSString stringWithFormat:@"%@", keyedValues[@"store_name"]];
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
//    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"sub_orders"][@"name"]];
//    if ([keyedValues[@"sub_orders"] isEqualToString:@"<NULL>"]) {
//        NSLog(@"111");
//    }else{
        for (NSDictionary *dic in keyedValues[@"sub_orders"]) {
            OrdersModel *model = [[OrdersModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.orderArray addObject:model];
        }
//    }
        self.store_id = [NSString stringWithFormat:@"%@", keyedValues[@"store_id"]];
    self.order_no = [NSString stringWithFormat:@"%@", keyedValues[@"order_no"]];
    self.trading_no = [NSString stringWithFormat:@"%@", keyedValues[@"trading_no"]];
    self.begin_time = [NSString stringWithFormat:@"%@", keyedValues[@"begin_time"]];
    self.end_time = [NSString stringWithFormat:@"%@", keyedValues[@"end_time"]];
    self.pay_type = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type"]];
    self.fee = [NSString stringWithFormat:@"%@", keyedValues[@"fee"]];
    self.state = [NSString stringWithFormat:@"%@", keyedValues[@"state"]];
    self.price_text = [NSString stringWithFormat:@"%@", keyedValues[@"price_text"]];
    self.fee_text = [NSString stringWithFormat:@"%@", keyedValues[@"fee_text"]];
    self.pay_type_text = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type_text"]];
    self.duration = [NSString stringWithFormat:@"%@", keyedValues[@"duration"]];
    self.title = [NSString stringWithFormat:@"%@", keyedValues[@"title"]];
    self.create_time = [NSString stringWithFormat:@"%@", keyedValues[@"create_time"]];
    
}
@end
