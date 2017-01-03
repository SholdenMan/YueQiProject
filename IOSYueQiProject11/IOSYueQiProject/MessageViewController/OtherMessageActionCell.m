//
//  OtherMessageActionCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/13.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OtherMessageActionCell.h"
#import "MessageModel.h"



@implementation OtherMessageActionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(MessageModel *)model {
    self.backImage.layer.cornerRadius = 7;
    self.backImage.layer.masksToBounds = YES;
    
    self.refusedBtn.layer.cornerRadius = 4;
    self.refusedBtn.layer.masksToBounds = YES;
    self.refusedBtn.layer.borderWidth = 1;
    self.refusedBtn.layer.borderColor = Color(14, 178, 181).CGColor;
    
    self.agreeBtn.layer.cornerRadius = 4;
    self.agreeBtn.layer.masksToBounds = YES;
    self.agreeBtn.backgroundColor = Color(14, 178, 181);
    
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

- (IBAction)refusedAction:(UIButton *)sender {
    if(self.refuseBlock) {
        self.refuseBlock(sender);
    }
}


- (IBAction)agreeAction:(UIButton *)sender {
    if(self.agreeBlock) {
        self.agreeBlock(sender);
    }
}



@end
