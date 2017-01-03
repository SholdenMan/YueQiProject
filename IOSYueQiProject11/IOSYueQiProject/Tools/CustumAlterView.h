//
//  CustumAlterView.h
//  IM
//
//  Created by 敲代码mac1号 on 16/6/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum {
    CustumAlterViewNormal, /*默认模式 都有*/
    CustumAlterViewNoTitle, /*没有标题*/
    CustumAlterViewNoCancelNotitle, /*没有取消按钮, 没有标题*/
    CustumAlterViewNoCancel /*没有取消按钮*/
} CustumAlterViewMode; /* CustumAlterView的样式 */

@interface CustumAlterView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel; /*标题label*/
@property (weak, nonatomic) IBOutlet UILabel *messageLabel; /*内容label*/
@property (weak, nonatomic) IBOutlet UIButton *cancelButn; ///取消按钮
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn; /*确定按钮*/

@property (weak, nonatomic) IBOutlet UIView *showView; /*展示的弹出白图*/
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn; /*X按钮*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmBtnWidth; /*确定按钮的宽度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelHight; /*标题label的高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageLabelHight; /*内容label的高度约束*/

@property (nonatomic, copy) void(^confirmBlock)();
@property (nonatomic, copy) void(^cancleBlock)();

@property (nonatomic , assign) BOOL isUnbundling;


+ (CustumAlterView *)custumAlterViewWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(CustumAlterViewMode)preferredStyle;


- (void)showCancle:(void(^)())cancleBlock accept:(void(^)())confirmBlock;

@end
