//
//  OrderViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/18.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeaListModel;
@interface OrderViewController : BaseViewController
@property (nonatomic, strong)TeaListModel *model;
@property (nonatomic, strong)NSString *paytype;
@property (nonatomic, strong)NSString *gameID;
@property (nonatomic, strong)NSString *beginTime;
@end
