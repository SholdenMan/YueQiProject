//
//  UserFMDBHelper.m
//  Modo
//
//  Created by 程磊 on 16/9/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "UserFMDBHelper.h"
#import "FMDB.h"
#import "OtherModel.h"
@interface UserFMDBHelper ()
// 声明一个数据库属性
// 因为执行增删改查都是使用数据库对象调用方法
@property (nonatomic, strong) FMDatabase *db;

@end

@implementation UserFMDBHelper

+ (UserFMDBHelper *)shareFMDBHelper {
    static UserFMDBHelper *fMDBHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fMDBHelper = [[UserFMDBHelper alloc] init];
        //创表
        [fMDBHelper creatUserSearchTable];
    });
    return fMDBHelper;
}

// 数据库的懒加载
- (FMDatabase *)db {
    if (_db == nil) {
        self.db = [FMDatabase databaseWithPath:[self sqlitePath]];
    }
    return _db;
}

// 封装获取sqlite文件的路径
- (NSString *)sqlitePath {
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"OtherModel.sqlite"];
    NSLog(@"%@", filePath);
    return filePath;
}

// 创建表的方法
// 插入数据, 修改数据, 删除数据 都使用executeUpdata
// 查询数据 用executeQuery

//[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]
- (void)creatUserSearchTable {
    // 1.打开数据库
    [self.db open];
    
    
    // 执行创建表的方法
    BOOL result = [self.db executeUpdate:@"create table if not exists OtherModel(othername text , icon text, userphone text primary key)"];
    if (result) {
        NSLog(@"创表成功 或者 表以存在");
    }
    // .关闭数据库
    [self.db close];
}


// 插入对象
// 插入数据或者更改的时候, 数据的值, 使用对象类型, int->NSNumber
- (void)insertMessageSearchWithContent:(OtherModel *)content {
    [self.db open];
    //执行插入
//    BOOL result = [self.db executeUpdate:@"insert into OtherModel(othername, icon, userphone) values(?, ?, ?)",content.othername, content.icon, content.userphone];
    BOOL result = [self.db executeUpdate:@"insert into OtherModel(othername, icon, userphone) values(?, ?, ?)", content.othername, content.icon, content.userphone];
    if (result) {
        NSLog(@"数据插入成功");
    }
        
    
    [self.db close];
}


// 条件查询
- (NSMutableArray *)searchMessageModelWith:(NSString *)type {
    [self.db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    // 执行查询
    // FMResultSet:结果集合, 地面都是满足你设置sql语句条件的数据, 可能为一条, 可能为多条
    FMResultSet *set = [self.db executeQuery:@"select * from OtherModel where userphone = ?",type];
    while ([set next]) {
        OtherModel *model = [[OtherModel alloc] init];
        NSString *icon = [set objectForColumnName:@"icon"];
        NSString *othername = [set objectForColumnName:@"othername"];
        NSString *userphone = [set objectForKeyedSubscript:@"userphone"];
        model.icon = icon;
        model.othername = othername;
        model.userphone = userphone;
        [dataArray addObject:model];
    }
    
    [self.db close];
    return dataArray;
}

// 删除全部
- (void)deleteAllMessageSearch {
    [self.db open];
    BOOL result = [self.db executeUpdate:@"delete from OtherModel"];
    if (result) {
        NSLog(@"删除成功");
    }
    [self.db close];
}


@end
