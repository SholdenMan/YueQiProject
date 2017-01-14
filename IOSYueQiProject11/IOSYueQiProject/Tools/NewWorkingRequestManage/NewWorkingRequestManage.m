//
//  NewWorkingRequestManage.m
//  Created by 敲代码mac1号 on 16/7/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "NewWorkingRequestManage.h"

@implementation NewWorkingRequestManage

+ (NewWorkingRequestManage *)newWork {
    static  NewWorkingRequestManage *newWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        newWork = [[NewWorkingRequestManage alloc] init];
    });
    return newWork;
}


//GET请求
+ (void)requestGetWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //[userDef objectForKey:@"userID"]
    [NewWorkingRequestManage refushToken];
    //加密
    [manager.requestSerializer setValue:[[HelpManager shareHelpManager ] getDataWithEvent:@"GET" WithUrl:urlStr]forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"头部%@", [[HelpManager shareHelpManager ] getDataWithEvent:@"GET" WithUrl:urlStr]);
        [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
      
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            finish(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@", error);
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                        MyLog(@"%@", errDict[@"message"]);
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}



//NoHeadeGET请求
+ (void)requestNoHeadeGetWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"%@", responseObject);
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MyLog(@"%@", error);
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        MyLog(@"%@", errDict);
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                        MyLog(@"%@", errDict[@"message"]);
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}

//NoHeadePOST请求
+ (void)requestNoHeadePostWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
    
}


//POST请求
+ (void)requestPostWith:(NSString *)urlStr parDic:(id)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure  {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    NSString *debug = [NSString stringWithFormat:@"DEBUG userId=%@", [userDef objectForKey:@"userID"]];
//    if ([userDef objectForKey:@"userID"]) {
//        [manager.requestSerializer setValue:debug forHTTPHeaderField:@"Authorization"];
//    }
    //加密
    [manager.requestSerializer setValue:[[HelpManager shareHelpManager ] getDataWithEvent:@"POST" WithUrl:urlStr]forHTTPHeaderField:@"Authorization"];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
                switch (errorCode) {
                    case -1011:
                    {
                        NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                        NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                        if ([errDict objectForKey:@"message"]) {
                            customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                            [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                        }else{
                            customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                        }
                        break;
                    }
                    default:
                    {
                        NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = dic;
                        break;
                    }
                }
            
            failure(error);
        }
    }];
    
}



//PUT
+ (void)requestPUTWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSString *debug = [NSString stringWithFormat:@"DEBUG userId=%@", [userDef objectForKey:@"userID"]];
//    if ([userDef objectForKey:@"userID"]) {
//        [manager.requestSerializer setValue:debug forHTTPHeaderField:@"Authorization"];
//    }
    //加密
    [manager.requestSerializer setValue:[[HelpManager shareHelpManager ] getDataWithEvent:@"PUT" WithUrl:urlStr]forHTTPHeaderField:@"Authorization"];

    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager PUT:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}
+ (void)requestNoHeadePUTWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager PUT:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}


+ (void)requestDELETEWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    //去验证token
//    NSString *timeStr = [HelpManager getCurrentTimestamp];
//    NSString *oldTime = [userDef objectForKey:@"expires_at"];
//    if ( oldTime.floatValue - timeStr.floatValue *1000  < timeDay) {
//        [NewWorkingRequestManage requestGetWith:TokenUrl parDic:nil finish:^(id responseObject) {
//            [userDef setObject:responseObject[@"access_token"] forKey:@"token"];
//            [userDef setObject:responseObject[@"expires_at"] forKey:@"expires_at"];
//            
//        } error:^(NSError *error) {
//            MyLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
//            
//        }];
//    }
//    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
//    NSString *debug = [NSString stringWithFormat:@"DEBUG userId=%@", [userDef objectForKey:@"userID"]];
//    if ([userDef objectForKey:@"userID"]) {
//        [manager.requestSerializer setValue:debug forHTTPHeaderField:@"Authorization"];
//    }
    //加密
    [manager.requestSerializer setValue:[[HelpManager shareHelpManager ] getDataWithEvent:@"DELETE" WithUrl:urlStr]forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager DELETE:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}



+ (void)requestNoHeadeDELETEWith:(NSString *)urlStr parDic:(NSDictionary *)dic finish:(void(^)(id responseObject))finish error:(void(^)(NSError *error))failure {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager DELETE:urlStr parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
            
            failure(error);
        }
    }];
}

+ (void)refushToken{
    //去验证token
    NSString *timeStr = [HelpManager getCurrentTimestamp];
    NSString *oldTime = [userDef objectForKey:@"expires_at"];
    if ( oldTime.floatValue - timeStr.floatValue *1000  > timeDay){
        NSLog(@"%@---%@", oldTime, timeStr);
        [NewWorkingRequestManage requestNoHeadeGetWith:TokenUrl parDic:nil finish:^(id responseObject) {
            NSLog(@"%@", responseObject);
            [userDef setObject:responseObject[@"access_token"] forKey:@"token"];
            [userDef setObject:responseObject[@"expires_at"] forKey:@"expires_at"];
        } error:^(NSError *error) {
            MyLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
            
        }];
    }else{
        return;
    }

}

+(void)showError:(NSError *)error{
        MyLog(@"%@", error);
            //数据请求失败，返回错误信息原因 error
            NSInteger errorCode = [error code];
            NSError *customerError = nil;
            switch (errorCode) {
                case -1011:
                {
                    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errDict =[NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                    if ([errDict objectForKey:@"message"]) {
                        customerError = [[NSError alloc] initWithDomain:errDict[@"message"] code:[error code]userInfo:nil];
                        [NewWorkingRequestManage newWork].errorStr = [NSString stringWithFormat:@"%@", errDict[@"message"]];
                        MyLog(@"%@", errDict[@"message"]);
                    }else{
                        customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    }
                    break;
                }
                default:
                {
                    NSString *dic = [error.userInfo objectForKey:@"NSLocalizedDescription"];
                    customerError = [[NSError alloc] initWithDomain:error.localizedDescription code:[error code] userInfo:nil];
                    [NewWorkingRequestManage newWork].errorStr = dic;
                    break;
                }
            }
        
    
}

@end
