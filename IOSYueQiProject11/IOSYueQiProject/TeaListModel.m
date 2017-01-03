//
//  TeaListModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TeaListModel.h"

@implementation TeaListModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.teaID = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    self.region = [NSString stringWithFormat:@"%@", keyedValues[@"street"]];
    self.address = [NSString stringWithFormat:@"%@", keyedValues[@"address"]];
    self.grade = [NSString stringWithFormat:@"%@", keyedValues[@"grade"]];
    [self.detailArray setValuesForKeysWithDictionary:keyedValues[@"categories"]];
    self.distance = [NSString stringWithFormat:@"%@", keyedValues[@"distance_text"]];
}


@end
