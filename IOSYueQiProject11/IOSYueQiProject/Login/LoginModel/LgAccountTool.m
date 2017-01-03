//
//  NewAccountTool.m
//  login
//
//  Created by MacBook on 15/12/2.
//  Copyright © 2015年 MacBook. All rights reserved.
//

#import "LgAccountTool.h"
#import "LgAccount.h"
#define HMAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation LgAccountTool
/**
 *  保存账号
 *
 */
+ (void)saveWithAccount:(LgAccount *)account
{
    // 归档
    MyLog(@"path %@",HMAccountFilepath);
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:account toFile:HMAccountFilepath];
    if (isSuccess) {
        MyLog(@"归档成功");
    }else{
        MyLog(@"归档失败");
    }
}
/**
 *  读取帐号
 *
 */
+ (LgAccount *)account
{
    LgAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HMAccountFilepath];
    if (account == nil) {
        [self shareLgAccount];
    }
    return account;
}

+ (LgAccount *)shareLgAccount {
    static LgAccount *account = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [[LgAccount alloc] init];
    });
    return account;
}

/**
 *  删除账号
 */
+ (void)deleteAccountSuccess:(void(^)())success failuer:(void(^)())failure{
    
    NSFileManager *manager=[NSFileManager defaultManager];
    NSError *error=nil;
    BOOL b = [manager removeItemAtPath:HMAccountFilepath error:&error];
    
    if (b) {
        success();
    }else {
        failure();
    }
    
}
@end
