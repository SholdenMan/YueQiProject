//
//  BoxDetailViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/21.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeaDetailModel;

@interface BoxDetailViewController : BaseViewController
@property (nonatomic, strong)TeaDetailModel *model;
@property (nonatomic, strong)NSString *string;
@property (nonatomic, strong)NSString *paytype;
@property (nonatomic, strong)NSString *beginTime;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, assign)NSDate *timeData;
@property (nonatomic, strong)NSString *gameID;

@end
