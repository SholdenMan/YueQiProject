//
//  OtherModel.m
//  Modo
//
//  Created by 程磊 on 16/9/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OtherModel.h"

@implementation OtherModel


- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    self.othername = [NSString stringWithFormat:@"%@", keyedValues[@"othername"]];
    self.userphone = [NSString stringWithFormat:@"%@", keyedValues[@"userphone"]];
}


@end
