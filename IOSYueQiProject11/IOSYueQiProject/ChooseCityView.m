//
//  ChooseCityView.m
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChooseCityView.h"


#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

@interface ChooseCityView ()

@end

@implementation ChooseCityView

- (HZLocation *)locate {
    if (!_locate) {
        self.locate = [[HZLocation alloc] init];
    }
    return _locate;
}

+ (ChooseCityView *)creatChooseCityView {
    ChooseCityView *cityView = [[[NSBundle mainBundle] loadNibNamed:@"ChooseCityView" owner:nil options:nil] firstObject];
    cityView.backgroundColor = [UIColor clearColor];
    cityView.frame = CGRectMake(0, 0, TheW, TheH);


    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    NSDictionary *provinceLise = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    cityView.pickerdic = provinceLise;
    cityView.pickerAry = [NSArray array];
    cityView.pickerAry = cityView.pickerdic[@"citylist"];
    
    [cityView getAreaDate:0];
    [cityView getCitydate:0];// 默认显示数据
    cityView.cityPikeView.delegate = cityView;
    cityView.cityPikeView.dataSource = cityView;
    return cityView;
    
}



//取到市
- (void)getCitydate:(NSInteger)row{
    
    NSMutableArray *cityList = [[NSMutableArray alloc] init];
    for (NSArray *cityArr in self.pickerAry[row][@"c"]) {
        [cityList addObject:cityArr];
    }
    self.cityList = cityList;
}

- (NSString *)returnDataArray:(NSInteger)componet row:(NSInteger)row{
    
    
    switch (componet) {
        case 0:
            return self.pickerAry[row][@"p"];
            break;
        case 1:
            return self.cityList[row][@"n"];
            break;
        case 2:
            return self.areaList[row][@"s"];
            break;
        default:
            return @"";
            break;
    }
    
    
}

- (void)getAreaDate:(NSInteger)row{
    
    NSArray *ary;
    NSMutableArray *areaList = [[NSMutableArray alloc] init];
    //有特区或者直辖市没有第三级  把存放三级数据的数组置空或者删除
    if (self.cityList[row][@"a"] == nil) {
        
    }else{
        ary = self.cityList[row][@"a"];
    }
    if (ary.count == 0) {
        self.areaList = nil;
        return;
    }else{
        for (NSArray *cityDict in self.cityList[row][@"a"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    }
    
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.confirmBlock) {
        
        if (self.isSelect) {
            self.confirmBlock(self.locate.country, self.locate.city, self.locate.street);
        } else {
            self.confirmBlock(@"北京", @"东城区", @"");
        }
        [self removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}


- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(NSString *, NSString *, NSString *))confirmBlock {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.cancleBlock = cancleBlock;
    self.confirmBlock = confirmBlock;
}


#pragma mark -UIPickerViewDelegate
//返回指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return self.frame.size.width / 3;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30.0f)];
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = [self returnDataArray:component row:row];
        [view addSubview:label];
    } else if (component == 1){
        label.text = [self returnDataArray:component row:row];
       [view addSubview:label];
    } else {
        label.text = [self returnDataArray:component row:row];
        [view addSubview:label];

    }
    return view;
}


//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
    self.isSelect = YES;
    static NSInteger oneRow = 0;
    static NSInteger tweRow = 0;
    static NSInteger threeRow = 0;
    if (component == 0) {
        self.selectOneRow = row;
        [self getCitydate:row];
        //重新加载 第二列
        [pickerView reloadComponent:1];
        //默认选中第一列中的第一个数据
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [self getAreaDate:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        oneRow = row;
        tweRow = 0;
        threeRow = 0;
    }
    
    if (component == 1){
        
        self.selectTwoRow = row;
        [self getAreaDate:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        tweRow = row;
        threeRow = 0;
    }
    
    if (component == 2){
        
        self.selectThreeRow = row;
        threeRow = row;
    }
    
    NSMutableString *regionAddress1 = [[NSMutableString alloc] init];
    NSMutableString *regionAddress2 = [[NSMutableString alloc] init];

    NSMutableString *regionAddress3 = [[NSMutableString alloc] init];

    if (self.areaList == nil) {//因为有特区和直辖市的存在
        if (oneRow != 0) {
            [regionAddress1 appendFormat:@"%@",self.pickerAry[self.selectOneRow][@"p"]];
        }else{
            [regionAddress1 appendFormat:@"%@",self.pickerAry[0][@"p"]];
        }
        if (tweRow != 0){
            
            [regionAddress2 appendFormat:@"%@",self.cityList[self.selectTwoRow][@"n"]];
        }else{
            [regionAddress2 appendFormat:@"%@",self.cityList[0][@"n"]];
        }
    }else{
        if (oneRow != 0) {
            [regionAddress1 appendFormat:@"%@",self.pickerAry[self.selectOneRow][@"p"]];
        }else{
            [regionAddress1 appendFormat:@"%@",self.pickerAry[0][@"p"]];
        }
        if (tweRow != 0){
            
            [regionAddress2 appendFormat:@"%@",self.cityList[self.selectTwoRow][@"n"]];
        }else{
            [regionAddress2 appendFormat:@"%@",self.cityList[0][@"n"]];
        }
        if (threeRow != 0){
            [regionAddress3 appendFormat:@"%@",self.areaList[self.selectThreeRow][@"s"]];
        }else{
            [regionAddress3 appendFormat:@"%@",self.areaList[0][@"s"]];
        }
    }
    

    self.locate.country = regionAddress1;
    self.locate.city = regionAddress2;
    self.locate.street = regionAddress3;
}





#pragma mark -UIPickerViewDataSource

// UIPickerView有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}


// UIPickerView指定行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.pickerAry.count;
    }else if (component == 1){
        return self.cityList.count;
    }else{
        return self.areaList.count;
    }
    return 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
