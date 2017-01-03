//
//  BoxRenewalVC.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/15.
//  Copyright © 2016年  敲代码mac1号. All rights reserved.
//  包厢续费

#import "BoxRenewalVC.h"
#import "RenewalModel.h"
#import "PayViewController.h"


@interface BoxRenewalVC () {

    NSInteger allCount;

}
//支付类型
@property (weak, nonatomic) IBOutlet UILabel *payType;

//合计
@property (weak, nonatomic) IBOutlet UILabel *allPrice;

//需付
@property (weak, nonatomic) IBOutlet UILabel *allPay;

//续费时长
@property (weak, nonatomic) IBOutlet UILabel *payTime;

//续费价格
@property (weak, nonatomic) IBOutlet UILabel *xufeiPrice;

@property (nonatomic , strong) RenewalModel *model;

@end

@implementation BoxRenewalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    allCount = 1;
    self.payTime.text = [NSString stringWithFormat:@"%ld", allCount];
    
    
    self.model = [[RenewalModel alloc] init];

    [self creatData];
}

- (void)creatData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/renewal", getBoxRenewalInfor, self.game_id];
    
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSDictionary *dic = responseObject;
        [self.model setValuesForKeysWithDictionary:dic];
        
        self.xufeiPrice.text = [NSString stringWithFormat:@"¥%@/每小时", self.model.price];
        self.payType.text = [NSString stringWithFormat:@"%@", self.model.pay_type_text];
        self.allPrice.text = [NSString stringWithFormat:@"¥%@", self.model.price];
        self.allPay.text = [NSString stringWithFormat:@"%@", self.model.price];

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } error:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [MBProgressHUD showError: [NewWorkingRequestManage newWork].errorStr toView:self.view];

    }];
    
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//支付
- (IBAction)payAction:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/renewal", getBoxRenewalInfor, self.game_id];
    
    [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
        PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
        payVC.order_no =  [NSString stringWithFormat:@"%@", responseObject[@"order_no"]];
        [self presentViewController:nav animated:YES completion:nil];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } error:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError: [NewWorkingRequestManage newWork].errorStr toView:self.view];
    }];

}

//类型
- (IBAction)payType:(UIButton *)sender {
//    NSMutableArray *arr = @[@{@"content":@"AA制",@"color":[UIColor blackColor]}, @{@"content":@"我请客", @"color":[UIColor blackColor]}].mutableCopy;
//    
//    SheetAlertView *sheetV = [SheetAlertView sheetAlertViewWith:arr];
//    [sheetV setSheetblock:^(NSInteger inter) {
//        NSLog(@"%ld",inter);
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//        
//        NSDictionary *dic = arr[inter];
//        self.payType.text = [NSString stringWithFormat:@"%@", dic[@"content"]];
//        [sheetV removeFromSuperview];
//    }];
//    [[UIApplication sharedApplication].keyWindow addSubview:sheetV];

    
}

//增
- (IBAction)addAction:(UIButton *)sender {
    allCount += 1;
    self.payTime.text = [NSString stringWithFormat:@"%ld", allCount];
    
    self.allPrice.text = [NSString stringWithFormat:@"¥%.lf", allCount * [self.model.price floatValue]];
    self.allPay.text = [NSString stringWithFormat:@"%.lf", allCount * [self.model.price floatValue]];
}

//减
- (IBAction)reduceAction:(UIButton *)sender {
    allCount -= 1;
    if (allCount < 1) {
        allCount = 1;
    }
    self.payTime.text = [NSString stringWithFormat:@"%ld", allCount];
    self.allPrice.text = [NSString stringWithFormat:@"¥%.lf", allCount * [self.model.price floatValue]];
    self.allPay.text = [NSString stringWithFormat:@"%.lf", allCount * [self.model.price floatValue]];
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
