//
//  BaseViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : Color(51, 51, 51)}];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    self.navigationController.navigationBar.translucent = NO;
    [self childViewControllerForStatusBarStyle];

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
