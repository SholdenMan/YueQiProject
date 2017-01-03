//
//  NewAccount.h
//  login
//
//  Created by MacBook on 15/12/2.
//  Copyright © 2015年 MacBook. All rights reserved.
//  29条用户信息

#import <Foundation/Foundation.h>


@interface LgAccount : NSObject <NSCoding>
//用户id
@property (nonatomic, copy) NSString *ids;

//年龄
@property (nonatomic, copy)NSString *age;

//用户账号 
@property (nonatomic, copy) NSString *user;

//用户验证码
@property (nonatomic, copy) NSString *vertify;

//头像
@property (nonatomic, copy) NSString *head;
//我的昵称
@property (nonatomic, copy) NSString *name;

//密码
@property (nonatomic, copy) NSString *password;

//性别
@property (nonatomic, copy) NSString *sex;
//生日
@property (nonatomic, copy) NSString *birthday;
//公司
@property (nonatomic, copy) NSString *company;
//职业
@property (nonatomic, copy) NSString *job;
//大学
@property (nonatomic, copy) NSString *school;
//个性签名
@property (nonatomic, copy) NSString *sign;
//订单号
@property (nonatomic, copy) NSString *orderNo;
//付款类型
@property (nonatomic, copy) NSString *purpose;
//融云token
@property (nonatomic, copy) NSString *rongtoken;
//密码
@property (nonatomic, copy) NSString *pwd;

//手机号
@property (nonatomic, copy)NSString *phone;

//抽烟
@property (nonatomic, copy)NSString *smoking;
//职业
@property (nonatomic, copy)NSString *occupation;

//关系
@property (nonatomic , copy) NSString *relationship;

//所在地(城市)
@property (nonatomic , copy) NSString *location;
//所在地(省份)
@property (nonatomic , copy) NSString *province;

//@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *district;

@property (nonatomic, strong)NSString *city;

//我的昵称的首字母
@property (nonatomic , copy) NSString *initial;

//是否拥有社团
@property (nonatomic , copy) NSString *in_club;

//关注的状态
@property (nonatomic , copy) NSString *follow_state;

//粉丝数量
@property (nonatomic , copy) NSString *fanscount;

//积分
@property (nonatomic, copy)NSString *score;


//连续签到多少天
@property (nonatomic, strong)NSString *check_in_days;

//是否是团长
@property (nonatomic, strong)NSString *club_role;

//是否拉黑
@property (nonatomic, strong)NSString *support_defriend;


@end
