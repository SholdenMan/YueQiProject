//
//  PartyPersonModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PartyPersonModel.h"

@implementation PartyPersonModel


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.gender = [NSString stringWithFormat:@"%@", keyedValues[@"gender"]];
    self.nick_name = [NSString stringWithFormat:@"%@", keyedValues[@"nick_name"]];
    self.portrait = [NSString stringWithFormat:@"%@", keyedValues[@"portrait"]];
    self.role = [NSString stringWithFormat:@"%@", keyedValues[@"role"]];
    self.user_id = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.pay = [NSString stringWithFormat:@"%@", keyedValues[@"pay"]];

}
@end
