//
//  PartyListModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PartyListModel.h"
#import "PartyPersonModel.h"

@implementation PartyListModel

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.ids = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.store_id = [NSString stringWithFormat:@"%@", keyedValues[@"store_id"]];
    self.store_name = [NSString stringWithFormat:@"%@", keyedValues[@"store_name"]];
    self.user_id = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.subject = [NSString stringWithFormat:@"%@", keyedValues[@"subject"]];
    self.begin_time = [NSString stringWithFormat:@"%@", keyedValues[@"begin_time"]];
    self.hours = [NSString stringWithFormat:@"%@", keyedValues[@"hours"]];
    self.pay_type = [NSString stringWithFormat:@"%@", keyedValues[@"pay_type"]];
    self.state = [NSString stringWithFormat:@"%@", keyedValues[@"state"]];
    self.distance_text = [NSString stringWithFormat:@"%@", keyedValues[@"distance_text"]];
    self.owned = [NSString stringWithFormat:@"%@", keyedValues[@"owned"]];
    self.street = [NSString stringWithFormat:@"%@", keyedValues[@"street"]];
    self.create_time = [NSString stringWithFormat:@"%@", keyedValues[@"create_time"]];
    self.fee = [NSString stringWithFormat:@"%@", keyedValues[@"fee"]];
    self.invite_id = [NSString stringWithFormat:@"%@", keyedValues[@"invite_id"]];
    self.join = [NSString stringWithFormat:@"%@", keyedValues[@"join"]];
    self.im_group_id = [NSString stringWithFormat:@"%@", keyedValues[@"im_group_id"]];
    for (NSDictionary *dic in keyedValues[@"members"]) {
        PartyPersonModel *model = [[PartyPersonModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.members addObject:model];
    }
    self.address = [NSString stringWithFormat:@"%@", keyedValues[@"address"]];
    self.end_time = [NSString stringWithFormat:@"%@", keyedValues[@"end_time"]];
}


- (NSMutableArray *)members {
    if (!_members) {
        self.members = [NSMutableArray array];
    }
    return _members;
}
@end
