//
//  FriendTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
    
}

- (void)showSearchList:(LgAccount *)model {
    self.actionBtn.hidden = NO;
    self.actionBtn.layer.cornerRadius = 5;
    self.actionBtn.layer.masksToBounds = YES;
    self.actionBtn.backgroundColor = APPGreenColor;
    [self.actionBtn setTitle:@"加好友" forState:UIControlStateNormal];
    self.iconImage.layer.cornerRadius = 45.0 / 2;
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:nil];
    self.nameLabel.text = model.name;
}

- (void)showFriendList:(LgAccount *)model {
    if ([model.support_defriend isEqualToString:@"1"]) {
        self.actionBtn.hidden = NO;
        [self.actionBtn setTitle:@"拉黑" forState:UIControlStateNormal];
    }else{
        self.actionBtn.hidden = YES;
    }
    

    self.iconImage.layer.cornerRadius = 45.0 / 2;
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:nil];
    self.nameLabel.text = model.name;
}

- (void)inviteList:(LgAccount *)model{
    self.actionBtn.hidden = NO;
    self.actionBtn.layer.cornerRadius = 5;
    self.actionBtn.layer.masksToBounds = YES;
    self.actionBtn.backgroundColor = APPGreenColor;
    [self.actionBtn setTitle:@"邀请" forState:UIControlStateNormal];
    self.iconImage.layer.cornerRadius = 45.0 / 2;
    self.iconImage.layer.masksToBounds = YES;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:nil];
    self.nameLabel.text = model.name;

}


@end
