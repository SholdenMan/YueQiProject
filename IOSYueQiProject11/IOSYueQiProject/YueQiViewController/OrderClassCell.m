//
//  OrderClassCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OrderClassCell.h"
#import "OrderClassModel.h"


@implementation OrderClassCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(OrderClassModel *)model {
    if ([model.istap isEqualToString:@"1"]) {
        self.coverView.hidden = NO;
    } else {
        self.coverView.hidden = YES;
    }
    self.contentLabel.text = model.name;

}
@end
