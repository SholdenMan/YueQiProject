//
//  SendMessageView.h
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/10/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendMessageView : UIView <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *MyTextView;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (nonatomic , copy) void(^confirmBlock)();
@property (nonatomic , copy) void(^cancleBlock)();

+ (SendMessageView *)sendMessageVie;

@end
