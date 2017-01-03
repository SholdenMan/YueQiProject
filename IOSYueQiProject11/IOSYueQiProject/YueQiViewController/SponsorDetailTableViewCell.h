//
//  SponsorDetailTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartyListModel;
@interface SponsorDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *planTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *payStyeLabel;
@property (nonatomic, copy)void(^timeBlock)(NSDate *);
@property (nonatomic, strong)PartyListModel *model;
- (void)showData:(PartyListModel *)model;



@end
