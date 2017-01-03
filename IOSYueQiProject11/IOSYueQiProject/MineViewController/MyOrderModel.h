//
//  MyOrderModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
@property (nonatomic , copy) NSString *order_id; //二维码id
@property (nonatomic , copy) NSString *used; //是否用过
@property (nonatomic , copy) NSString *name; //票据名字
@property (nonatomic, copy)NSString *price;//价格
@property (nonatomic, copy)NSString *store_name;//茶馆名称
@property (nonatomic, copy)NSString *state;//是否过期
@property (nonatomic, copy)NSString *order_no;
@property (nonatomic, copy)NSString *trading_no;
@property (nonatomic, copy)NSString *begin_time;
@property (nonatomic, copy)NSString *end_time;
@property (nonatomic, copy)NSString *pay_type;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *fee;
@property (nonatomic, copy)NSString *price_text;
@property (nonatomic, copy)NSString *fee_text;
@property (nonatomic, copy)NSString *pay_type_text;
@property (nonatomic, copy)NSString *duration;
@property (nonatomic, copy)NSString *portrait;




@end
