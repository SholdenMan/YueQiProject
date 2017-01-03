//
//  FoodListCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FoodListCell.h"
#import "FoodListModel.h"

@implementation FoodListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(FoodListModel *)model {
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.price.text = [NSString stringWithFormat:@"¥ %@", model.price];
    self.count.text = [NSString stringWithFormat:@"%ld", model.count];
    self.name.text = model.name;
}

- (IBAction)addAction:(UIButton *)sender {
    
    if (self.addBlock) {
        self.addBlock(sender);
    }
}


- (IBAction)reduceAction:(UIButton *)sender {
    if (self.reduceBlock) {
        self.reduceBlock(sender);
    }
}






@end
