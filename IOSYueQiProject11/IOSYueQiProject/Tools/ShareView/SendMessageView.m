//
//  SendMessageView.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/10/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SendMessageView.h"

@implementation SendMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (IBAction)see:(UITapGestureRecognizer *)sender {
//    [self.MyTextView resignFirstResponder];
//}

+ (SendMessageView *)sendMessageVie {
    SendMessageView *view = [[[NSBundle mainBundle] loadNibNamed:@"SendMessageView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, TheW, TheH);

    view.backgroundColor = [UIColor clearColor];
    view.showView.layer.cornerRadius = 15;
    view.showView.layer.masksToBounds = YES;
       view.MyTextView.delegate = view;
    view.MyTextView.returnKeyType = UIReturnKeyDone;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapssss:)];
    [view addGestureRecognizer:tap1];
    return view;
}


- (void)tapssss:(UITapGestureRecognizer *)SEND {
    [self.MyTextView resignFirstResponder];
}
- (IBAction)cancelAction:(UIButton *)sender {
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self removeFromSuperview];

    
}
- (IBAction)confirmAction:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock();
    }

    [self removeFromSuperview];
}

#pragma mark -UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.MyTextView resignFirstResponder];
    }
    return YES;
}


@end
