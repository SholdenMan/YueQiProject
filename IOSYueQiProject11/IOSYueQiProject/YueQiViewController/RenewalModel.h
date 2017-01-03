//
//  RenewalModel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenewalModel : NSObject
@property (nonatomic , copy) NSString *pay_type; //0:AA制    1:我请客
@property (nonatomic , copy) NSString *cost; //实际支付（单价除以人数)
@property (nonatomic , copy) NSString *pay_type_text; //
@property (nonatomic , copy) NSString *price; //单价
@end

