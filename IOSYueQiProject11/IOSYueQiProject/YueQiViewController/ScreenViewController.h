//
//  ScreenViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenViewController : BaseViewController

@property (nonatomic, copy)void(^myBlock)(NSString *str);

@end
