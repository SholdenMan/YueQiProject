//
//  ShopDetailModel.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShopDetailModel.h"

@implementation ShopDetailModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    self.teaID = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    self.icon = [NSString stringWithFormat:@"%@", keyedValues[@"icon"]];
    self.region = [NSString stringWithFormat:@"%@", keyedValues[@"street"]];
    self.address = [NSString stringWithFormat:@"%@", keyedValues[@"address"]];
    self.grade = [NSString stringWithFormat:@"%@", keyedValues[@"grade"]];
//    [self.detailArray setValuesForKeysWithDictionary:keyedValues[@"categories"]];
    self.detailArray = [NSMutableArray array];
    self.detailArray = [NSMutableArray arrayWithArray:keyedValues[@"categories"]];
    self.distance = [NSString stringWithFormat:@"%@", keyedValues[@"distance_text"]];
    self.tel = [NSString stringWithFormat:@"%@", keyedValues[@"tel"]];
//    [self.imageArray setValuesForKeysWithDictionary:keyedValues[@"images"]];
    self.imageArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray arrayWithArray:keyedValues[@"images"]];
    self.business_begin = [NSString stringWithFormat:@"%@", keyedValues[@"business_begin"]];
    self.business_end = [NSString stringWithFormat:@"%@", keyedValues[@"business_end"]];
    self.comment_count = [NSString stringWithFormat:@"%@", keyedValues[@"comment_count"]];
    self.favorite = [NSString stringWithFormat:@"%@", keyedValues[@"favorite"]];
}
@end
