//
//  TicketTableViewCell.m
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "TicketTableViewCell.h"
#import "TicketModel.h"

@implementation TicketTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)useAction:(id)sender {
    if (self.useBlock) {
        self.useBlock(self.model);
    }
    
}

- (void)showData:(TicketModel *)model {
    self.model = model;
    if ([model.state isEqualToString:@"-1"]) {
        self.backgroundImage.image = [UIImage imageNamed:@"bg-discount couponyy-n"];
        self.showButton.hidden = NO;
        self.stateLabel.text = @"过期";
        self.useBtn.hidden = YES;
        self.stateLabel.textColor = Color(189, 190, 190);
    } else if([model.state isEqualToString:@"1"]) {
        self.backgroundImage.image = [UIImage imageNamed:@"bg-discount couponyy-p"];
        self.showButton.hidden = YES;

        self.stateLabel.text = @"立即使用";
        self.useBtn.hidden = NO;

        self.stateLabel.textColor = Color(90, 193, 234);
    }else{
        self.backgroundImage.image = [UIImage imageNamed:@"bg-discount couponyy-n"];
        self.showButton.hidden = NO;
        self.stateLabel.text = @"已使用";
        self.useBtn.hidden = YES;
        self.stateLabel.textColor = Color(189, 190, 190);
    }
    
    self.contentLabel.text = model.name;
    self.titleLabel.text = model.store_name;
    self.dateLabel.text = [HelpManager getDateStringWithDate:model.expire_at];
}
- (IBAction)showActin:(UIButton *)sender {
    self.showBlock(sender);
}


@end
