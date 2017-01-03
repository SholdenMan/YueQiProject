//
//  InformationTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "InformationTableViewCell.h"
#import "PersonModel.h"

@implementation InformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showModel:(PersonModel *)model{
    
    self.sexLabel.layer.masksToBounds = YES;
    self.sexLabel.layer.cornerRadius = 5;
    self.relationLabel.layer.masksToBounds = YES;
    self.relationLabel.layer.cornerRadius = 5;
    if ([model.gender isEqualToString:@"0"]) {
        self.sexLabel.backgroundColor = [UIColor redColor];
        self.sexLabel.text = [NSString stringWithFormat:@"♀%@岁", model.age];
    }else{
        self.sexLabel.backgroundColor = self.relationLabel.backgroundColor;
        self.sexLabel.text = [NSString stringWithFormat:@"♂%@岁", model.age];
    }
    switch (model.emotion.integerValue) {
        case 0:
            self.relationLabel.text =  @"保密";
            break;
        case 1:
            self.relationLabel.text =  @"单身";

            break;
        case 2:
            self.relationLabel.text =  @"恋爱";

            break;
        case 3:
            self.relationLabel.text =  @"已婚";

            break;
        case 4:
            self.relationLabel.text =  @"未婚";

            break;
        default:
            break;
    }
    
    
    
}

@end
