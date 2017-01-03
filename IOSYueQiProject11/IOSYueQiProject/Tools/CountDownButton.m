//
//  CountDownButton.m
//  自定义
//
//  Created by Wangguibin on 2016/10/10.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "CountDownButton.h"
#import "UIView+LayoutMethods.h"
#import "MZTimerLabel.h"

@interface CountDownButton ()

@property (nonatomic,strong) UIImageView  *imgView;
@property (nonatomic,strong) UILabel *leftTitleLabel;
@property (nonatomic,strong) UILabel *rightLabel;

@end


@implementation CountDownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor=[UIColor blackColor];

    }
    return self;
}


- (void)show {
    
    [self setup];
    self.backgroundColor=[UIColor clearColor];
    
}
- (void)setup{
    [self removeSubviews];
    
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height ;

    UILabel *leftLabel =[[UILabel alloc] init];
    leftLabel.x = 0;
    leftLabel.y = 0;
    leftLabel.width = W/2;
    leftLabel.height= H;
    leftLabel.textAlignment=NSTextAlignmentCenter;
    leftLabel.font=[UIFont systemFontOfSize:12.0f];
    leftLabel.textColor = Color(87,198,200);
//    self.timeBtn.titleLabel.textColor = Color(87,198,200);

//    leftLabel.text = @"马上付款";
//    [self addSubview: leftLabel];
//    self.leftTitleLabel = leftLabel;

    UIImageView *imgView =[[UIImageView alloc] init];
    UIImage *image = [[UIImage alloc] init];
    if (self.imageName) {
        image = [UIImage imageNamed:self.imageName];
    }else{
        image = [UIImage imageNamed:@"timeImg"];
    }
    imgView.image =image;
    imgView.frame =CGRectMake(5, 20, 17 , 17);
    imgView.centerY = H/2;
    [self addSubview:imgView];
    self.imgView = imgView;

    UILabel *rightLabel =[[UILabel alloc] init];
    rightLabel.frame=CGRectMake(CGRectGetMaxX(imgView.frame)+4, 0, W - imgView.width-4 , H);
    rightLabel.font=[UIFont systemFontOfSize:15.0f];
    rightLabel.textColor =Color(87,198,200);
    rightLabel.text =@"00天00:00:00";
    [self addSubview: rightLabel];
    self.rightLabel = rightLabel;
}


- (void)showTime:(CGFloat )timeStr{
    NSString *nowTime = [HelpManager getCurrentTimestamp];
    CGFloat time = timeStr - [nowTime floatValue] ;
    self.timeStamp = time;
}

- (void)setTimeStamp:(CGFloat)timeStamp{
    _timeStamp = timeStamp;
    MZTimerLabel *mzLabel =[[MZTimerLabel alloc] initWithLabel:self.rightLabel andTimerType:MZTimerLabelTypeTimer];
    [mzLabel setCountDownTime:timeStamp];
    [mzLabel start];
}

- (void)removeSubviews{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
//    [super setTitle:title forState:state];
    [self.leftTitleLabel setText:title];
}


@end
