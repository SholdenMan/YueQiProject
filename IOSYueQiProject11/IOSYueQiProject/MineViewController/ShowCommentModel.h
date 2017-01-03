//
//  ShowCommentModel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowCommentModel : NSObject

@property (nonatomic , copy) NSString *nick_name;
@property (nonatomic , copy) NSString *portrait;
@property (nonatomic , copy) NSString *grade;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , strong) NSMutableArray *images;
@property (nonatomic , copy) NSString *anonymous;

@property (nonatomic , copy) NSString *create_time;
@property (nonatomic , assign) NSString *ids;

@end
