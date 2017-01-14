//
//  AppDelegate.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "AppDelegate.h"


#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "LoginViewController.h"
#import "MainTabBarViewController.h"
#import "MessageModel.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "FristViewController.h"
#import "SponsorViewController.h"

static NSString *appKey = @"e006db61451177038ecc0c7d";

@interface AppDelegate () <WXApiDelegate>



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self creatShortcutItem];  //动态创建应用图标上的3D touch快捷选项
    
//    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
//    if (shortcutItem) {
//        //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
//        if([shortcutItem.type isEqualToString:@"YueQiSponsor"]){
//            NSLog(@"新启动APP-- 第一个按钮");
//            SponsorViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"sponsor"];
//            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
//            sponsorVC.title = @"茶馆约局";
//            self.window.rootViewController = nav;
//
//        }
//        
//        return NO;
//    }
    
    
    
    // Override point for customization after application launch.
    [WXApi registerApp:@"wx920fde9f97d60569" withDescription:@"WeiXinPay"];
    
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"581079db734be4746700483a"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx905290bd9715d439" appSecret:@"0a779391a2163a83addbb1b1bc318008" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105792714" appKey:@"zpv3a9yTRETCofJG" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"161908022"
                                              secret:@"29a27904bb0ef41d3d4512fe8d1b4a26"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    //环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"modo#yueqi"];
    options.apnsCertName = @"YueQi";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    // Override point for customization after application launch.
    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:[userDef objectForKey:@"userName"] password:[userDef objectForKey:@"password"]];
        if (!error) {
            [[EMClient sharedClient].options setIsAutoLogin:YES];
        }
    }

    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:appKey
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
    
    // Override point for customization after application launch.
    //实现收到消息的回调
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    
    
   
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        FristViewController *fristVC = [[FristViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:fristVC];
        self.window.rootViewController = navigation;
    }else {
        
        LoginViewController *logVC = [[LoginViewController alloc] init];
        MainTabBarViewController *rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
        
        if (![userDef objectForKey:@"userID"]) {
            self.window.rootViewController = logVC;
        } else {
            self.window.rootViewController = rootController;
        }
        
    }


    return YES;
}


#pragma JPSH
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}


#warning 
- (void)networkDidReceiveMessage:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
//    if (![userInfo valueForKey:@"content"]) {
//        return;
//    }
    NSString *dataStr = [userInfo valueForKey:@"content"];
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    MessageModel *model = [[MessageModel alloc] init];
    [model setValuesForKeysWithDictionary:array];
    if ([model.type isEqualToString:MSG_FRIEND_REQUEST]) {
        NSArray *array = [[FMDBHelper shareFMDBHelper] searchMessageModelWith:MSG_FRIEND_REQUEST];
        for (MessageModel *messageModel in array) {
            NSString *str1 = [NSString stringWithFormat:@"%@", messageModel.extra[@"request_id"]];
            NSString *str2 = [NSString stringWithFormat:@"%@", model.extra[@"request_id"]];
            if ([str1 isEqualToString:str2]) {
                return;
            }
        }
    }
    if (model.extra) {
        [[FMDBHelper shareFMDBHelper] insertMessageSearchWithContent:model];
    }else{
        return;
    }
    
    
}


#pragma 支付

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                //成功
            } else {
                //失败
            }
            
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

//微信回调
- (void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response = (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.JPceshi.project.IOSYueQiProject" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"IOSYueQiProject" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"IOSYueQiProject.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

//3D touch

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:@"YueQiSponsor"]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            FristViewController *fristVC = [[FristViewController alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:fristVC];
            self.window.rootViewController = navigation;
        }else {
            
            LoginViewController *logVC = [[LoginViewController alloc] init];
//            MainTabBarViewController *rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
            if (![userDef objectForKey:@"userID"]) {
                self.window.rootViewController = logVC;
            } else {
                SponsorViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"sponsor"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
                sponsorVC.title = @"茶馆约局";
                self.window.rootViewController = nav;
            }
            
        }

        NSLog(@"打开了软件");
    }else if([shortcutItem.type isEqualToString:@"YueQiShare"]){
        NSLog(@"分享了");
    }
}
#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
