//
//  SponsorViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/27.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SponsorViewController.h"
#import "SponsorTableViewCell.h"
#import "SuccessCreateViewController.h"
#import "ListTeaViewController.h"
#import "LaunchModel.h"
#import "MainTabBarViewController.h"

@interface SponsorViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong)SponsorTableViewCell *cell;
@property (nonatomic, strong)LaunchModel *model;
@property (nonatomic, strong)NSString *timeStr;
@property (nonatomic, assign)NSTimeInterval time;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UITextField *tex;

@end

@implementation SponsorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];

    [self creatData];
    // Do any additional setup after loading the view.
}
- (void)creatData{
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.model = [[LaunchModel alloc] init];
    self.model.pay_type = @"AA制";
    self.model.subject = @"";
    self.model.begin_time = @"";
    self.model.store = @"";
    self.model.hours = @"";
}
- (void)back{
//    [self dismissViewControllerAnimated:YES completion:nil];
    MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
    [self presentViewController:successVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- tableview代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;

        case 2:
            return 1;
            break;

        default:
            return 0;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SponsorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
      cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果        
    if (indexPath.section == 0) {
        cell.titleTF.delegate = self;
        cell.textLabel.hidden  = YES;
        cell.contentLabel.hidden = YES;
        cell.titleTF.placeholder = @"约局标题";
        cell.titleTF.returnKeyType = UIReturnKeyDone;
        cell.titleTF.text = self.model.subject;
        
        self.tex = cell.titleTF;
        [cell setCancleBlock:^(UIButton *sender) {
            cell.titleTF.text = @"";
            
        }];
        
    }else if(indexPath.section == 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.titleTF.hidden = YES;
        cell.stateBtn.hidden = YES;
        cell.contentLabel.hidden = NO;

        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"开始时间";
                cell.contentLabel.text = self.model.begin_time;
                break;
            case 1:
                cell.titleLabel.text = @"计划时常";
                cell.contentLabel.text = self.model.hours;
                break;
            case 2:
                cell.titleLabel.text = @"暂定茶馆";
                cell.contentLabel.text = self.model.store;
                break;
            default:
                break;
        }
    }else if(indexPath.section == 2){
        cell.contentLabel.hidden = NO;
        cell.titleTF.hidden = YES;
        cell.titleLabel.text = @"包厢付费";
        cell.contentLabel.text = self.model.pay_type;
        cell.stateBtn.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section !=0) {
        
        [self.tex resignFirstResponder];
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                NSLog(@"选择开始时间111");
                ChangeDateView *changeView = [ChangeDateView changeDateView];
                changeView.birthdayPicker.datePickerMode = UIDatePickerModeDateAndTime;
                [[UIApplication sharedApplication].keyWindow addSubview:changeView];
                [changeView setFinishBlock:^{
                     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"YY年MM月dd日HH时mm分ss秒"];
                     NSString *timeStr = [dateFormatter stringFromDate:changeView.birthdayPicker.date];
                    NSDate *dateMax = [dateFormatter dateFromString:timeStr];
                    self.time = [dateMax timeIntervalSince1970];
                    NSString *newTime =  [HelpManager getCurrentTimestamp];
                    if (newTime.integerValue > self.time) {
                        [MBProgressHUD showError:@"无法选择过去时间" toView:nil];
                        return ;
                    }
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                    NSDateFormatter *newData = [[NSDateFormatter alloc] init];
                     [newData setDateFormat:@"MM月dd日HH时mm分"];
                    self.model.begin_time = [newData stringFromDate:changeView.birthdayPicker.date];
//                    self.time = [changeView.birthdayPicker.date timeIntervalSince1970];
//                    [self.myTableView reloa];
                    NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:0 inSection:1];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
                    
                }];
            }
                break;
            case 1:
            {
                SexAlterView *sexAV = [SexAlterView creatSexAlterView];
                sexAV.titleLabel.text = @"计划时常";
                sexAV.locationArray = @[@"3小时", @"4小时"];
                [sexAV showCancle:nil confirm:^(NSInteger sex) {
                    NSLog(@"%ld", sex);
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                   self.model.hours = sexAV.locationArray[sex];
                    NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:1 inSection:1];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];                }];

            }
                break;
            case 2:
            {
                ListTeaViewController *listVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"list"];
                [listVC setModelBlock:^(TeaListModel *model) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                    self.model.teaID = model.teaID;
                   self.model.store = model.address;
                    NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:2 inSection:1];
                    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
                listVC.title = @"选择茶馆";
                [self presentViewController:nav animated:YES completion:nil];
                
            }
                break;
                
            default:
                break;
        }
    }else if(indexPath.section == 2){
        NSLog(@"包厢付费");
        NSMutableArray *arr = @[@{@"content":@"AA制",@"color":[UIColor blackColor]}, @{@"content":@"我请客", @"color":[UIColor blackColor]}].mutableCopy;
        
        SheetAlertView *sheetV = [SheetAlertView sheetAlertViewWith:arr];
        [sheetV setSheetblock:^(NSInteger inter) {
            NSLog(@"%ld",inter);
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            
            self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
            self.model.pay_type= arr[inter][@"content"];
            NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:0 inSection:2];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPaths,nil] withRowAnimation:UITableViewRowAnimationNone];
            [sheetV removeFromSuperview];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:sheetV];
    }
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)dateAction{
    
}
- (IBAction)creatAction:(UIButton *)sender {
    if (self.model.begin_time.length == 0 || self.model.hours .length == 0 || self.model.store .length == 0) {
        [MBProgressHUD showError:@"请填写完整信息" toView:nil];
    }else{
        NSString *choosePay;
        if ([self.model.pay_type isEqualToString:@"AA制"]) {
            choosePay = @"0";
        }else{
            choosePay = @"1";
        }
        NSString *timeStr = [NSString stringWithFormat:@"%.0lf", self.time * 1000];
        NSDictionary *dicID = @{@"id":self.model.teaID};
        NSString *hour;
        if ([self.model.hours isEqualToString:@"3小时"]) {
            hour = @"3";
        }else if([self.model.hours isEqualToString:@"4小时"]){
            hour = @"4";
        }else{
            hour = @"5";
        }
        NSDictionary *dic = @{@"hours":hour, @"subject":self.tex.text, @"begin_time":timeStr, @"pay_type":choosePay, @"store":dicID, @"visibility":@0};
        NSLog(@"%@", dic);
        self.hud = [MBProgressHUD showMessag:@"正在创建" toView:nil];
        [NewWorkingRequestManage requestPostWith:CreatTeaUrl parDic:dic finish:^(id responseObject) {
            [self.hud hide:YES afterDelay:0];
            NSLog(@"-----%@", responseObject);
            
            [self.model setValuesForKeysWithDictionary:responseObject];
            SuccessCreateViewController *successVC = [[SuccessCreateViewController alloc] init];
            successVC.model = self.model;
            NSLog(@"%@", self.model.teaID);
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
            successVC.title = @"创建完成";
            [self presentViewController:nav animated:YES completion:nil];
        } error:^(NSError *error) {
            [self.hud hide:YES afterDelay:0];

            NSLog(@"错误信息%@",[NewWorkingRequestManage newWork].errorStr);
        }];
    }
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.myTableView.userInteractionEnabled = YES;
    if (textField.text.length > 10) {
        [MBProgressHUD showError:@"标题限定是个字符" toView:nil];
        textField.text = @"";
        return  YES;
    }else{
        [textField resignFirstResponder];
        
        return YES;
    }
    self.model.subject = textField.text;

   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
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
