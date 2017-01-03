//
//  OftenTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@class TeaShopModel;
@interface OftenTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UILabel *graderLabel;
@property (strong, nonatomic) CWStarRateView *starRateView;

- (void)showModel:(TeaShopModel *)model;
@end
