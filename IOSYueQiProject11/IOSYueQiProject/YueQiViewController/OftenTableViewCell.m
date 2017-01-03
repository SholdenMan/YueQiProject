//
//  OftenTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OftenTableViewCell.h"
#import "TeaShopModel.h"
@implementation OftenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showModel:(TeaShopModel *)model{
    [self layoutIfNeeded];
    CGRect rect = self.startView.frame;
    rect.size.height -= 5;
    rect.size.width = TheW / 4;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:rect numberOfStars:5];
    self.starRateView.scorePercent = model.grade.floatValue / 5.;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    [self addSubview:self.starRateView];
    self.graderLabel.text = [NSString stringWithFormat:@"%@分", model.grade];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.nameLabel.text = model.name;
    
    
    
}

@end
