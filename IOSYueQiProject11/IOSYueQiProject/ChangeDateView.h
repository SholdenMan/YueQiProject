//
//  ChangeDateView.h
//  com.ahxmould.ring
//
//  Created by 敲代码mac1号 on 16/7/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeDateView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;

@property (nonatomic , copy) void(^finishBlock)();
+ (ChangeDateView *)changeDateView;

@end
