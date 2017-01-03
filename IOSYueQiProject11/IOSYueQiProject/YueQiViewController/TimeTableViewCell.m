//
//  TimeTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TimeTableViewCell.h"

@implementation TimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)changeTimeAction:(UIButton *)sender {
    NSLog(@"新煌傻逼");
    ChangeDateView *changeView = [ChangeDateView changeDateView];
    changeView.birthdayPicker.datePickerMode = UIDatePickerModeDateAndTime;
    [[UIApplication sharedApplication].keyWindow addSubview:changeView];
    [changeView setFinishBlock:^{
        self.timeBlock(changeView.birthdayPicker.date);
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
