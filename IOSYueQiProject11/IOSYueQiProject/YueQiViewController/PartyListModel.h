//
//  PartyListModel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartyListModel : NSObject



///约局id
@property (nonatomic , copy) NSString *ids;
///商家id
@property (nonatomic , copy) NSString *store_id;

///商家名称
@property (nonatomic , copy) NSString *store_name;

///创建约局用户id
@property (nonatomic , copy) NSString *user_id;

///约局名称
@property (nonatomic , copy) NSString *subject;

///开始时间
@property (nonatomic , copy) NSString *begin_time;

///创建时间
@property (nonatomic, copy)NSString *create_time;

///持续时间
@property (nonatomic , copy) NSString *hours;

///支付方式 (0:AA制   1:房主请客 )
@property (nonatomic , copy) NSString *pay_type;

///约局状态 (0:等待加入  1:)
@property (nonatomic , copy) NSString *state;

///距离
@property (nonatomic , copy) NSString *distance_text;

///我的约局 (1:是  0:否)
@property (nonatomic , copy) NSString *owned;

///约局成员
@property (nonatomic , strong) NSMutableArray *members;

///街道
@property (nonatomic , copy) NSString *street;

///约局ID
@property (nonatomic, copy)NSString *invite_id;

///价钱
@property (nonatomic, copy)NSString *fee;
///是否加入
@property (nonatomic, strong)NSString *join;

///聊天室ID
@property (nonatomic, strong)NSString *im_group_id;
//地址
@property (nonatomic, strong)NSString *address;

//截止时间
@property (nonatomic, strong)NSString *end_time;



@end
