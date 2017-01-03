//
//  ChangeInfoViewController.m
//  com.ahxmould.ring
//
//  Created by 敲代码mac1号 on 16/7/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChangeInfoViewController.h"
#import "PasswordView.h"
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height
@interface ChangeInfoViewController () <UITextFieldDelegate>
@property (nonatomic, strong)PasswordView *currentpassView;
@property (nonatomic, strong)PasswordView *newpassView;
@property (nonatomic, strong) UITextField *oldPass;
@property (nonatomic , strong) UITextField *passWord;
@property (nonatomic , strong) UITextField *nameTF;
@property (nonatomic, strong) MBProgressHUD *hud;


@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc] initWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    if ([self.title isEqualToString:@"昵称"]) {
        [self changeName];
    } else if([self.title isEqualToString:@"修改密码"]) {
        [self changePassword];
    }else if([self.title isEqualToString:@"职业"]){
        [self changejob];
    }
}

- (void)changejob{
    self.nameTF = [[UITextField alloc] initWithFrame:(CGRectMake(17, 12, TheW - 34, 41))];
    self.nameTF.placeholder = @"职位";
    self.nameTF.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTF.returnKeyType = UIReturnKeyDone;
    self.nameTF.delegate = self;
    [self.view addSubview:self.nameTF];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(changejobBlock)];

}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changePassword {
   
    self.view.backgroundColor  = [UIColor whiteColor];
    self.oldPass = [[UITextField alloc] initWithFrame:CGRectMake(17, 12, TheW - 17*2, 40)];
    self.oldPass.placeholder = @"请输入旧密码";
    self.oldPass.borderStyle = UITextBorderStyleNone;
    self.oldPass.delegate = self;
    [self.view addSubview:self.oldPass];
    
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 56, TheW - 30, 2)];
    firstLabel.backgroundColor = [[UIColor alloc] initWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    firstLabel.text = @"";
    [self.view addSubview:firstLabel];
    
    self.passWord = [[UITextField alloc] initWithFrame:CGRectMake(17, 64, TheW - 17*2, 40)];
    self.passWord.placeholder = @"请输入新密码";
    self.passWord.borderStyle = UITextBorderStyleNone;
    self.passWord.delegate = self;
    [self.view addSubview:self.passWord];
    self.oldPass.secureTextEntry = YES;
    self.passWord.secureTextEntry = YES;
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 108, TheW - 30, 2)];
    secondLabel.backgroundColor = [[UIColor alloc] initWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    secondLabel.text = @"";
    [self.view addSubview:secondLabel];

    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    finishBtn.frame = CGRectMake(37, 125, TheW - 37*2 , 46);
    [finishBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [finishBtn setTintColor:[UIColor whiteColor]];
    [finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    finishBtn.layer.masksToBounds = YES;
    finishBtn.layer.cornerRadius = 5;
    [finishBtn setBackgroundImage:[UIImage imageNamed:@"bg-mineyyy"] forState:UIControlStateNormal];
    [self.view addSubview:finishBtn];
}

- (void)finish:(UIButton *)sender {
   
    if (self.passWord.text.length < 6 || self.passWord.text.length > 12 || [HelpManager IsChinese:self.passWord.text]||[HelpManager isHaveIllegalChar:self.passWord.text] || self.oldPass.text.length < 6 || self.oldPass.text.length > 12 || [HelpManager IsChinese:self.oldPass.text]||[HelpManager isHaveIllegalChar:self.oldPass.text]) {
        [MBProgressHUD showError:@"密码格式错误" toView:nil];
        return;
    }
    self.hud = [MBProgressHUD showMessag:@"正在修改" toView:nil];
    NSDictionary *pram = @{@"new_password": [HelpManager md5HexDigest:self.passWord.text],
                           @"password": [HelpManager md5HexDigest:self.oldPass.text]};
    [NewWorkingRequestManage requestPUTWith:ChangePassword parDic:pram finish:^(id responseObject) {
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showSuccess:@"修改成功" toView:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NSError *error) {
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
    

}


- (void)changeName {
    self.nameTF = [[UITextField alloc] initWithFrame:(CGRectMake(17, 12, TheW - 34, 41))];
    self.nameTF.placeholder = @"昵称";
    self.nameTF.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTF.returnKeyType = UIReturnKeyDone;
    self.nameTF.delegate = self;
    [self.view addSubview:self.nameTF];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
}

- (void)save{
        if (self.nameTF.text.length > 10 || self.nameTF.text.length < 1) {
            [MBProgressHUD showError:@"限定字数10个字" toView:nil];
        }else{
            self.changeBlock(self.nameTF.text);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
}
- (void)changejobBlock{
    if (self.nameTF.text.length > 10 || self.nameTF.text.length < 1) {
        [MBProgressHUD showError:@"限定字数10个字" toView:nil];
    }else{
        self.changeJop(self.nameTF.text);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if ([textField isEqual:self.nameTF]) {
//        if (self.nameTF.text.length > 6) {
//            [MBProgressHUD showError:@"昵称不能超过6字符" toView:nil];
//            return YES;
//        }
//        [self changeUserinfo:@{@"nick_name":self.nameTF.text}];
//    }
    [textField resignFirstResponder];
    return YES;
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
