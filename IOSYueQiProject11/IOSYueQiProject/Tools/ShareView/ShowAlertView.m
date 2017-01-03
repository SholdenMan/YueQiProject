//
//  ShowAlertView.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShowAlertView.h"

@implementation ShowAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (ShowAlertView *)showAlertView {
    ShowAlertView *view = [[[NSBundle mainBundle] loadNibNamed:@"ShowAlertView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, TheW, TheH);
    
    view.backgroundColor = [UIColor clearColor];
    view.showView.layer.cornerRadius = 15;
    view.showView.layer.masksToBounds = YES;

    return view;
}



- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    
    [self removeFromSuperview];
    
}



- (IBAction)cancelAction:(UIButton *)sender {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self removeFromSuperview];

    
}


@end
