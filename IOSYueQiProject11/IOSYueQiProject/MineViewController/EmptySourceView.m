//
//  EmptySourceView.m
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/29.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "EmptySourceView.h"

@implementation EmptySourceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (EmptySourceView *)shareEmptySourceView {
    
    EmptySourceView *view = [[[NSBundle mainBundle] loadNibNamed:@"EmptySourceView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, TheW, TheH);
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

@end
