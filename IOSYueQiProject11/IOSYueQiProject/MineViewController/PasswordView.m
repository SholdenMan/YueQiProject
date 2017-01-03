//
//  PasswordView.m
//  Verification
//
//  Created by 敲代码mac2号 on 16/6/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PasswordView.h"

@implementation PasswordView

+ (PasswordView *)passWordViewInitWith:(CGRect )fram {

    PasswordView *view = [[[NSBundle mainBundle] loadNibNamed:@"PasswordView" owner:nil options:nil] firstObject];
    
    view.frame = fram;
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:123 / 255.0 green:123 / 255.0 blue:123 / 255.0 alpha:0.5].CGColor;
    view.passWordTextFile.secureTextEntry = YES;
    return view;
}



//密码明文和密文
- (IBAction)changeImage:(id)sender {
    self.passWordTextFile.secureTextEntry = !self.passWordTextFile.secureTextEntry;
    self.closeButon.selected = !self.closeButon.selected;
}
//清除输入框
- (IBAction)clean:(id)sender {
    self.passWordTextFile.text = @"";
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
