//
//  TeaDetailsTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TeaDetailsTableViewCell.h"
#import "ShopDetailModel.h"
@implementation TeaDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callAction:(UIButton *)sender {
    if (self.callBlock) {
        self.callBlock(sender);
    }
}
- (IBAction)pinjiaAction:(UIButton *)sender {
    if (self.commentMyBlock) {
        self.commentMyBlock(sender);
    }
}
- (void)showDataWith:(ShopDetailModel *)model{
    [self layoutIfNeeded];
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
    self.distanceLabel.text = model.distance;
    self.telStr = model.tel;
    self.gradeLabel.text = [NSString stringWithFormat:@"%@分", model.grade];
    CGRect rect = self.startView.frame;
    rect.size.height -= 5;
    rect.size.width = TheW / 4;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:rect numberOfStars:5];
    self.starRateView.scorePercent = model.grade.floatValue / 5.;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    [self addSubview:self.starRateView];
    [self.evaluateBtn setTitle:[NSString stringWithFormat:@"%@评价过 >", model.comment_count] forState:UIControlStateNormal];
}
@end
