//
//  TicketModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : NSObject
@property (nonatomic , copy) NSString *qrcode_id; //二维码id
@property (nonatomic , copy) NSString *used; //是否用过
@property (nonatomic , copy) NSString *name; //票据名字
@property (nonatomic , copy) NSString *activityName;
@property (nonatomic , copy) NSString *expire_at; //票时效
@property (nonatomic , copy) NSString *blackList;//作废
@property (nonatomic, copy)NSString *price;//价格
@property (nonatomic, copy)NSString *store_name;//茶馆名称
@property (nonatomic, copy)NSString *introduction;//详细介绍
@property (nonatomic, copy)NSString *state;//是否过期


@end
