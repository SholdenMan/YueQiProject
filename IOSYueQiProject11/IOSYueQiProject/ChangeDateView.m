//
//  ChangeDateView.m
//  com.ahxmould.ring
//
//  Created by 敲代码mac1号 on 16/7/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChangeDateView.h"
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

@implementation ChangeDateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ChangeDateView *)changeDateView {
    ChangeDateView *view = [[NSBundle mainBundle] loadNibNamed:@"ChangeDateView" owner:nil options:nil].firstObject;
    view.backgroundColor = [UIColor  clearColor];
//    view.frame = CGRectMake(0, TheH, TheW, TheH);
//    [UIView animateWithDuration:0.25 animations:^{
//
    view.frame =  [UIScreen mainScreen].bounds;
//    }];
    
    return view;
}

- (IBAction)finishAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, TheH, TheW, TheH);
    } completion:^(BOOL finished) {
        if (self.finishBlock) {
            self.finishBlock();
        }
        [self removeFromSuperview];
    }];
}

- (IBAction)remove:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, TheH, TheW, TheH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
