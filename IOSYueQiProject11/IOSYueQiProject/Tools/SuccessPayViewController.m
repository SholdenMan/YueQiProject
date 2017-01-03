//
//  SuccessPayViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SuccessPayViewController.h"
#import "MyOrderViewController.h"
#import "YueQiViewController.h"

@interface SuccessPayViewController ()

@end

@implementation SuccessPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // Do any additional setup after loading the view.
}


- (IBAction)checkOrderAction:(UIButton *)sender {
    MyOrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.title = @"我的订单";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)back{
    YueQiViewController *yueqiVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"yueqi"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:yueqiVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
