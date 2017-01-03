//
//  ShowAlertView.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowAlertView : UIView



@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic , copy) void(^confirmBlock)();
@property (nonatomic , copy) void(^cancleBlock)();

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


+ (ShowAlertView *)showAlertView;

@end
