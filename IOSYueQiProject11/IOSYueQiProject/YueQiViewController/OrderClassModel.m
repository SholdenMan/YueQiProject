//
//  OrderClassModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OrderClassModel.h"
#import "FoodListModel.h"


@implementation OrderClassModel

- (NSMutableArray *)goods {
    if (!_goods) {
        self.goods = [NSMutableArray array];
    }
    return _goods;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"name"]];
    NSArray *modelArray = keyedValues[@"goods"];
    
    for (NSDictionary *dic in modelArray) {
        FoodListModel *model = [[FoodListModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.goods addObject:model];
    }
    
    self.istap = @"0";
}
@end
