//
//  InviteTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyPersonModel.h"

@class PartyListModel;

@interface InviteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *typelabel;
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLongLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *personView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (nonatomic , copy) void(^myBlock)(PartyPersonModel *model);
@property (nonatomic, copy)void(^chooseBlock)(UIButton *);
- (void)showData:(PartyListModel *)model;
@end
