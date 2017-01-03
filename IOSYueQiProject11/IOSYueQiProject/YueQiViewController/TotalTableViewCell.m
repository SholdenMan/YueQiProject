//
//  TotalTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TotalTableViewCell.h"

@implementation TotalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showModel:(PersonModel*)model{
    [self layoutIfNeeded];
    self.totalLabel.text = model.game_times;
    self.cancelLabel.text = model.escape_times;
    self.daysLabel.text = model.month_game_times;
    CGRect rect = self.progressView.frame;
    CGFloat a;
    self.pieChartView = [[HKPieChartView alloc]initWithFrame:rect];
    if ([model.game_times isEqualToString:@"0"]) {
        a = 0;
    }else{
        a = model.escape_times.floatValue * 100 / model.game_times.floatValue;
    }
    [self.pieChartView updatePercent:a animation:YES];
    self.contentLabel.text =[NSString stringWithFormat:@"%.0lf%%",a];
    [self addSubview:self.pieChartView];
}

@end
