//
//  SexAlterView.h
//  GxHappyApp
//
//  Created by 敲代码mac2号 on 16/7/13.
//  Copyright © 2016年 chengleiGG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexAlterView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) void(^confirmBlock)(NSInteger );
@property (nonatomic, copy) void(^cancleBlock)(NSInteger );
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *sexPikeView;
@property (nonatomic, assign)NSInteger sex;

@property (nonatomic , strong) NSArray *locationArray;


+ (SexAlterView *)creatSexAlterView;
- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(NSInteger ))confirmBlock;
@end
