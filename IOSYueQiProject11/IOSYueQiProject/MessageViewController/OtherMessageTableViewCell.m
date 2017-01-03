//
//  OtherMessageTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OtherMessageTableViewCell.h"
#import "MessageModel.h"
@implementation OtherMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
}


- (void)showData:(MessageModel *)model {
//    if ([model.isRead isEqualToString:@"1"]) {
//        self.isReadImage.hidden = YES;
//    } else {
//        self.isReadImage.hidden = NO;
//    }
//    self.isReadImage.layer.cornerRadius = 5;
//    self.isReadImage.layer.masksToBounds = YES;
    self.backImage.layer.cornerRadius = 7;
    self.backImage.layer.masksToBounds = YES;
    
    self.dateLabel.text =[self dateText:[model.date doubleValue] / 1000];
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
}

- (NSString *)dateText:(double)date {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init]; [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


@end
