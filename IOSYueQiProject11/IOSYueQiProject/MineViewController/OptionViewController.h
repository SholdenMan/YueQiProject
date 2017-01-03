//
//  OptionViewController.h
//  Modo
//
//  Created by 程磊 on 16/9/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController
@property (nonatomic, copy) void(^signBlock)(NSString *sign);

@end
