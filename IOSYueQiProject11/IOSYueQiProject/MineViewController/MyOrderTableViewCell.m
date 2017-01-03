//
//  MyOrderTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goPayAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}
- (void)showMode:(MyOrderModel *)model{
    self.typeLabel.textColor = [UIColor colorWithRed:14/255.0 green:178/255.0 blue:181/255.0 alpha:1.0];
    //设置边框颜色
    self.myBtn.layer.borderColor = [[UIColor colorWithRed:244/255.0 green:125/255.0 blue:45/255.0 alpha:1.0] CGColor];
    //设置边框宽度
    self.myBtn.layer.borderWidth = 1.0f;
    //给按钮设置角的弧度
    self.myBtn.layer.cornerRadius = 4.0f;
    self.myBtn.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 4.0f;
    self.iconImage.layer.masksToBounds = YES;

    switch ([model.state integerValue]) {
        case 0:
        {
            self.typeLabel.text = @"待支付";
            self.myBtn.hidden = NO;
            [self.myBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            self.typeLabel.text = @"交易完成";
            self.myBtn.hidden = YES;
//            [self.myBtn setTitle:@"评价" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
         self.typeLabel.text = @"交易已取消";
            self.myBtn.hidden = YES;
        }
            break;
        case 3:
        {
            self.typeLabel.text = @"商家备餐";
            self.myBtn.hidden = YES;
//            [self.myBtn setTitle:@"评价" forState:UIControlStateNormal];
        }
            break;
        case 4:
        {
            self.typeLabel.text = @"送餐中";
            self.myBtn.hidden = YES;
        }
            break;
        case 21:
        {
            self.typeLabel.textColor = [UIColor colorWithRed:255/255.0 green:94/255.0 blue:94/255.0 alpha:1.0];
            self.typeLabel.text = @"等待退款";
            self.myBtn.hidden = YES;
        }
            break;
        case 22:
        {
            self.typeLabel.text = @"退款成功";
            self.myBtn.hidden = YES;
        }
            break;
        case 11:{
            self.typeLabel.text = @"等待评论";
            self.myBtn.hidden = NO;
            [self.myBtn setTitle:@"去评价" forState:UIControlStateNormal];
        }
        default:
        {
            self.typeLabel.text = @"交易失败异常";
            self.myBtn.hidden = YES;
        }
            break;
    }
    self.teaShopnameLabel.text = [NSString stringWithFormat:@"%@", model.store_name];
    self.shopname.text = [NSString stringWithFormat:@"%@", model.name];
    self.payLabel.text = [NSString stringWithFormat:@"方式: %@", model.pay_type_text];
    self.numberLabel.text = [NSString stringWithFormat:@"数量: %@", model.num];
    self.priceLabel.text = [NSString stringWithFormat:@"价格: %@", model.price_text];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:nil];
}
@end
