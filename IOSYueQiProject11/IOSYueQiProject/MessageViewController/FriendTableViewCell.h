//
//  FriendTableViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (nonatomic , copy) void(^actionBlock)(UIButton *sender);


- (void)showSearchList:(LgAccount *)model;

- (void)showFriendList:(LgAccount *)model;

- (void)inviteList:(LgAccount *)model;
@end
