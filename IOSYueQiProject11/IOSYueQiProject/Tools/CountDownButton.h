//
//  CountDownButton.h
//  自定义
//
//  Created by Wangguibin on 2016/10/10.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton

@property (nonatomic,assign) CGFloat timeStamp;
@property (nonatomic, strong)NSString *imageName;
- (void)show;
- (void)showTime:(CGFloat )timeStr;
@end
