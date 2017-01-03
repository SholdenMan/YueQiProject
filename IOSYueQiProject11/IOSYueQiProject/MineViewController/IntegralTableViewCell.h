//
//  IntegralTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
