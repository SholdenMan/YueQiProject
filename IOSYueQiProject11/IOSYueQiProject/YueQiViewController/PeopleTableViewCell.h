//
//  PeopleTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartyListModel;
@class PartyPersonModel;
@interface PeopleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *personView;
@property (nonatomic, strong)NSString *teaID;
@property (nonatomic , copy) void(^myBlock)(PartyPersonModel *model);
@property (nonatomic, copy)void (^inviteBlock)(NSString *str);
@property (nonatomic, strong)PartyListModel *model;
- (void)showData:(PartyListModel *)model;

@end
