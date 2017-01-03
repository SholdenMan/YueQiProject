//
//  TicketTableViewCell.h
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketModel;

@interface TicketTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (nonatomic, strong)TicketModel *model;
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@property (nonatomic, copy)void(^showBlock)(UIButton *);
@property (nonatomic, copy)void(^useBlock)(TicketModel *);

- (void)showData:(TicketModel *)model;

@end
