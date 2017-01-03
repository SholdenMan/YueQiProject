//
//  nearView.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/24.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "nearView.h"

@implementation nearView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
   self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    //    _label.backgroundColor = [UIColor redColor];
    self.moreButton.tintColor = [UIColor lightGrayColor];
    self.moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.moreButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [self.contentView addSubview:self.moreButton];
    //    _imageViewOfMore.backgroundColor = [UIColor yellowColor];
}
// Layout布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    self.titleLabel.frame = CGRectMake(5, 5, width / 3, height - 10);
    self.moreButton.frame = CGRectMake(width - 60, 5, 50, height - 10);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
