//
//  OrderClassModel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderClassModel : NSObject


@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *istap;

@property (nonatomic , strong) NSMutableArray *goods;

@end
