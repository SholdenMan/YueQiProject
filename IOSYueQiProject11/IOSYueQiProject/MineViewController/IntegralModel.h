//
//  IntegralModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralModel : NSObject
/*
 "id": 1,
 "user_id": 100560,
 "store_id": null,
 "name": "包厢费用",
 "score": 10,
 "category": "",
 "remark": "消费送积分",
 "create_time": 1481354551000
 */

@property (nonatomic , copy) NSString *integarl_id;
@property (nonatomic , copy) NSString *user_id;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *score;
@property (nonatomic , copy) NSString *remark;
@property (nonatomic , copy) NSString *create_time;





@end
