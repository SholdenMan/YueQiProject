//
//  ChangeInfoViewController.h
//  com.ahxmould.ring
//
//  Created by 敲代码mac1号 on 16/7/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeInfoViewController : BaseViewController

@property (nonatomic, copy) void(^changeBlock)(NSString *infor);
@property (nonatomic, copy) void(^changeJop)(NSString *job);

@end
