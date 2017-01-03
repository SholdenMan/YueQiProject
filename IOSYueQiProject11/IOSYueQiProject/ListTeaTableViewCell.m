//
//  ListTeaTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/31.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ListTeaTableViewCell.h"
#import "TeaListModel.h"

@implementation ListTeaTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    CGRect rect = self.startIamge.frame;
//    rect.size.height -= 5;
//    rect.size.width = TheW / 4;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:rect numberOfStars:5];
    self.starRateView.scorePercent = 1.;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    //    starRateView.delegate = self;
    [self addSubview:self.starRateView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moreAction:(UIButton *)sender {
}
- (void)showDataWith:(TeaListModel *)model{
    self.model = model;
    self.titleLabel.text = model.name;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:nil];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@ %@", model.region, model.distance];
    
        
    
}

@end
