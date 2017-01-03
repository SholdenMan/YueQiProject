

//
//  ListTwoTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ListTwoTableViewCell.h"

@implementation ListTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

       // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)chooseBtnAction:(UIButton *)sender {
    self.chooseBlock(sender);
}

- (void)showDataWith:(TeaListModel *)model{
    self.model = model;
    [self layoutIfNeeded];
    self.nameLable.text = model.name;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ %@", model.region, model.distance];
    CGRect rect = self.startViews.frame;
    rect.size.height -= 5;
    rect.size.width = TheW / 4;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:rect numberOfStars:5];
    self.starRateView.scorePercent = self.model.grade.floatValue / 5.;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    [self addSubview:self.starRateView];
    self.gareLabel.text = [NSString stringWithFormat:@"%@分", self.model.grade];
}


@end
