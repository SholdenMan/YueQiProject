//
//  Contactmodel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//


/**
 *   "apply_state" = 0;
 "contact_user_name" = "\U9a6c\U65b0\U714c";
 gender = 1;
 initial = M;
 "login_name" = 18959232125;
 "name_py" = maxinhuang;
 "nick_name" = "\U9a6c\U65b0\U714c";
 portrait = "http://static.binvshe.com/static/smart_ring/20161027170339095819_750*750.jpg";
 "user_id" = 100561;
 */
#import <Foundation/Foundation.h>

@interface Contactmodel : NSObject

@property (nonatomic , copy) NSString *apply_state;
@property (nonatomic , copy) NSString *contact_user_name;
@property (nonatomic , copy) NSString *user_id;
@property (nonatomic , copy) NSString *portrait;
@property (nonatomic , copy) NSString *nick_name;

@end
