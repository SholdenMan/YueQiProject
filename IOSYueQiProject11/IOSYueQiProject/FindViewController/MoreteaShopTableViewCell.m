//
//  MoreteaShopTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/22.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MoreteaShopTableViewCell.h"

@implementation MoreteaShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goAllAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock();
    }
}

@end
