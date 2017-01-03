//
//  FootTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FootTableViewCell.h"
#import "ShopDetailModel.h"

@implementation FootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showWith:(ShopDetailModel *)model{
     self.moreLAbel.text = [NSString stringWithFormat:@"营业时间: %@ -- %@(次日)", model.business_begin, model.business_end];
}

@end
