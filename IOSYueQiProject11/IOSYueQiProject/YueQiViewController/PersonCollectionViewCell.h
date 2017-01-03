//
//  PersonCollectionViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyPersonModel.h"
@class PartyListModel;
@interface PersonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *hatView;
@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;
@property (nonatomic, strong)PartyPersonModel *model;
@property (nonatomic, strong)PartyListModel *ownModel;
@property (nonatomic , copy) void(^myBlock)(PartyPersonModel *model);

@property (weak, nonatomic) IBOutlet UILabel *payLabel;

- (void)showData:(PartyPersonModel *)model with:(NSString *)type;


- (void)showDataDetail:(PartyPersonModel *)model with:(NSString *)type;

@end
