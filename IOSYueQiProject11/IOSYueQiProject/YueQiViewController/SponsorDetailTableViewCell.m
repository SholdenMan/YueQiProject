//
//  SponsorDetailTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SponsorDetailTableViewCell.h"
#import "PartyListModel.h"
@implementation SponsorDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)changeTimeAction:(UIButton *)sender {
    if ([self.model.owned isEqualToString:@"1"]) {
        ChangeDateView *changeView = [ChangeDateView changeDateView];
        changeView.birthdayPicker.datePickerMode = UIDatePickerModeDateAndTime;
        [[UIApplication sharedApplication].keyWindow addSubview:changeView];
        [changeView setFinishBlock:^{
            self.timeBlock(changeView.birthdayPicker.date);
        }];
    }else{
        [MBProgressHUD showError:@"只有发起人有权限修改" toView:nil];
    }

}

- (NSString *)dateText:(double)date {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init]; [formatter setDateFormat:@"MM月dd日HH时mm分"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (void)showData:(PartyListModel *)model{
    self.model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.subject];
    self.numberLabel.text = [NSString stringWithFormat:@"%@", model.ids];
    self.startTimeLabel.text = [self dateText:[model.create_time doubleValue] / 1000];
    self.playTimeLabel.text = [self dateText:[model.begin_time doubleValue] / 1000];
    self.planTimeLabel.text = [NSString stringWithFormat:@"%@小时", model.hours];
    self.payMoneyLabel.text = [NSString stringWithFormat:@"¥%@", model.fee];
    self.addressLabel.text = [NSString stringWithFormat:@"%@", model.address];
    if ([model.pay_type isEqualToString:@"0"]) {
        self.payStyeLabel.text = @"AA制";
        self.payStyeLabel.backgroundColor = Color(90, 216, 218);
    } else {
        self.payStyeLabel.backgroundColor = Color(249, 113, 117);
        self.payStyeLabel.text = @"我请客";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
