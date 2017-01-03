//
//  ShowCommentModel.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShowCommentModel.h"

@implementation ShowCommentModel


- (NSMutableArray *)images {
    if (!_images) {
        self.images = [NSMutableArray array];
    }
    return _images;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.nick_name = [NSString stringWithFormat:@"%@", keyedValues[@"nick_name"]];
    self.portrait = [NSString stringWithFormat:@"%@", keyedValues[@"portrait"]];
    self.grade = [NSString stringWithFormat:@"%@", keyedValues[@"grade"]];
    self.content = [NSString stringWithFormat:@"%@", keyedValues[@"content"]];
    if (keyedValues[@"images"]) {
        self.images = keyedValues[@"images"];

    }
    NSLog(@"%@", keyedValues[@"images"]);
    self.anonymous = [NSString stringWithFormat:@"%@", keyedValues[@"anonymous"]];
    self.ids = [NSString stringWithFormat:@"%@", keyedValues[@"id"]];
    self.create_time = [NSString stringWithFormat:@"%@", keyedValues[@"create_time"]];
}




@end
