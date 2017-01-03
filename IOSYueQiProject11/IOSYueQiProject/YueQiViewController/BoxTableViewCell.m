//
//  BoxTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "BoxTableViewCell.h"
#import "TeaDetailModel.h"
@implementation BoxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showModel:(TeaDetailModel *)model{
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", model.price];
    self.averageLabel.text = [NSString stringWithFormat:@"门市价¥%@", model.original_price];
    self.boxscontentLabel.text= [NSString stringWithFormat:@"茶馆%@(%@小时)", model.name, model.hours];
    self.teaBoxTitle.text = [NSString stringWithFormat:@"符合预定时间段的包厢数:%@", model.idel_rooms];
}

@end
