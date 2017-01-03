//
//  ChooseCityView.h
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

@interface ChooseCityView : UIView  <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) void(^confirmBlock)(NSString *, NSString *, NSString *);
@property (nonatomic, copy) void(^cancleBlock)(NSInteger );
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *cityPikeView;

@property (strong, nonatomic) HZLocation *locate;

@property (nonatomic, strong) NSDictionary *pickerdic;

/** 省 **/
@property (nonatomic, strong) NSArray *pickerAry;
/** 市 **/
@property (strong,nonatomic)NSArray *cityList;
/** 区 **/
@property (strong,nonatomic)NSArray *areaList;

/** 第一级选中的下标 **/
@property (assign, nonatomic)NSInteger selectOneRow;
/** 第二级选中的下标 **/
@property (assign, nonatomic)NSInteger selectTwoRow;
/** 第三级选中的下标 **/
@property (assign, nonatomic)NSInteger selectThreeRow;

@property (nonatomic , assign) BOOL isSelect;


+ (ChooseCityView *)creatChooseCityView;
- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(NSString *, NSString *, NSString *))confirmBlock;

@end
