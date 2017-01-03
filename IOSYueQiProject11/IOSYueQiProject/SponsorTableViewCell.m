//
//  SponsorTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SponsorTableViewCell.h"

@implementation SponsorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)cancleAction:(UIButton *)sender {
    self.cancleBlock(sender);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
