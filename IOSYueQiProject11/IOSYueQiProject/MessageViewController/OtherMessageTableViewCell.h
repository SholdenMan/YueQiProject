//
//  OtherMessageTableViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface OtherMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic , copy) void(^actionBlock)(UIButton *sender);
- (void)showData:(MessageModel *)model;

@end
