//
//  SetViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SetViewController.h"
#import "SettingTableViewCell.h"
#import "OptionViewController.h"
#import "CustumAlterView.h"
#import "ChangeInfoViewController.h"
#import "LoginViewController.h"
#import "JPUSHService.h"
#import "UserFMDBHelper.h"
#import "AboutViewController.h"
#import "XiYiViewController.h"

@interface SetViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)SettingTableViewCell *cell;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.bounces = NO;
//    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 50;
    self.view.backgroundColor = [[UIColor alloc] initWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIBarButtonItem *leftBut = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBut;

    // Do any additional setup after loading the view from its nib.
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark UITableViewDataSource, UITableViewDelegate




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //cell分割线顶头
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"修改密码";
            cell.contentLabel.hidden = YES;

        }
            break;

        case 1:
        {
            cell.contentLabel.hidden = NO;
            cell.titleLabel.text = @"清除缓存";
            NSString *catch = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
            
            cell.contentLabel.text = [NSString stringWithFormat:@"%.2lfM", [self folderSizeAtPath:catch]];
            
        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"意见反馈";
            cell.contentLabel.hidden = YES;
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"使用协议";
            cell.contentLabel.hidden = YES;
        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"联系我们";
            cell.contentLabel.hidden = YES;
        }
            break;
        case 5:
        {
            cell.titleLabel.text = @"";
            cell.contentLabel.hidden = YES;
            cell.jiantouIcon.hidden = YES;
            
        }
            break;

        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    
    switch (indexPath.row) {
        case 0:
        {
            [self refreshUserinfor:indexPath pramkey:@"修改密码"];

        }
            break;
        case 1:
        {
            CustumAlterView *custumAV = [CustumAlterView custumAlterViewWithTitle:@"" message:@"确认清除缓存?" preferredStyle:CustumAlterViewNoTitle];
            [custumAV.confirmBtn setTitleColor:Color(25, 151, 217) forState:UIControlStateNormal];
            [custumAV showCancle:^{
                
            } accept:^{
                [self removeCache];
//                [[FMDBHelper shareFMDBHelper] deleteAllMessageSearch];
//                NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
                [self.myTableView reloadData];
            }];
            [[UIApplication sharedApplication].keyWindow addSubview:custumAV];
            
        }
            break;
        case 2:
        {
            OptionViewController *optionVC = [[OptionViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:optionVC];
            optionVC.title = @"意见反馈";
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        case 3:
        {
          XiYiViewController *xiyiVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"xiyi"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:xiyiVC];
            xiyiVC.title = @"用户协议";
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 4:
        {
            AboutViewController *about = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"about"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:about];
            about.title = @"局多多";
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    
    
}
- (IBAction)exitAction:(UIButton *)sender {
    CustumAlterView *custumAV = [CustumAlterView custumAlterViewWithTitle:@"" message:@"确认退出" preferredStyle:CustumAlterViewNoTitle];
    [custumAV.cancelButn setTitleColor:Color(25, 151, 217) forState:UIControlStateNormal];
    [custumAV showCancle:^{
        
    } accept:^{
//        [userDef removeObjectForKey:@"userID"];
//        [userDef removeObjectForKey:@"nick_name"];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        [userDef removeObjectForKey:@"token"];
//        [userDef removeObjectForKey:@"userName"];
//        [userDef removeObjectForKey:@"usericon"];
//        [userDef removeObjectForKey:@"nickname"];
//        [userDef removeObjectForKey:@"password"];
//        [userDef removeObjectForKey:@"groupName"];
//        [userDef removeObjectForKey:@"clubicon"];
        [[FMDBHelper shareFMDBHelper] deleteAllMessageSearch];
    
        [[UserFMDBHelper shareFMDBHelper] deleteAllMessageSearch];
        [JPUSHService setTags:[NSSet set]alias:@"1312312312312313123123" fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
            MyLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
        }];
        //退出环信登录
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"退出成功");
        }
        NSLog(@"%@", self.tabBarController);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectIndexOne" object:nil];
//        [self dismissViewControllerAnimated:YES completion:nil];
        LoginViewController *fristVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:fristVC];
        
        [self presentViewController:naVC animated:YES completion:nil];
//
    }];
//
    [[UIApplication sharedApplication].keyWindow addSubview:custumAV];
    
}

- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
}

//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
//清除缓存
-(void)removeCache
{
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files)
    {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

- (void)refreshUserinfor:(NSIndexPath *)indexPath pramkey:(NSString *)pramKey {
    ChangeInfoViewController *changeVC = [[ChangeInfoViewController alloc] init];
    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    changeVC.title = pramKey;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeVC];
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
