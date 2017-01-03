//
//  ChooseTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChooseTableViewCell.h"

@implementation ChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)yudingAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
