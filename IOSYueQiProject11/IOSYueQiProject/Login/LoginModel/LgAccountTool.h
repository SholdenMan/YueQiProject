//
//  NewAccountTool.h
//  login
//
//  Created by MacBook on 15/12/2.
//  Copyright © 2015年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LgAccount;
@interface LgAccountTool : NSObject
//保存账号
+ (void)saveWithAccount:(LgAccount *)account;
//读取账号
+ (LgAccount *)account;

//单例类 用户model
+ (LgAccount *)shareLgAccount;

//删除账号
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure;

@end
