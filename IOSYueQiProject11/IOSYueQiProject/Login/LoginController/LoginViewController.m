//
//  LoginViewController.m
//  Smart
//
//  Created by 敲代码mac1号 on 16/6/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrOrForgetFirstViewController.h"


#import<CommonCrypto/CommonDigest.h>
#import "MainTabBarViewController.h"
#import "JPUSHService.h"

#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (nonatomic , strong) MBProgressHUD *hud;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.userNameTF.delegate = self;
    
    self.passwordTF.delegate = self;
    
    self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign)];
    
    [self.view addGestureRecognizer:resign];

}


- (void)resign {
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)loginAction:(UIButton *)sender {
    sender.enabled = NO;
    if (self.userNameTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号码" toView:nil];
        sender.enabled = YES;
        return;
    }
    if (self.userNameTF.text.length != 11 || ![self.userNameTF.text hasPrefix:@"1"]) {
        [MBProgressHUD showError:@"手机号码格式错误" toView:nil];
        sender.enabled = YES;

        return;
    }

    
    if (self.passwordTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:nil];
        sender.enabled = YES;
        return;
    }
    
    
    if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 20 || [HelpManager IsChinese:self.passwordTF.text] || [HelpManager isHaveIllegalChar:self.passwordTF.text] ) {
        [MBProgressHUD showError:@"密码格式有误" toView:nil];
        sender.enabled = YES;

        return;
    }
    
    self.hud = [MBProgressHUD showMessag:@"正在登录" toView:nil];
    NSDictionary *pram = @{ @"login_name": self.userNameTF.text,
                            @"password": [self md5HexDigest:self.passwordTF.text]};
    [NewWorkingRequestManage requestNoHeadePostWith:MyLogin parDic:pram finish:^(id responseObject) {
        MyLog(@"%@", responseObject);
        
        
        sender.enabled = YES;
        [self.hud hide:YES afterDelay:0];
        NSString *userID = responseObject[@"user_id"];
        [userDef setObject:userID forKey:@"userID"];
        [userDef setObject:self.userNameTF.text forKey:@"userName"];
        [userDef setObject:[self md5HexDigest:self.passwordTF.text] forKey:@"password"];
        [userDef setObject:responseObject[@"mac_key"] forKey:@"Mackey"];
        [userDef setObject:responseObject[@"access_token"] forKey:@"token"];
        [userDef setObject:responseObject[@"expires_at"] forKey:@"expires_at"];
        NSLog(@"登录获取的token%@", responseObject[@"access_token"]);
        [JPUSHService setTags:[NSSet set]alias:userID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
            MyLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
        }];
        
        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
        if (!isAutoLogin) {
            EMError *error = [[EMClient sharedClient] loginWithUsername:self.userNameTF.text password:[self md5HexDigest:self.passwordTF.text]];
            if (!error) {
                NSLog(@"登录成功®");
            } else {
                NSLog(@"登录失败®");
            }
        }

        NSString *str = [NSString stringWithFormat:@"%@/%@", GetUserInfor, userID];
        [NewWorkingRequestManage requestGetWith:str parDic:nil finish:^(id responseObject) {
            NSLog(@"%@", responseObject);
            [userDef setObject:responseObject[@"nick_name"] forKey:@"nickname"];
            [userDef setObject:responseObject[@"portrait"] forKey:@"usericon"];
            [userDef setObject:responseObject[@"phone"] forKey:@"userName"];
           
            
        } error:^(NSError *error) {
            
        }];

        
        MainTabBarViewController *mainTVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
        [self presentViewController:mainTVC animated:YES completion:nil];

    } error:^(NSError *error) {
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        sender.enabled = YES;
    }];
}

- (IBAction)registerAction:(UIButton *)sender {
    MyLog(@"%@", sender.currentTitle);
    
    
    RegistrOrForgetFirstViewController *reForFirstVC = [[RegistrOrForgetFirstViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:reForFirstVC];
    reForFirstVC.str = @"注册";

    [self presentViewController:navc animated:YES completion:nil];
}

- (IBAction)forgetAction:(UIButton *)sender {
    MyLog(@"%@", sender.currentTitle);
    RegistrOrForgetFirstViewController *reForFirstVC = [[RegistrOrForgetFirstViewController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:reForFirstVC];

    reForFirstVC.str = @"忘记密码";

    [self presentViewController:navc animated:YES completion:nil];

}

//MD5加密算法
- (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

#pragma mark - 键盘处理
///键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘高度
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算偏移量
    //取得键盘的动画时间
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if (kbHeight > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0, -45, TheW, TheH);
            [self.view layoutIfNeeded];
        }];
    }
}

///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notification
{
    //键盘动画时间
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, TheW, TheH);
        [self.view layoutIfNeeded];
    }];
}


#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
