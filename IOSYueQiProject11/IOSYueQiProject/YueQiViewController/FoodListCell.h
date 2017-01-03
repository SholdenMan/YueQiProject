//
//  FoodListCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodListModel;

@interface FoodListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *count;

@property (nonatomic , copy) void(^addBlock)(UIButton *sender);
@property (nonatomic , copy) void(^reduceBlock)(UIButton *sender);

- (void)showData:(FoodListModel *)model;

@end
