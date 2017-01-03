//
//  FriendRequestsTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FriendRequestsTableViewCell.h"
#import "MessageModel.h"
#import "Contactmodel.h"

@implementation FriendRequestsTableViewCell

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

- (void)showData:(MessageModel *)model {
    self.actionBtn.layer.cornerRadius = 5;
    self.actionBtn.layer.masksToBounds = YES;

    if ([model.isRead isEqualToString:@"0"]) {
        
        self.actionBtn.backgroundColor = APPGreenColor;
        [self.actionBtn setTitle:@"接受" forState:UIControlStateNormal];
        self.actionBtn.enabled = YES;
    } else {
        self.actionBtn.backgroundColor = Color(202, 202, 202);
        [self.actionBtn setTitle:@"已接受" forState:UIControlStateNormal];
        self.actionBtn.enabled = NO;
    }
    self.headImage.layer.cornerRadius = 45.0 / 2;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.nameLabel.text = model.title;
    self.contentLabel.text = model.extra[@"reason"];
    
}


- (void)showConta:(Contactmodel *)model {
    self.actionBtn.layer.cornerRadius = 5;
    self.actionBtn.layer.masksToBounds = YES;
    
    if ([model.apply_state isEqualToString:@"0"]) {
        self.actionBtn.backgroundColor = APPGreenColor;
        [self.actionBtn setTitle:@"加好友" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.actionBtn.backgroundColor = [UIColor whiteColor];
        [self.actionBtn setTitle:@"已发送" forState:UIControlStateNormal];
        [self.actionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.headImage.layer.cornerRadius = 45.0 / 2;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
    self.nameLabel.text = model.nick_name;
    self.contentLabel.text = model.contact_user_name;
    
}

@end
