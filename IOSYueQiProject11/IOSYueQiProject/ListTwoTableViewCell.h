//
//  ListTwoTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "TeaListModel.h"
@interface ListTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIView *startViews;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *gareLabel;
@property (weak, nonatomic) IBOutlet UILabel *newdisLabel;
@property (nonatomic, strong)TeaListModel *model;
@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, copy)void(^chooseBlock)(UIButton *);
- (void)showDataWith:(TeaListModel *)model;
//- (void)showFindWith:(TeaListModel *)findModel;
@end
