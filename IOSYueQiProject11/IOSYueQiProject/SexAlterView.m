//
//  SexAlterView.m
//  GxHappyApp
//
//  Created by 敲代码mac2号 on 16/7/13.
//  Copyright © 2016年 chengleiGG. All rights reserved.
//

#import "SexAlterView.h"
#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height
@implementation SexAlterView
+ (SexAlterView *)creatSexAlterView{
    SexAlterView *sexAV = [[[NSBundle mainBundle] loadNibNamed:@"SexAlterView" owner:nil options:nil] firstObject];
    sexAV.backgroundColor = [UIColor clearColor];
    sexAV.frame = CGRectMake(0, 0, TheW, TheH);
//    [sexAV.cancelBtn setTitleColor:Color(193, 193, 193) forState:UIControlStateNormal];
//    
//    [sexAV.confirmBtn setTitleColor:Color(47,115,33) forState:UIControlStateNormal];
  
    

    sexAV.sex = 0;
//    sexAV.locationArray = @[@"男", @"女"];
    sexAV.sexPikeView.delegate = sexAV;
    sexAV.sexPikeView.dataSource = sexAV;
    return sexAV;
    
}

- (NSArray *)locationArray {
    if (!_locationArray) {
        self.locationArray = [NSArray array];
    }
    return _locationArray;
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.sex);
        [self removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}


- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(NSInteger ))confirmBlock {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.cancleBlock = cancleBlock;
    self.confirmBlock = confirmBlock;
}


#pragma mark -UIPickerViewDelegate
//返回指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return self.frame.size.width;
}

//返回指定行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return 30.0f;
}


//自定义行的视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30.0f)];
    label.textAlignment = NSTextAlignmentCenter;
        label.text = [self.locationArray objectAtIndex:row];
        [view addSubview:label];
    return view;
}

//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
//    NSString *location = self.locationArray[row];
//    if ([location isEqualToString:self.locationArray[self.sex]]) {
//        self.sex = 1;
//    } else {
//        self.sex = 0;
//    }
    self.sex = row;
    NSLog(@"%ld", self.sex);
}





#pragma mark -UIPickerViewDataSource

// UIPickerView有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


// UIPickerView指定行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
        return self.locationArray.count;
    
}



@end
