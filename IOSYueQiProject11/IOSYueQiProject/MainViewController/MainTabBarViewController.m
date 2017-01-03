//
//  MainTabBarViewController.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/7/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MoreViewController.h"
#import "SponsorViewController.h"
#import <CoreLocation/CoreLocation.h>




@interface MainTabBarViewController () <UITabBarControllerDelegate,CLLocationManagerDelegate>

//专门负责定位的一个类
@property (nonatomic, strong)CLLocationManager *locationManger;
@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];

    //3.创建定位管理对象
    self.locationManger = [[CLLocationManager alloc] init];
    //当手机设置中定位符没开启,我们进入判断体
    if (![CLLocationManager locationServicesEnabled]) {
        //跳转手机中的设置界面
        NSLog(@"手机设置中的定位没有开启");
        //设置页面URL
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        //跳转页面
        [[UIApplication sharedApplication] openURL:url];
        return;
    }
    
    //判断用户的授权状态
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //请求用户授权
        //当请求当程序运行的时候, 允许定位
        [self.locationManger requestWhenInUseAuthorization];
    }
    //最小更新距离, 超过100米之后就会再次帮我们定位
    self.locationManger.distanceFilter = 1000;
    //设置定位对象的代理
    self.locationManger.delegate = self;
    //开启定位
    [self.locationManger startUpdatingLocation];
    

    

    // Do any additional setup after loading the view.
    self.delegate = self;
  
    UINavigationController *homeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"yueqiNC"];
    homeVC.tabBarItem.title = @"局多多";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"icon-homeyyy-n"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon-homeyyy-p"];
    
    UINavigationController *setimentVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"findNC"];
    setimentVC.tabBarItem.title = @"发现";
    setimentVC.tabBarItem.image = [UIImage imageNamed:@"icon-discover-n"];
    setimentVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon-discover-p"];
    
    MoreViewController *moreVC =[[MoreViewController alloc] init];
    moreVC.tabBarItem.enabled = NO;
    
    UINavigationController *friendVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"messageNC"];
    friendVC.tabBarItem.title = @"消息";
    friendVC.tabBarItem.image = [UIImage imageNamed:@"icon-informationyy-n"];
    friendVC.tabBarItem.selectedImage = [UIImage imageNamed:@"icon-informationyy-p"];
    
    
    UINavigationController *personNvc = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"personNvc"];

    personNvc.tabBarItem.title = @"我的";
    personNvc.tabBarItem.image = [UIImage imageNamed:@"icon-mineyy-n"];
    personNvc.tabBarItem.selectedImage = [UIImage imageNamed:@"icon-mineyy-p"];
    self.viewControllers = @[homeVC, setimentVC, moreVC, friendVC, personNvc];
    
    self.tabBar.tintColor = APPGreenColor;

    
    [self addCenterButtonWithNomalImage:[UIImage imageNamed:@"icon-bigaddyy"]];
    
}


- (void)addCenterButtonWithNomalImage:(UIImage *)buttonImage {
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.centerBtn.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [self.centerBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0) {
        self.centerBtn.center = self.tabBar.center;
    } else {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference / 2.0;
        self.centerBtn.center = center;
    }
    [self.view addSubview:self.centerBtn];
}

- (void)buttonAction:(UIButton *)sender {
    SponsorViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"sponsor"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
    sponsorVC.title = @"茶馆约局";
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    static NSInteger lastindex = 0;
//    NSInteger index = self.selectedIndex;
//    if (index == 1) {
//        [self compare];
//        if (![HelpManager shareHelpManager].isBinding || ![HelpManager isBinding]) {
//            self.selectedIndex = (lastindex < 4 ? 0 :lastindex);
//            return;
//        }
//    }
//    
//    if (index == 3) {
//        [self compare];
//        if (![HelpManager shareHelpManager].isBinding || ![HelpManager isBinding]) {
//            self.selectedIndex = (lastindex < 4 ? 0 :lastindex);
//            return;
//        }
//    }
//    lastindex = self.selectedIndex;
}

//定位失败的回调
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"失败");
}
//定位成功之后的类, 或再次定位的回调方法
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //CLLocation, 位置对象
    CLLocation *location = [locations firstObject];
    //这是一个经纬度的结构体
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"精度:%f, 纬度:%f, 海拔:%f, 速度:%f, 航向:%f", coordinate.longitude, coordinate.latitude, location.altitude, location.speed, location.course);
    
    NSString *longitude = [NSString stringWithFormat:@"%lf", coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%lf", coordinate.latitude];
    [userDef setObject:longitude forKey:@"longitude"];
    [userDef setObject:latitude forKey:@"latitude"];
    NSDictionary *pram = @{@"latitude":latitude,
                           @"longitude":longitude,
                           @"type":@"1"};
    [NewWorkingRequestManage requestPUTWith:UpdateLocation parDic:pram finish:^(id responseObject) {
        
    } error:^(NSError *error) {
        
    }];
    
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
