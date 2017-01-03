//
//  ShowCommentCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShowCommentCell.h"
#import "ShowCommentModel.h"

@implementation ShowCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) showData:(ShowCommentModel *)model {
    [self.stareView show:5];
    self.stareView.scorePercent = [model.grade floatValue] / 5.;
    self.stareView.allowIncompleteStar = YES;
    self.stareView.hasAnimation = YES;
    self.stareView.userInteractionEnabled = NO;
    
    self.iconImage.layer.cornerRadius = 23;
    self.iconImage.layer.masksToBounds = YES;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.nick_name;
    self.pingCount.text = model.grade;
    self.contentLabel.text = model.content;
    self.dateLabel.text = [HelpManager gettttDate:model.create_time WithFormatter:@"yyyy-MM-dd"];
}




@end
