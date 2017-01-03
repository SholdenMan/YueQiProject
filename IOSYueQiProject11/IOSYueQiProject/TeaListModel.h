//
//  TeaListModel.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TeaListModel : NSObject

@property (nonatomic, strong)NSString *teaID;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *region;
@property (nonatomic, strong)NSString *address;
@property (nonatomic, strong)NSString *grade;
@property (nonatomic, strong)NSMutableArray *detailArray;
@property (nonatomic, strong)NSString *categories;
@property (nonatomic, strong)NSString *distance;

@end
