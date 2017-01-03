//
//  PasswordView.h
//  Verification
//
//  Created by 敲代码mac2号 on 16/6/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFile;
@property (weak, nonatomic) IBOutlet UIButton *closeButon;
@property (weak, nonatomic) IBOutlet UIButton *emptyButton;

+ (PasswordView *)passWordViewInitWith:(CGRect )fram;

@end
