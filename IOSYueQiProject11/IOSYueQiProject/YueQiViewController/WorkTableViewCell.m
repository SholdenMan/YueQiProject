//
//  WorkTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "WorkTableViewCell.h"
#import "PersonModel.h"
@implementation WorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showMode:(PersonModel *)model{
    if ([model.occupation isEqualToString:@"<null>"]) {
        self.workLabel.text = @"此人很懒, 还未填写.";
    }else{
        self.workLabel.text = [NSString stringWithFormat:@"%@", model.occupation];
    }
    self.contentLabel.text = model.city;
    if ([model.sign isEqualToString:@"<null>"]) {
         self.signLabel.text = @"此人很懒, 还未填写.";
    }else{
        self.signLabel.text = model.sign;
    }

}
@end
