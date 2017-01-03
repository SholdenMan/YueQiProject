//
//  ListTeaTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "TeaListModel.h"

@interface ListTeaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *startIamge;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameoneLagel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *costTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketALabel;
@property (weak, nonatomic) IBOutlet UILabel *nametwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbertwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *moraBtn;
@property (nonatomic, strong)TeaListModel *model;
@property (weak, nonatomic) IBOutlet UIButton *nowShopBtn;

@property (strong, nonatomic) CWStarRateView *starRateView;
- (void)showDataWith:(TeaListModel *)model;
@end
