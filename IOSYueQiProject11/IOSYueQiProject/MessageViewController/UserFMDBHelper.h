//
//  UserFMDBHelper.h
//  Modo
//
//  Created by 程磊 on 16/9/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OtherModel;
@interface UserFMDBHelper : NSObject
+ (UserFMDBHelper *)shareFMDBHelper;

// 插入对象
- (void)insertMessageSearchWithContent:(OtherModel *)content;

// 删除全部
- (void)deleteAllMessageSearch;


// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)nowDate;


@end
