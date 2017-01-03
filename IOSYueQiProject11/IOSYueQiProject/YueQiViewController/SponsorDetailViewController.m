//
//  SponsorDetailViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/4.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SponsorDetailViewController.h"
#import "SponsorDetailTableViewCell.h"
#import "PeopleTableViewCell.h"
#import "InviteFriendViewController.h"
#import "PersonViewController.h"
#import "PartyPersonModel.h"
#import "CountDownButton.h"
#import "PartyListModel.h"
#import "ChatViewController.h"
#import "ListTeaViewController.h"
#import "PayViewController.h"
#import "StartViewController.h"
#import "MainTabBarViewController.h"

//测试
#import "ChooseTeaShopViewController.h"


@interface SponsorDetailViewController ()
@property (nonatomic, strong)UIWindow *testWindow;

@property (weak, nonatomic) IBOutlet CountDownButton *timeBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *myViewTime;
@property (weak, nonatomic) IBOutlet UIButton *jionBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (nonatomic, strong)NSString *beginTime;


@end

@implementation SponsorDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];

    self.myTableView.bounces = NO;
//    self.myTableView.estimatedRowHeight = 44.0f;
//    // 告诉系统, 高度自己计算
//    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    self.headImageView.backgroundColor = [UIColor whiteColor];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 5;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-messageyyyy"] style:UIBarButtonItemStylePlain target:self action:@selector(chart)];
    [self.timeBtn show];
    NSLog(@"%@", self.model.begin_time);
    self.jionBtn.layer.masksToBounds = YES;
    self.jionBtn.layer.cornerRadius = 3;
    self.jionBtn.layer.borderWidth = 1;
    self.jionBtn.layer.borderColor = Color(14,178,181).CGColor;
    self.jionBtn.titleLabel.textColor = Color(14,178,181);

    self.refuseBtn.layer.masksToBounds = YES;
    self.refuseBtn.layer.cornerRadius = 3;
    self.refuseBtn.layer.borderWidth = 1;
    self.refuseBtn.layer.borderColor = Color(14,178,181).CGColor;
    self.refuseBtn.backgroundColor = Color(61, 61, 71);
    self.refuseBtn.titleLabel.textColor = Color(14,178,181);
    
    
    CGFloat time = [self.model.begin_time floatValue] / 1000;
    [self.timeBtn showTime:time];
    self.timeBtn.titleLabel.textColor = Color(87,198,200);
    if ([self.model.join isEqualToString:@"0"]) {
        //游客模式
        self.refuseBtn.hidden = YES;
        self.headImageView.image = [UIImage imageNamed:@"icon-flow1"];
        [self.jionBtn setTitle:@"立即加入" forState:UIControlStateNormal];
    }else{
        if ([self.model.owned isEqualToString:@"1"]) {
            //如果是发起人
            //等待加入模式
            if ([self.model.state isEqualToString:@"0"]) {
                self.refuseBtn.hidden = YES;
                [self.jionBtn setTitle:@"解散约局" forState:UIControlStateNormal];
                self.headImageView.image = [UIImage imageNamed:@"icon-flow1"];
            }
            //人员已满, 准备选择茶馆
            if ([self.model.state isEqualToString:@"1"]) {
                self.refuseBtn.hidden = NO;
                [self.refuseBtn setTitle:@"选择茶馆" forState:UIControlStateNormal];
                 [self.jionBtn setTitle:@"解散约局" forState:UIControlStateNormal];
                self.headImageView.image = [UIImage imageNamed:@"icon-flow2"];
            }
            //立即付款
            if ([self.model.state isEqualToString:@"2"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow3"];

                self.refuseBtn.hidden = NO;
                if ([self.model.pay_type isEqualToString:@"0"]) {
                    [self.refuseBtn setTitle:@"立即付款" forState:UIControlStateNormal];
                }else{
                    [self.refuseBtn setTitle:@"立即付款" forState:UIControlStateNormal];
                }
                [self.jionBtn setTitle:@"解散约局" forState:UIControlStateNormal];
            }
            if ([self.model.state isEqualToString:@"3"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow4"];

                self.refuseBtn.hidden = YES;
                [self.refuseBtn setTitle:@"等待开始" forState:UIControlStateNormal];
                [self.jionBtn setTitle:@"解散约局" forState:UIControlStateNormal];
            }
        }else{
//            //如果不是发起人
            if ([self.model.state isEqualToString:@"0"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow1"];

                self.refuseBtn.hidden = YES;
                [self.jionBtn setTitle:@"退出约局" forState:UIControlStateNormal];
            }
            if ([self.model.state isEqualToString:@"1"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow2"];

                self.refuseBtn.hidden = YES;
                [self.jionBtn setTitle:@"退出约局" forState:UIControlStateNormal];
            }
            if ([self.model.state isEqualToString:@"2"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow3"];

                if ([self.model.pay_type isEqualToString:@"0"]) {
                    self.refuseBtn.hidden = NO;
                    [self.refuseBtn setTitle:@"立即付款" forState:UIControlStateNormal];
                }else{
                    self.refuseBtn.hidden = YES;
                }
                
                [self.jionBtn setTitle:@"退出约局" forState:UIControlStateNormal];

                //写个时间计时器
            }
            if ([self.model.state isEqualToString:@"3"]) {
                self.headImageView.image = [UIImage imageNamed:@"icon-flow4"];
                self.refuseBtn.hidden = NO;
                [self.refuseBtn setTitle:@"等待开始" forState:UIControlStateNormal];

                [self.jionBtn setTitle:@"退出约局" forState:UIControlStateNormal];
            }
        }
    }
    [self creatData];
   
    
    if ([self.model.state isEqualToString:@"1"]) {
//        self.stateLabel.text = @"人满";
    }
    
    if ([self.model.state isEqualToString:@"2"]) {
//        self.stateLabel.text = @"确定茶馆";
    }
    
    if ([self.model.state isEqualToString:@"3"]) {
//        self.stateLabel.text = @"付款成功";
    }
    
    if ([self.model.state isEqualToString:@"4"]) {
//        self.stateLabel.text = @"等待加入";
    }
}

- (void)chart{
    if ([self.model.join isEqualToString: @"1"]) {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.model.im_group_id conversationType:EMConversationTypeGroupChat];
        chatVC.title = [NSString stringWithFormat:@"%@", self.model.subject];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
        [self presentViewController:nav animated:YES completion:nil];

    }else{
        [MBProgressHUD showError:@"您不是约局成员无法加入" toView:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatData{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIImage *image = [HelpManager createImageWithColor:[UIColor colorWithRed:87/255.0 green:198/255.0 blue:200/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"SponsorDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"sponsor"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"PeopleTableViewCell" bundle:nil] forCellReuseIdentifier:@"people"];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---  UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ListTeaViewController *listVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"list"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
//    listVC.title = @"选择茶馆";
//    listVC.type = @"暂定";
//    listVC.nowShop = self.model.store_id;
//    [self presentViewController:nav animated:YES completion:nil];
//
//    PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
//    payVC.model = self.model;
//    [self presentViewController:nav animated:YES completion:nil];
    
    
//    StartViewController *startVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startID"];
//    NSString *urlStr = [NSString stringWithFormat:@"%@%@/detail",TeaDetailUrl , self.model.ids];
//    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
//        PartyListModel *newModel = [[PartyListModel alloc] init];
//        [newModel setValuesForKeysWithDictionary:responseObject];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:startVC];
//        startVC.model = newModel;
//        
//        [self presentViewController:nav animated:YES completion:nil];
//    } error:^(NSError *error) {
//        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
//    }];
//
    
//    MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//    //                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
//    [self presentViewController:successVC animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            PeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"people" forIndexPath:indexPath];
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            //在此判断是否是里面成员, 判断能否邀请人
            if ([self.model.join isEqualToString: @"1"]) {
                [cell setInviteBlock:^(NSString *str) {
                    InviteFriendViewController *inviteFVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:nil] instantiateViewControllerWithIdentifier:@"invite"];
                    inviteFVC.teaID = str;
                    inviteFVC.title = @"选择好友";
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteFVC];
                    [self presentViewController:nav animated:YES completion:nil];
                }];
                
            }else{
                
            }
            
            [cell setMyBlock:^(PartyPersonModel *sender) {
                PersonViewController *personVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"person"];
                personVC.userID = sender.user_id;
                [self presentViewController:personVC animated:YES completion:nil];
                NSLog(@"%@", sender.user_id);
            }];
            [cell showData:self.model];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
        case 1:{
            SponsorDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sponsor" forIndexPath:indexPath];
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            [cell showData:self.model];
            [cell setTimeBlock:^(NSDate *date) {
                NSDateFormatter *newData = [[NSDateFormatter alloc] init];
                [newData setDateFormat:@"MM月dd日HH时mm分"];
                NSString *timeStr = [newData stringFromDate:date];
                cell.playTimeLabel.text = timeStr;
                NSString *urlStr = [NSString stringWithFormat:@"%@/%@", GetPartyLis, self.model.ids];
                NSString *time = [NSString stringWithFormat:@"%.f",[date timeIntervalSince1970] *1000 ];
                self.beginTime = time;
                NSDictionary *dic = @{@"begin_time":time};
                [NewWorkingRequestManage requestPUTWith:urlStr parDic:dic finish:^(id responseObject) {
                    NSLog(@"修改成功%@", responseObject);
                } error:^(NSError *error) {
                    NSLog(@"错误信息%@", [NewWorkingRequestManage newWork].errorStr);
                }];
                
                NSLog(@"%@", timeStr);
            }];
            
            return cell;
        }
            break;
        
        default:
            break;
    }
    
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 110;
    }else if(indexPath.row == 1){
        return 310;
    }else{
        return 0;
    }
}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 220.0;
//    }else{
//        return 0;
//    }
//}



#pragma mark -----计时器
- (IBAction)timeAction:(UIButton *)sender {
    
}
- (IBAction)refuseAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"选择茶馆"]) {
        ListTeaViewController *listVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"list"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
        listVC.title = @"选择茶馆";
        listVC.gameID = self.model.ids;
        listVC.type = @"暂定";
        listVC.nowShop = self.model.store_id;
        if (self.beginTime) {
            listVC.beginTime = self.beginTime;
        }else{
            listVC.beginTime = self.model.begin_time;

        }
        [self presentViewController:nav animated:YES completion:nil];
    }
    if ([sender.titleLabel.text isEqualToString:@"立即付款"]) {
        NSLog(@"跳往付款页面");
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",getOrderUrl, self.model.ids];
        [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
            PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
            payVC.order_no = responseObject[@"order_no"];
            [self presentViewController:nav animated:YES completion:nil];
        } error:^(NSError *error) {
            [MBProgressHUD showError:@"订单不存在" toView:nil];
        }];
    }
    if ([sender.titleLabel.text isEqualToString:@"等待开始"]) {
        [MBProgressHUD showMessage:@"敬请期待" toView:nil];
    }
}
- (IBAction)jionAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"立即加入"]) {
        SendMessageView * sendView = [SendMessageView sendMessageVie];
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        
        [sendView setCancleBlock:^{
            NSDictionary *pram = @{@"reason":sendView.MyTextView.text};
            sender.enabled = NO;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/apply", ApplyUrl ,self.model.ids];
            NSLog(@"邀请网址%@", urlStr);
            
            [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
                [MBProgressHUD showMessage:@"申请成功" toView:nil];
                NSLog(@"成功了%@", responseObject);
                sender.enabled = YES;
            } error:^(NSError *error) {
                sender.enabled = YES;
//                NSLog(@"111%@", [NewWorkingRequestManage newWork].errorStr);
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            }];
        }];
    }
    if ([sender.titleLabel.text isEqualToString:@"退出约局"]) {
        ShowAlertView *sendView = [ShowAlertView showAlertView];
        sendView.contentLabel.text = @"确定要退出约局?";
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        [sendView setConfirmBlock:^{
            sender.enabled = NO;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/members", ApplyUrl ,self.model.ids];
            NSLog(@"邀请网址%@", urlStr);
            [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
                NSLog(@"成功了%@", responseObject);
                [MBProgressHUD showSuccess:@"退出成功" toView:nil];
                MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
                //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
                [self presentViewController:successVC animated:YES completion:nil];                
                sender.enabled = YES;
            } error:^(NSError *error) {
                sender.enabled = YES;
                NSLog(@"111%@", [NewWorkingRequestManage newWork].errorStr);
                [MBProgressHUD showError: [NewWorkingRequestManage newWork].errorStr toView:nil];
            }];
        }];

    }
    if ([sender.titleLabel.text isEqualToString:@"解散约局"]) {
        
        ShowAlertView *sendView = [ShowAlertView showAlertView];
        sendView.contentLabel.text = @"确定要解散约局?";
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        [sendView setConfirmBlock:^{
            sender.enabled = NO;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/members", ApplyUrl ,self.model.ids];
            NSLog(@"解散约局%@", urlStr);
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
                NSLog(@"成功了%@", responseObject);
                [MBProgressHUD hideHUDForView:self.view animated:YES];

                [MBProgressHUD showMessage:@"解散成功" toView:self.view];
                MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
                //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
                [self presentViewController:successVC animated:YES completion:nil];
                sender.enabled = YES;
            } error:^(NSError *error) {
                sender.enabled = YES;
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];

                [MBProgressHUD hideHUDForView:self.view animated:nil];
                NSLog(@"111%@", [NewWorkingRequestManage newWork].errorStr);
            }];
        }];
        
    }

    
}

- (IBAction)showruleAction:(UIButton *)sender {
    ShowAlertView  *sendMessage = [ShowAlertView showAlertView];
    sendMessage.contentLabel.text = @"距离约局开始一小时内解散/退出约局将不返还退款";
    [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
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
