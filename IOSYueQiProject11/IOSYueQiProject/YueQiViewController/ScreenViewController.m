//
//  ScreenViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ScreenViewController.h"
#import "TypeTableViewCell.h"
#import "typeModel.h"
#import "NumberModel.h"

@interface ScreenViewController ()
//@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) typeModel *model;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)NSTimeInterval time;
/**
 *  判断按钮是否为选中状态
 */
@property(nonatomic,assign) BOOL IsSelectedButton;
/**
 *  用来记录被选中的按钮
 */
@property(nonatomic,strong)UIButton *selectedButton;
/**
 *  用来记录上一次点击的按钮
 */
@property(nonatomic,strong)UIButton *clickButton;

@end

@implementation ScreenViewController


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    typeModel *model = [[typeModel alloc] init];
    model.sex = @"不限";
    model.pay = @"不限";
    model.time = @"不限";
    model.selecd = @"全部";
    [self.dataSource addObject:model];
    
    
    self.myTableView.sectionFooterHeight = 3;
    self.myTableView.sectionHeaderHeight = 3;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(choosDownAction)];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    
    UIImage *backImage = [HelpManager createImageWithColor:Color(255, 255, 255)];
    UIImage *seleBackImage = [HelpManager createImageWithColor:Color(26, 161, 163)];
    
    [self.myButton setTitleColor:Color(255, 255, 255) forState:UIControlStateSelected];
    [self.myButton setTitleColor:Color(26, 161, 163) forState:UIControlStateNormal];
    self.myButton.layer.masksToBounds = YES;//设置可描边
    self.myButton.layer.cornerRadius = 5;//设置圆角
    [self.myButton.layer setBorderWidth:1];//设置描边宽度
    self.myButton.layer.borderColor = Color(26, 161, 163).CGColor;
    [self.myButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [self.myButton setBackgroundImage:seleBackImage forState:UIControlStateSelected];
    
    [self.allBtn setTitleColor:Color(255, 255, 255) forState:UIControlStateSelected];
    [self.allBtn setTitleColor:Color(26, 161, 163) forState:UIControlStateNormal];
    self.allBtn.layer.masksToBounds = YES;//设置可描边
    self.allBtn.layer.cornerRadius = 5;//设置圆角
    [self.allBtn.layer setBorderWidth:1];//设置描边宽度
    self.allBtn.layer.borderColor = Color(26, 161, 163).CGColor;
    [self.allBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [self.allBtn setBackgroundImage:seleBackImage forState:UIControlStateSelected];
    self.allBtn.selected = YES;
    self.selectedButton = self.allBtn;
    [self.threeBtn setTitleColor:Color(255, 255, 255) forState:UIControlStateSelected];
    [self.threeBtn setTitleColor:Color(26, 161, 163) forState:UIControlStateNormal];
    self.threeBtn.layer.masksToBounds = YES;//设置可描边
    self.threeBtn.layer.cornerRadius = 5;//设置圆角
    [self.threeBtn.layer setBorderWidth:1];//设置描边宽度
    self.threeBtn.layer.borderColor = Color(26, 161, 163).CGColor;
    [self.threeBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [self.threeBtn setBackgroundImage:seleBackImage forState:UIControlStateSelected];

    [self.twoBtn setTitleColor:Color(255, 255, 255) forState:UIControlStateSelected];
    [self.twoBtn setTitleColor:Color(26, 161, 163) forState:UIControlStateNormal];
    self.twoBtn.layer.masksToBounds = YES;//设置可描边
    self.twoBtn.layer.cornerRadius = 5;//设置圆角
    [self.twoBtn.layer setBorderWidth:1];//设置描边宽度
    self.twoBtn.layer.borderColor = Color(26, 161, 163).CGColor;
    [self.twoBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [self.twoBtn setBackgroundImage:seleBackImage forState:UIControlStateSelected];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)choosDownAction{
    NSString *time = [[NSString alloc] init];
    NSString *number  = [[NSString alloc] init];
    NSString *sex = [[NSString alloc] init];
    NSString *pay = [[NSString alloc] init];
    typeModel *model = [[typeModel alloc] init];
    model = self.dataSource.firstObject;
    //性别
    if ([model.sex isEqualToString:@"男生居多"]) {
        sex = @"1";
    }else if([model.sex isEqualToString:@"女生居多"]){
        sex = @"0";
    }else{
        sex = @"";
    }
    //人数
    if ([model.selecd isEqualToString:@"全部"]) {
        number = @"";
    }else if([model.selecd isEqualToString:@"三缺一"]){
        number = @"3";
    }else if([model.selecd isEqualToString:@"二缺二"]){
        number = @"2";
    }else{
        number = @"1";
    }
    //付款方式
    if ([model.pay isEqualToString:@"AA制"]) {
        pay = @"0";
    }else if([model.pay isEqualToString:@"房主请客"]){
        pay = @"1";
    }else{
        pay = @"";
    }
    //开始时间
    if ([model.time isEqualToString:@"不限"]) {
        time = @"";
    }else{
        time  = [NSString stringWithFormat:@"%.0lf", self.time * 1000];
    }
    NSString *newStr = [NSString stringWithFormat:@"gender=%@&pay_type=%@&begin_time=%@&member_count=%@", sex, pay,time,number];
    self.myBlock(newStr);
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    typeModel *model = self.dataSource.firstObject;
    switch (indexPath.row) {
        case 0:
        {
          cell.titleLabel.text = @"开始时间";
            cell.chooseLabel.text =  model.time;
            cell.contentLabel.text = @"筛选开始时间前后30分钟的约局";
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"局友性别";
            cell.chooseLabel.text = model.sex;
            cell.contentLabel.text = @"如果不选默认是无限制";


        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"付款方式";
            cell.chooseLabel.text = model.pay;
            NSLog(@"%@", self.model.pay);
            cell.contentLabel.text = @"如果不选默认是无限制";


        }
            break;
        default:
            break;
    }
    return cell;
}


- (IBAction)chooseBtn:(UIButton *)sender {
    if (self.clickButton != sender) {
        //        [self setUpNotTimeLimitViewUp];
        //        [self.corverView removeFromSuperview];
    }
    if (sender.selected == NO) {
        sender.selected = YES;
        //        [self setUpNotTimeLimitViewDown];
        [self changeClickButton:sender];
    }else if(sender.isSelected == YES){
        sender.selected = NO;
        //        [self setUpNotTimeLimitViewUp];
    }
    self.clickButton = sender;
    typeModel *model = [[typeModel alloc] init];
    model = self.dataSource.firstObject;
    model.selecd = self.selectedButton.titleLabel.text;
    NSLog(@"被选中的是%@", self.selectedButton.titleLabel.text)
    ;
}



-(void)changeClickButton:(UIButton *)sender{
    self.selectedButton.selected = NO;
    self.selectedButton = sender;
    sender.selected = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    typeModel *model = self.dataSource.firstObject;

        switch (indexPath.row) {
            case 0:{
                NSLog(@"选择开始时间");
                ChangeDateView *changeView = [ChangeDateView changeDateView];
                changeView.birthdayPicker.datePickerMode = UIDatePickerModeDateAndTime;
                [[UIApplication sharedApplication].keyWindow addSubview:changeView];
                [changeView setFinishBlock:^{
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"YY年MM月dd日HH时mm分ss秒"];
                    NSDateFormatter *newData = [[NSDateFormatter alloc] init];
                    [newData setDateFormat:@"MM月dd日HH时mm分"];
                    
                    model.time = [newData stringFromDate:changeView.birthdayPicker.date];
                    NSString *timeStr = [dateFormatter stringFromDate:changeView.birthdayPicker.date];
                    NSDate *dateMax = [dateFormatter dateFromString:timeStr];
                    self.time = [dateMax timeIntervalSince1970];
//                    self.time = [changeView.birthdayPicker.date timeIntervalSince1970];
                    [self.myTableView reloadData];
                }];
            }
                break;
            case 1:
            {
                NSMutableArray *arr = @[@{@"content":@"不限",@"color":[UIColor blackColor]},@{@"content":@"男生居多",@"color":[UIColor blackColor]}, @{@"content":@"女生居多", @"color":[UIColor blackColor]}].mutableCopy;
                
                SheetAlertView *sheetV = [SheetAlertView sheetAlertViewWith:arr];
                [sheetV setSheetblock:^(NSInteger inter) {
                    NSLog(@"%ld",inter);
                    //                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
                    
                    //                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                    model.sex = arr[inter][@"content"];
                    [self.myTableView reloadData];
                    [sheetV removeFromSuperview];
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:sheetV];

            }
                break;
            case 2:
            {
                NSMutableArray *arr = @[@{@"content":@"不限",@"color":[UIColor blackColor]},@{@"content":@"AA制",@"color":[UIColor blackColor]}, @{@"content":@"房主请客", @"color":[UIColor blackColor]}].mutableCopy;
                
                SheetAlertView *sheetV = [SheetAlertView sheetAlertViewWith:arr];
                [sheetV setSheetblock:^(NSInteger inter) {
                    NSLog(@"%ld",inter);
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
                    
//                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                    model.pay= arr[inter][@"content"];
                    [self.myTableView reloadData];
                    [sheetV removeFromSuperview];
                }];
                [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
            }
                break;
            default:
                break;
        }
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
