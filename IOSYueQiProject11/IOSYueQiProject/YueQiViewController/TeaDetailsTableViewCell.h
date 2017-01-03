//
//  TeaDetailsTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@class ShopDetailModel;
@interface TeaDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *evaluateBtn;
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, copy)void(^commentMyBlock)(UIButton *);
@property (nonatomic, copy)void (^callBlock)(UIButton *);

@property (nonatomic, strong)NSString *telStr;
- (void)showDataWith:(ShopDetailModel *)model;

@end
