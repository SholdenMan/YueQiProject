//
//  RegistrOrForgetFirstViewController.m
//  Smart
//
//  Created by 敲代码mac1号 on 16/6/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "RegistrOrForgetFirstViewController.h"

#import "PerfectInformationController.h"
#import "XiYiViewController.h"
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]


@interface RegistrOrForgetFirstViewController () <UITextFieldDelegate>
{
    NSInteger _index;
    BOOL isBool;
}


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;
@property (weak, nonatomic) IBOutlet UILabel *agreementTwoLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UITextField *verificationTF;

@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , copy) NSString *type;

@end

@implementation RegistrOrForgetFirstViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initController];
    [self.userNameTF becomeFirstResponder];
    self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign)];
    [self.view addGestureRecognizer:resign];
    
    if ([self.str isEqualToString:@"注册"]) {
        self.type = @"1";
    } else {
        self.type = @"2";
    }
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
- (void)resign {
    [self.userNameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.verificationTF resignFirstResponder];
}


//获取验证码
- (IBAction)getAction:(UIButton *)sender {
    if (self.userNameTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号码" toView:nil];
        return;
    }
    if (self.userNameTF.text.length != 11 || ![self.userNameTF.text hasPrefix:@"1"]) {
        [MBProgressHUD showError:@"输入的手机号码有误" toView:nil];
        return;
    }
    
    if (self.userNameTF.text.length == 11) {
        NSLog(@"%@", [NSString stringWithFormat:@"%@%@", UserCheak, self.userNameTF.text]);
        [NewWorkingRequestManage requestNoHeadeGetWith:[NSString stringWithFormat:@"%@%@", UserCheak, self.userNameTF.text] parDic:nil finish:^(id responseObject) {
            sender.enabled = YES;
            NSString *str = [NSString stringWithFormat:@"%@", responseObject[@"value"]];
            if ([self.titleLabel.text isEqualToString:@"注册"]) {
                if ([str isEqualToString:@"1"]) {
                    [MBProgressHUD showMessage:@"该号码已注册" toView:nil];
                } else {
                    NSString *urlStr = [NSString stringWithFormat:@"%@/captcha/%@/type/%@", YueQiApp, self.userNameTF.text, self.type];
                    LgAccount *lgAccount = [LgAccountTool shareLgAccount];
                    lgAccount.user = self.userNameTF.text;

                    [NewWorkingRequestManage requestNoHeadePostWith:urlStr parDic:nil finish:^(id responseObject) {
                        MyLog(@"%@", responseObject);
                        
                        [self timePlay];
                    } error:^(NSError *error) {
                        MBProgressHUD *hud = [MBProgressHUD showMessag:[NewWorkingRequestManage newWork].errorStr toView:nil];
                        [hud hide:YES afterDelay:1];
                        self.actionBtn.userInteractionEnabled  = YES;
                    }];
                    
                }
                
            } else {
                if ([str isEqualToString:@"1"]) {
                    LgAccount *lgAccount = [LgAccountTool shareLgAccount];
                    lgAccount.user = self.userNameTF.text;
                    NSString *urlStr = [NSString stringWithFormat:@"%@/captcha/%@/type/%@", YueQiApp, self.userNameTF.text, self.type];
                    //    MyLog(@"%@", urlStr);
                    [NewWorkingRequestManage requestNoHeadePostWith:urlStr parDic:nil finish:^(id responseObject) {
                        MyLog(@"%@", responseObject);
                        [self timePlay];
                    } error:^(NSError *error) {
                        MBProgressHUD *hud = [MBProgressHUD showMessag:[NewWorkingRequestManage newWork].errorStr toView:nil];
                        [hud hide:YES afterDelay:1];
                        self.actionBtn.userInteractionEnabled  = YES;
                    }];
                    
                } else {
                    [MBProgressHUD showMessage:@"该用户名不存在" toView:nil];
                }
                
            }
        } error:^(NSError *error) {
            sender.enabled = YES;
        }];
    } else {
        sender.enabled = YES;
        [MBProgressHUD showMessage:@"请输入正确的手机号" toView:nil];
    }
}

//页面布局
- (void)initController {
    if ([self.str isEqualToString:@"忘记密码"]) {
        self.titleLabel.text = @"忘记密码";
        self.agreementLabel.hidden = YES;
        self.agreementTwoLabel.hidden = YES;
        [self.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        self.titleLabel.text = @"注册";
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];

    }
    
    self.userNameTF.delegate = self;
}


- (IBAction)nextAction:(UIButton *)sender {
    if (self.verificationTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入验证码" toView:nil];
        return;
    }
    if (self.passwordTF.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:nil];
        return;
    }
    sender.enabled = NO;
    if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 12 || [HelpManager IsChinese:self.passwordTF.text] || [HelpManager isHaveIllegalChar:self.passwordTF.text] ) {
        [MBProgressHUD showError:@"密码格式错误" toView:nil];
        sender.enabled = YES;
        return;
    }
    
    if ([self.type isEqualToString:@"1"]) {
        NSString *url = [NSString stringWithFormat:@"%@/captcha/verify/phone/%@/type/1/code/%@", YueQiApp, self.userNameTF.text, self.verificationTF.text];
        [NewWorkingRequestManage requestNoHeadeGetWith:url parDic:nil finish:^(id responseObject) {
            sender.enabled = YES;
            LgAccount *lgAccount = [LgAccountTool shareLgAccount];
            lgAccount.password = self.passwordTF.text;
            lgAccount.user= self.userNameTF.text;
            lgAccount.vertify = self.verificationTF.text;
            
            
            
            PerfectInformationController *perInforVC = [[PerfectInformationController alloc] init];
            [self.navigationController pushViewController:perInforVC animated:YES];
            
        } error:^(NSError *error) {
            sender.enabled = YES;
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        }];
        
        
    } else {
        LgAccount *lgAccout = [LgAccountTool shareLgAccount];
        NSDictionary *pram = @{@"login_name":lgAccout.user, @"captcha":self.verificationTF.text, @"password":[HelpManager md5HexDigest:self.passwordTF.text]};
        [NewWorkingRequestManage requestNoHeadePUTWith:ForgetPassword parDic:pram finish:^(id responseObject) {
            sender.enabled = YES;
            
            [MBProgressHUD showSuccess:@"修改成功" toView:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        } error:^(NSError *error) {
            sender.enabled = YES;
            
            NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
            [MBProgressHUD showError:@"修改失败" toView:nil];
        }];
    }
    
    
    
    
}


- (IBAction)backAction:(UIButton *)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}



//每隔1秒 调用一次
- (void)timeAction:(NSTimer *)timer
{
    _index--;
    MyLog(@"_index = %ld",(long)_index);
    NSString *again_str = [NSString stringWithFormat:@"%ld",(long)_index];
    [self.actionBtn setTitle:again_str forState:UIControlStateNormal];
    if (_index <= 1) {
        isBool = NO;
        //invalidate  终止定时器
        [self.actionBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.actionBtn.userInteractionEnabled = YES;
        [timer invalidate];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.actionBtn setTitle:[NSString stringWithFormat:@"%ld",(long)_index] forState:UIControlStateNormal];
        });
        
    }
}

- (void)timePlay {
    _index = 60;
    //启动定时器
    NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(timeAction:)
                                                        userInfo:nil
                                                         repeats:YES];
    [testTimer fire];//
    [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSDefaultRunLoopMode];
    self.timer = testTimer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == range.location) {
        if (range.location == 0) {
        }
    } else {
        if (range.location == 0) {
        }
    }
    return YES;
}
- (IBAction)xieyiAction:(UIButton *)sender {
    XiYiViewController *xiyiVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"xiyi"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:xiyiVC];
    xiyiVC.title = @"用户协议";
    [self presentViewController:nav animated:YES completion:nil];
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
