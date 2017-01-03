//
//  TicketModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.qrcode_id = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.used = [NSString stringWithFormat:@"%@", keyedValues[@"used"]];
    self.expire_at = [NSString stringWithFormat:@"%@", keyedValues[@"expire_at"]];
    self.introduction = [NSString stringWithFormat:@"%@", keyedValues[@"introduction"]];
    self.price = [NSString stringWithFormat:@"%@", keyedValues[@"value"]];
    self.state = [NSString stringWithFormat:@"%@", keyedValues[@"state"]];
    self.store_name = [NSString stringWithFormat:@"%@", keyedValues[@"store_name"]];
}
@end
