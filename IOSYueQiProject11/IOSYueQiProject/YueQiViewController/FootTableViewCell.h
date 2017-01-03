//
//  FootTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopDetailModel;
@interface FootTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLAbel;
- (void)showWith:(ShopDetailModel *)model;
@end
