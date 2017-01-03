//
//  MineViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MineViewController.h"
#import "LgAccount.h"
#import <UIButton+WebCache.h>
#import "MyInfoViewController.h"
#import "SetViewController.h"
#import "MyCouponsViewController.h"
#import "MyOrderViewController.h"
#import "MySponsorViewController.h"
#import "MyFavoriteViewController.h"
#import "CommentViewController.h"
#import "IntegralViewController.h"
@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic, strong)LgAccount *personModel;
@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *district;
@property (nonatomic, strong)NSString *city;
@property (weak, nonatomic) IBOutlet UIButton *myCouponsBtn;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(creatData) name:@"refresh" object:nil];
    [self creatData];
    // Do any additional setup after loading the view.

}
- (void)creatData{
    self.iconButton.layer.cornerRadius = 30;
    self.iconButton.layer.masksToBounds = YES;
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", UserInfo,[userDef objectForKey:@"userID"]];
    NSLog(@"地址%@", strUrl);
    [NewWorkingRequestManage requestGetWith:strUrl parDic:nil finish:^(id responseObject) {
        self.personModel = [[LgAccount alloc] init];
        self.personModel.age = [NSString stringWithFormat:@"%@", responseObject[@"age"]];
        self.personModel.birthday = [NSString stringWithFormat:@"%@",responseObject[@"birthday"]];
        self.personModel.location = [NSString stringWithFormat:@"%@", responseObject[@"city"]];
        self.personModel.sex = [NSString stringWithFormat:@"%@", responseObject[@"gender"]];
        self.personModel.name = [NSString stringWithFormat:@"%@", responseObject[@"nick_name"]];
        self.personModel.user = [NSString stringWithFormat:@"%@", responseObject[@"login_name"]];
        self.personModel.phone = [NSString stringWithFormat:@"%@", responseObject[@"phone"]];
        self.personModel.sign = [NSString stringWithFormat:@"%@", responseObject[@"sign"]];
        self.personModel.head = [NSString stringWithFormat:@"%@", responseObject[@"portrait"]];
        self.personModel.smoking = [NSString stringWithFormat:@"%@", responseObject[@"smoking"]];
        self.personModel.job = [NSString stringWithFormat:@"%@", responseObject[@"occupation"]];
        self.personModel.relationship = [NSString stringWithFormat:@"%@", responseObject[@"emotion"]];
        self.personModel.ids = [NSString stringWithFormat:@"%@", responseObject[@"user_id"]];
        self.province = [NSString stringWithFormat:@"%@", responseObject[@"province"]];
        self.city = [NSString stringWithFormat:@"%@", responseObject[@"city"]];
        self.district = [NSString stringWithFormat:@"%@", responseObject[@"district"]];
        NSLog(@"----%@", self.personModel.name);
        self.nameLabel.text = [NSString stringWithFormat:@"%@", self.personModel.name];
        self.numberLabel.text =[NSString stringWithFormat:@"账号:%@", self.personModel.ids];
        self.personModel.score = [NSString stringWithFormat:@"%@", responseObject[@"score"]];
        [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.personModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon-head"]];
        
    } error:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goMyInfoAction:(UIButton *)sender {
    MyInfoViewController *myInfoVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"myInfo"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:myInfoVC];
    myInfoVC.myModel = self.personModel;
    myInfoVC.city = self.city;
    myInfoVC.province = self.province;
    myInfoVC.district = self.district;
    myInfoVC.title = @"个人信息";
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)goSettingAction:(UIButton *)sender {
    SetViewController *setVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"setting"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:setVC];
    setVC.title = @"设置";
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)goCouponsAction:(UIButton *)sender {
    MyCouponsViewController *couponsVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"coupons"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:couponsVC];
    couponsVC.title = @"我的优惠券";
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)goOlderAction:(UIButton *)sender {
    MyOrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.title = @"我的订单";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (IBAction)goPayAction:(UIButton *)sender {
    MyOrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.title = @"待付款";
    orderVC.orderby = @"0";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self presentViewController:nav animated:YES completion:nil];

    
}
- (IBAction)goPinjia:(UIButton *)sender {
    MyOrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.title = @"待评价";
    orderVC.orderby = @"1";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self presentViewController:nav animated:YES completion:nil];

    
}
- (IBAction)goTuikuan:(UIButton *)sender {
    MyOrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.title = @"退款";
    orderVC.orderby = @"5";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    [self presentViewController:nav animated:YES completion:nil];

    
}
- (IBAction)myAction:(UIButton *)sender {
    MySponsorViewController *mySponsorVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"mySponsor"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mySponsorVC];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)myCollectAction:(UIButton *)sender {
    MyFavoriteViewController *favVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"fav"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:favVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)myIntegralAction:(UIButton *)sender {
    
    IntegralViewController *integralVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"integral"];
    integralVC.title = @"我的积分";
    integralVC.source = self.personModel.score;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:integralVC];
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
