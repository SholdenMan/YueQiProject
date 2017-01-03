//
//  FriendRequestsTableViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contactmodel;
@interface FriendRequestsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic , copy) void(^actionBlock)(UIButton *sender);

- (void)showData:(MessageModel *)model;
- (void)showConta:(Contactmodel *)model;
@end
