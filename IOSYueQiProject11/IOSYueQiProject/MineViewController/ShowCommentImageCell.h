//
//  ShowCommentImageCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"

@class ShowCommentModel;

@interface ShowCommentImageCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet CWStarRateView *stareView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingCount;

@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , copy) void(^indexPathBlock)(NSIndexPath *index);

- (void)showData:(ShowCommentModel *)model;

@end
