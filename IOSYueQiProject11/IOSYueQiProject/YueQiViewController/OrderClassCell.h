//
//  OrderClassCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderClassModel;

@interface OrderClassCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;

- (void)showData:(OrderClassModel *)model;


@end
