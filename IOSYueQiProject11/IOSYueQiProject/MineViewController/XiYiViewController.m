//
//  XiYiViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/18.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "XiYiViewController.h"

@interface XiYiViewController ()

@end

@implementation XiYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://17178.xmappservice.com/static/common/protocol.html"]]];
    // Do any additional setup after loading the view.
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
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
