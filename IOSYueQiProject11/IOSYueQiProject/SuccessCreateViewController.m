//
//  SuccessCreateViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SuccessCreateViewController.h"
#import "InviteFriendViewController.h"
#import "MainTabBarViewController.h"

@interface SuccessCreateViewController ()
@property (nonatomic , strong)NSString *contentStr;
@end

@implementation SuccessCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];

    self.contentStr = [NSString stringWithFormat:@"约局编码:1234567, 开始时间:%@, 时长:%@", self.model.begin_time, self.model.hours];
    [self creatdate];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)creatdate{
    self.view.frame = CGRectMake(0, -64, TheW, TheH);
     self.automaticallyAdjustsScrollViewInsets = NO;
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(goShouye)];
    
}
//- (void)back{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)goShouye{
    MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
    [self presentViewController:successVC animated:YES completion:nil];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareWX:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@邀请你加入约局", [userDef objectForKey:@"nick_name"]];
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        ShareUrl];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:self.contentStr image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            MyLog(@"分享成功！");
        }
    }];
    
}
- (IBAction)shareWXP:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@邀请你加入约局", [userDef objectForKey:@"nick_name"]];
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        ShareUrl];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:self.contentStr image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            MyLog(@"分享成功！");
            //  [share removeView];
        }
    }];

   
}
- (IBAction)shareWB:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@邀请你加入约局", [userDef objectForKey:@"nick_name"]];    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        ShareUrl];

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:self.contentStr image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            MyLog(@"分享成功！");
        }
    }];

}
- (IBAction)shareQQ:(UIButton *)sender {
    [UMSocialData defaultData].extConfig.title = [NSString stringWithFormat:@"%@邀请你加入约局", [userDef objectForKey:@"nick_name"]];    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                                                                                                                                                       ShareUrl];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:self.contentStr image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            MyLog(@"分享成功！");
        }
    }];

    
}
- (IBAction)inviteFriendAction:(UIButton *)sender {
    InviteFriendViewController *inviteFVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:nil] instantiateViewControllerWithIdentifier:@"invite"];
    inviteFVC.teaID = self.model.teaID;
    inviteFVC.title = @"选择好友";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteFVC];
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
