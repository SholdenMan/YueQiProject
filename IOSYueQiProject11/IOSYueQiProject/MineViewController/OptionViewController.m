//
//  OptionViewController.m
//  Modo
//
//  Created by 程磊 on 16/9/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.title isEqualToString:@"签名"]) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baocun)];
        self.textLabel.text = @"最多可输入50个字";
        self.navigationItem.rightBarButtonItem = right;
        self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    }else{
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiao)];
        self.textLabel.text = @"最多可输入300个字";
        self.navigationItem.rightBarButtonItem = right;
        self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    }
       UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    
}

- (void)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tijiao{
    if (self.myTextView.text.length <=300 && self.myTextView.text.length > 0) {
        [MBProgressHUD showMessage:@"提交成功" toView:nil];
        self.myTextView.text = @"感谢您的建议, 我们会认真对待";
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [MBProgressHUD showError:@"反馈意见不能为空" toView:nil];
    }
    
}
- (void)baocun{
    if (self.myTextView.text.length <=50) {
        self.signBlock(self.myTextView.text);
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        [MBProgressHUD showError:@"最多50个字" toView:nil];

    }
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
