//
//  FristViewController.m
//  OurProjectA
//
//  Created by lanouhn on 16/4/8.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "FristViewController.h"
#import "MainTabBarViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface FristViewController ()

@end

@implementation FristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, TheW, TheH)];
    scrollView.contentSize = CGSizeMake(TheW * 3, TheH);
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(TheW * i, 0, TheW, TheH)];
        NSString *name = [NSString stringWithFormat:@"%d", i + 21];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
    }
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(TheW * 2,  TheH *0.8 ,  TheW , TheH - TheH *0.8)];
    [button addTarget:self action:@selector(startlater:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
}

- (void)startlater:(UIButton *)button
{
    LoginViewController *rootController = [[LoginViewController alloc] init];
    [self presentViewController:rootController animated:YES completion:nil];
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
