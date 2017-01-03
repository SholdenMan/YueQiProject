//
//  FoodListModel.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   "name": "鸡腿2",
 "icon": "http://static.binvshe.com/static/test/20161030012302498350_283*220.jpg",
 */

@interface FoodListModel : NSObject

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *icon;
@property (nonatomic , copy) NSString *price;
@property (nonatomic , copy) NSString *ids;

@property (nonatomic , assign) NSInteger count;

@end
