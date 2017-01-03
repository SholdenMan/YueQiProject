//
//  CustumAlterView.m
//  IM
//
//  Created by 敲代码mac1号 on 16/6/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "CustumAlterView.h"

#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height



@implementation CustumAlterView




+ (CustumAlterView *)custumAlterViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CustumAlterViewMode)preferredStyle {
    CustumAlterView *view = [[[NSBundle mainBundle] loadNibNamed:@"CustumAlterView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, TheW, TheH);
    view.deleteBtn.hidden = YES;
    switch (preferredStyle) {
        case CustumAlterViewNormal:
            break;
        case CustumAlterViewNoTitle:
        {
            view.titleLabel.hidden = YES;
            view.titleLabelHight.constant = 0;
            view.messageLabelHight.constant = 98 + 41;
        }
            break;
        case CustumAlterViewNoCancel:
        {
            view.deleteBtn.hidden = NO;
            view.cancelButn.hidden  = YES;
            view.confirmBtnWidth.constant = TheW - 31 * 2;
            
        }
            break;
        case CustumAlterViewNoCancelNotitle:
        {
            view.titleLabel.hidden = YES;
            view.titleLabelHight.constant = 0;
            view.messageLabelHight.constant = 98 + 41;
            view.cancelButn.hidden  = YES;
            view.confirmBtnWidth.constant = TheW - 31 * 2;
        }
            break;
        default:
            break;
    }
    
    [view.cancelButn setTitleColor:Color(137,133,133) forState:UIControlStateNormal];
    [view.cancelButn setTitleColor:Color(26,180,213) forState:UIControlStateHighlighted];
    [view.confirmBtn setTitleColor:Color(137,133,133) forState:UIControlStateNormal];
    [view.confirmBtn setTitleColor:Color(26,180,213) forState:UIControlStateHighlighted];
    
    view.showView.layer.cornerRadius = 8;
    view.showView.layer.masksToBounds = YES;
    view.titleLabel.text = title;
    view.messageLabel.text = message;
    [view.cancelButn setTitle:@"取消" forState:UIControlStateNormal];
    [view.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
   
    return view;
}


- (void)showCancle:(void(^)())cancleBlock accept:(void(^)())confirmBlock {
    self.cancleBlock = cancleBlock;
    self.confirmBlock = confirmBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)drawRect:(CGRect)rect {
    
}


- (IBAction)cancelAction:(UIButton *)sender {
    if (self.cancleBlock) {
        self.cancleBlock();
        [self removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.isUnbundling) {
        [self.showView removeFromSuperview];
        if (self.confirmBlock) {
            self.confirmBlock();
        }
    } else {
        if (self.confirmBlock) {
            self.confirmBlock();
            [self removeFromSuperview];
        }
        [self removeFromSuperview];
    }
}

- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    //[self removeFromSuperview];
}

@end
