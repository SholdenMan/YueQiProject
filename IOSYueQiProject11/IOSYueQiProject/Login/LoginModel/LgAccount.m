//
//  NewAccount.m
//  login
//
//  Created by MacBook on 15/12/2.
//  Copyright © 2015年 MacBook. All rights reserved.
//

#import "LgAccount.h"
@implementation LgAccount
//+ (NSDictionary *)mj_replacedKeyFromPropertyName;

//- (NSDictionary *)replacedkeyFromPropertyName

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    NSString *str = [NSString stringWithFormat:@"%@", keyedValues.class];
    NSLog(@"%@", str);
    
    if ([str isEqualToString:@"NSNull"]) {
        return;
    }
    NSLog(@"%@", keyedValues[@"portrait"]);
    self.head = [NSString stringWithFormat:@"%@", keyedValues[@"portrait"]];
    self.user = [NSString stringWithFormat:@"%@", keyedValues[@"phone"]];
    self.ids = [NSString stringWithFormat:@"%@", keyedValues[@"user_id"]];
    self.name = [NSString stringWithFormat:@"%@", keyedValues[@"nick_name"]];
    self.sex = [NSString stringWithFormat:@"%@", keyedValues[@"gender"]];
    self.location = [NSString stringWithFormat:@"%@", keyedValues[@"city"]];
    self.sign = [NSString stringWithFormat:@"%@", keyedValues[@"sign"]];
    self.initial = [NSString stringWithFormat:@"%@", keyedValues[@"initial"]];
    self.follow_state = [NSString stringWithFormat:@"%@", keyedValues[@"follow_state"]];
    self.in_club = [NSString stringWithFormat:@"%@", keyedValues[@"in_club"]];
    self.check_in_days = [NSString stringWithFormat:@"%@", keyedValues[@"check_in_days"]];
    self.fanscount = [NSString stringWithFormat:@"%@", keyedValues[@"fans"]];
    self.age = [NSString stringWithFormat:@"%@", keyedValues[@"age"]];
    self.club_role = [NSString stringWithFormat:@"%@", keyedValues[@"club_role"]];
    self.phone = [NSString stringWithFormat:@"%@", keyedValues[@"phone"]];
    self.smoking = [NSString stringWithFormat:@"%@", keyedValues[@"smoking"]];
    self.occupation = [NSString stringWithFormat:@"%@", keyedValues[@"occupation"]];
    if ([self.in_club isEqualToString:@"1"]) {
        
    }
    self.district = [NSString stringWithFormat:@"%@", keyedValues[@"district"]];
    self.city = [NSString stringWithFormat:@"%@", keyedValues[@"city"]];
    self.support_defriend = [NSString stringWithFormat:@"%@", keyedValues[@"support_defriend"]];
}




+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return@{@"ids": @"id"};
}
- (void)setJob:(NSString *)job
{


    if ([job isEqualToString:@"<null>"] || job.length == 0) {
        _job = @"未填写";
    }else{
        _job = job;
    }
}
- (void)setCompany:(NSString *)company
{
    
    if ([company isEqualToString:@"<null>"] || company.length == 0) {
        _company = @"未填写";
    }else{
        _company = company;
    }
}
- (void)setSchool:(NSString *)school
{
   
    if ([school isEqualToString:@"<null>"] || school.length == 0) {
        _school = @"未填写";
    }else{
        _school = school;
    }
}

- (void)setSign:(NSString *)sign {
    
    if ([sign isEqualToString:@"<null>"] || sign.length == 0) {
        _sign = @"未填写";
    } else {
        _sign = sign;
    }
}


- (void)setSex:(NSString *)sex {
  
    if ([sex isEqualToString:@"<null>"] || sex.length == 0) {
        _sex = @"未填写";
    } else {
        _sex = sex;

    }
}

- (void)setLocation:(NSString *)location {
    if ([location isEqualToString:@"<null>"] || location.length == 0) {
        _location = @"未填写";
    } else {
        _location = location;
    }
}

- (void)setName:(NSString *)name {
    if ([name isEqualToString:@"<null>"] || name.length == 0) {
        _name = @"未填写";
    } else {
        _name = name;
    }
}


//将对象写入文件
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.head forKey:@"head"];
    [aCoder encodeObject:self.ids forKey:@"ids"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.sign forKey:@"sign"];
    [aCoder encodeObject:self.orderNo forKey:@"orderNo"];
    [aCoder encodeObject:self.purpose forKey:@"purpose"];
    [aCoder encodeObject:self.rongtoken forKey:@"rongtoken"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.company forKey:@"company"];
    [aCoder encodeObject:self.job forKey:@"job"];
    [aCoder encodeObject:self.school forKey:@"school"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.vertify forKey:@"vertify"];
    [aCoder encodeObject:self.relationship forKey:@"relationship"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.initial forKey:@"initial"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.age forKey:@"age"];
}
//从文件中取出解析
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.ids = [aDecoder decodeObjectForKey:@"ids"];
        self.head = [aDecoder decodeObjectForKey:@"head"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.sign = [aDecoder decodeObjectForKey:@"sign"];
        self.orderNo = [aDecoder decodeObjectForKey:@"orderNo"];
        self.purpose = [aDecoder decodeObjectForKey:@"purpose"];
        self.rongtoken = [aDecoder decodeObjectForKey:@"rongtoken"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.company = [aDecoder decodeObjectForKey:@"company"];
        self.job = [aDecoder decodeObjectForKey:@"job"];
        self.school = [aDecoder decodeObjectForKey:@"school"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.vertify = [aDecoder decodeObjectForKey:@"vertify"];
        self.relationship = [aDecoder decodeObjectForKey:@"relationship"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.initial = [aDecoder decodeObjectForKey:@"initial"];
        self.province = [aDecoder decodeObjectForKey:@"province"];
    }
    return self;
}


@end
