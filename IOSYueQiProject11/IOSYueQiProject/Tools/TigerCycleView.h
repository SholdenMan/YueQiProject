//
//  TigerCycleView.h
//  OurProjectA
//
//  Created by tiger on 16/3/28.
//  Copyright © 2016年 爬虫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TigerCycleView : UIView
@property (nonatomic, copy)void(^tapBlock)(NSInteger pageIndex);
// 数组, fram, 时间
///轮播图初始化方法
- (id)initWithImageUrlArray:(NSMutableArray *)imageUrlArray imageChangeTime : (NSTimeInterval)timeInterval Frame : (CGRect )frame;

///释放定时器
- (void)removeTimer;

@end
