//
//  MessageClassTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MessageClassTableViewCell.h"

@implementation MessageClassTableViewCell


- (void)showData:(NSDictionary *)dic {
    self.iconImage.image = [UIImage imageNamed:dic[@"iconImage"]];
    self.contentLabel.text = dic[@"content"];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
