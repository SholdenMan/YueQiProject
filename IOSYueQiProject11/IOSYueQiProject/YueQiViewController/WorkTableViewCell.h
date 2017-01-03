//
//  WorkTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonModel;
@interface WorkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
- (void)showMode:(PersonModel *)model;
@end
