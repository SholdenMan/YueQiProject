//
//  PayViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartyListModel;
@interface PayViewController : BaseViewController
@property (nonatomic, strong)PartyListModel *model;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *paytype;
@property (nonatomic, strong)NSString *storeID;
@property (nonatomic, strong)NSString *roomID;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *gameID;
@property (nonatomic, strong)NSString *order_no;

@end
