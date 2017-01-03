//
//  Contactmodel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "Contactmodel.h"

@implementation Contactmodel

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.apply_state = [NSString stringWithFormat:@"%@", keyedValues[@"apply_state"]];
    self.contact_user_name = [NSString stringWithFormat:@"%@", keyedValues[@"contact_user_name"]];
    self.user_id = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.portrait = [NSString stringWithFormat:@"%@", keyedValues[@"portrait"]];
    self.nick_name = [NSString stringWithFormat:@"%@", keyedValues[@"nick_name"]];
}

@end
