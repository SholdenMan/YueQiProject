//
//  PerfectInformationController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PerfectInformationController.h"
#import "PhotoLibraryView.h"
#import "JPUSHService.h"
#import "MainTabBarViewController.h"
@interface PerfectInformationController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *fouBtn;
@property (weak, nonatomic) IBOutlet UIButton *baomiBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (nonatomic, assign) BOOL isSelecedHead;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (nonatomic , strong) UIImage *myImage;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic , strong) NSArray *imageArray;

@property (nonatomic , copy) NSString *gender;
@property (nonatomic , copy) NSString *smoke;
@property (nonatomic , copy) NSString *feel;
@end

@implementation PerfectInformationController


- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.headBtn.layer.cornerRadius = 40;
    self.headBtn.layer.masksToBounds = YES;
    
    self.gender = @"1";
    self.manBtn.selected = YES;
    
    self.fouBtn.selected = YES;
    self.smoke = @"0";
    
    self.baomiBtn.selected = YES;
    self.feel =  @"0";
    UITapGestureRecognizer *resign = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign)];
    [self.view addGestureRecognizer:resign];
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
    [self.nameTF resignFirstResponder];
}
- (IBAction)manBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.womenBtn.selected = !self.womenBtn.selected;
    self.gender = [self change:self.womenBtn];

}



- (NSString *)change:(UIButton *)sender {
    if (sender.selected) {
        return @"1";
    }
    return @"0";
}

- (IBAction)womenBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.manBtn.selected = !self.manBtn.selected;
    self.gender = [self change:self.manBtn];

}
- (IBAction)smokeAction:(UIButton *)sender {
    
    for (int i = 1; i < 3; i ++) {
        if (i == sender.tag - 100) {
            sender.selected = YES;
            if ([sender.currentTitle isEqualToString:@"是"]) {
                self.smoke = @"1";
            } else {
                self.smoke = @"0";
            }
            NSLog(@"%@", sender.currentTitle);
        }
        else {
            UIButton *button = (UIButton *)[self.view viewWithTag:i + 100];
            button.selected = NO;
        }
    }

}
- (IBAction)feelingAction:(UIButton *)sender {
    
    for (int i = 3; i < 8; i ++) {
        if (i == sender.tag - 100) {
            sender.selected = YES;
            self.feel = [NSString stringWithFormat:@"%d", i - 3];
        }
        else {
            UIButton *button = (UIButton *)[self.view viewWithTag:i + 100];
            button.selected = NO;
        }
    }

    
}
- (IBAction)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)finishAction:(UIButton *)sender {
    
    if (!self.isSelecedHead) {
        [MBProgressHUD showError:@"请设置头像" toView:nil];

        return;
    }
    if (self.nameTF.text.length > 6) {
        [MBProgressHUD showError:@"昵称不能超过6字符" toView:nil];
        return;
    }
    
    
    
    self.hud = [MBProgressHUD showMessag:@"正在上传" toView:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nonce  = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];
    [HelpManager postRequestWithUrl:[NSString stringWithFormat:@"%@?appid=smart_ring&nonce=%@&checksum=%@", UploadImage,nonce, [HelpManager md5HexDigest:[NSString stringWithFormat:@"smart_ring%@", nonce]]] params:nil file:self.imageArray name:@"file" success:^(id json) {
        NSDictionary *headUrl = json;
        LgAccount *lgAccount = [LgAccountTool shareLgAccount];
        lgAccount.head = headUrl[@"url"];
        lgAccount.name = self.nameTF.text;
        //上传个人信息
        [self uploadUser];
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        [self.hud hide:YES afterDelay:0];
    }];

    
}



- (void)uploadUser {
    LgAccount *lgAccount = [LgAccountTool shareLgAccount];
    lgAccount.sex = self.gender;
    NSLog(@"%@, %@, %@", lgAccount.user, lgAccount.vertify, lgAccount.sex);
    NSDictionary *pram = @{@"phone": lgAccount.user,
                           @"nick_name": self.nameTF.text,
                           @"login_name": lgAccount.user,
                           @"captcha": lgAccount.vertify,
                           @"gender": lgAccount.sex,
                           @"emotion": self.feel,
                           @"password": [HelpManager md5HexDigest:lgAccount.password],
                           @"portrait": lgAccount.head
                           };
    MyLog(@"%@", pram);
    [NewWorkingRequestManage requestNoHeadePostWith:MyRegister parDic:pram finish:^(id responseObject) {
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showSuccess:@"注册成功" toView:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
        NSDictionary *pram = @{ @"login_name": lgAccount.user,
                                @"password": [HelpManager md5HexDigest:lgAccount.password]};
        [NewWorkingRequestManage requestNoHeadePostWith:MyLogin parDic:pram finish:^(id responseObject) {
            MyLog(@"%@", responseObject);
            
            
            [self.hud hide:YES afterDelay:0];
            NSString *userID = responseObject[@"user_id"];
            [userDef setObject:userID forKey:@"userID"];
            [userDef setObject:lgAccount.user forKey:@"userName"];
            [userDef setObject:[HelpManager md5HexDigest:lgAccount.password] forKey:@"password"];
            [userDef setObject:responseObject[@"mac_key"] forKey:@"Mackey"];
            [userDef setObject:responseObject[@"access_token"] forKey:@"token"];
            [userDef setObject:responseObject[@"expires_at"] forKey:@"expires_at"];
            NSLog(@"登录获取的token%@", responseObject[@"access_token"]);
            [JPUSHService setTags:[NSSet set]alias:userID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
                MyLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
            }];
            
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                EMError *error = [[EMClient sharedClient] loginWithUsername:lgAccount.user password:[HelpManager md5HexDigest:lgAccount.password]];
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
        }];
            
       
    } error:^(NSError *error) {
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        MyLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
    }];
}
- (IBAction)headAction:(UIButton *)sender {
    
    PhotoLibraryView *photoLibView = [[PhotoLibraryView alloc] init];
    photoLibView.viewController = self.navigationController;
    [photoLibView.buttonOne setTitle:@"拍照" forState:UIControlStateNormal];
    [photoLibView.buttonTwo setTitle:@"选择相册" forState:UIControlStateNormal];
    __weak typeof(photoLibView) weakPhotoLibView = photoLibView;
    photoLibView.PhotoOption = ^{
        [weakPhotoLibView coverClick];
        [self openCrema];
    };
    photoLibView.LibraryOption = ^{
        [weakPhotoLibView coverClick];
        [self openPictureLibrary];
    };
    [photoLibView show];
    

    
}

/** 打开照相机 */
- (void)openCrema
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/** 打开相册 */
- (void)openPictureLibrary
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.isSelecedHead = YES;
    self.myImage = theImage;
    self.imageArray = @[theImage];
    [self.headBtn setBackgroundImage:theImage forState:UIControlStateNormal];
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
