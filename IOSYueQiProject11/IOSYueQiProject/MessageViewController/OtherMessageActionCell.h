//
//  OtherMessageActionCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/13.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;

@interface OtherMessageActionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *refusedBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (nonatomic , copy) void(^agreeBlock)(UIButton *sender);
@property (nonatomic , copy) void(^refuseBlock)(UIButton *sender);


- (void)showData:(MessageModel *)model;

@end
