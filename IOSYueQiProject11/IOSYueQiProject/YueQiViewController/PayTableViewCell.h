//
//  PayTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayModel;

@interface PayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)showModel:(PayModel *)model;

@end
