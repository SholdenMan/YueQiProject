//
//  BoxTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeaDetailModel;
@interface BoxTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageLabel;
@property (weak, nonatomic) IBOutlet UILabel *teaBoxTitle;
@property (weak, nonatomic) IBOutlet UILabel *boxscontentLabel;
- (void)showModel:(TeaDetailModel *)model;
@end
