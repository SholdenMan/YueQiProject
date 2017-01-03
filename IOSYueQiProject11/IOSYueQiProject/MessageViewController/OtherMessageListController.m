//
//  OtherMessageListController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OtherMessageListController.h"
#import "OtherMessageTableViewCell.h"
#import "MessageModel.h"
#import "JPUSHService.h"
#import "OtherMessageActionCell.h"

#import "ImviewMeViewController.h"

#import "SponsorDetailViewController.h"

#import "PartyListModel.h"


@interface OtherMessageListController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *nosomthingImage;
@property (nonatomic , copy) NSString *type;

@end

@implementation OtherMessageListController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"OtherMessageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OtherMessageActionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ActionCell"];

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    if ([self.title isEqualToString:@"系统消息"]) {
        self.type = MSG_SYSTEM_NORMAL;
        self.dataSource = [[[[[FMDBHelper shareFMDBHelper] searchMessageModelWith:self.type]reverseObjectEnumerator] allObjects]mutableCopy];

    }else{
        NSMutableArray *messageArray = [NSMutableArray array];
     messageArray = [[[[[FMDBHelper shareFMDBHelper] selectAllMessageSearch]reverseObjectEnumerator]allObjects]mutableCopy];
        
        for (MessageModel *model in messageArray) {
            if ([model.type isEqualToString:MSG_TYPE_GAME_APPLY] || [model.type isEqualToString:MSG_TYPE_GAME_APPLY_PASS] || [model.type isEqualToString:MSG_TYPE_GAME_APPLY_REFUSE]|| [model.type isEqualToString:MSG_TYPE_GAME_INVITE] ||    [model.type isEqualToString:MSG_TYPE_GAME_INVITE_PASS] || [model.type isEqualToString:MSG_TYPE_GAME_INVITE_REFUSE]    || [model.type isEqualToString:MSG_TYPE_GAME_JOIN]   || [model.type isEqualToString:MSG_TYPE_GAME_EXIT] || [model.type isEqualToString:MSG_TYPE_GAME_REMOVE_MEMBER] || [model.type isEqualToString:MSG_TYPE_GAME_DISSOLVE] || [model.type isEqualToString:MSG_TYPE_GAME_ORDER] || [model.type isEqualToString:MSG_TYPE_GAME_MEMBER_PAY_SUCCESS] || [model.type isEqualToString:MSG_TYPE_GAME_PAY_SUCCESS]) {
                [self.dataSource addObject:model];
            }
        }
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];

}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)networkDidReceiveMessage:(NSNotification *)notification{
    [self.dataSource removeAllObjects];
    self.dataSource = [[[[[FMDBHelper shareFMDBHelper] searchMessageModelWith:self.type]reverseObjectEnumerator] allObjects]mutableCopy];
    [self.myTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count == 0) {
        self.nosomthingImage.hidden = NO;
    } else {
        self.nosomthingImage.hidden = YES;
    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model = self.dataSource[indexPath.row];
    
    if ([model.type isEqualToString:MSG_TYPE_GAME_APPLY]) {
        OtherMessageActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionCell" forIndexPath:indexPath];
        [cell showData:model];
        /**
         *  同意申请
         */
        [cell setAgreeBlock:^(UIButton *sender) {
            MessageModel *model = [self getModelWith:sender];
            NSLog(@"%@", model.extra);
//            
            NSString *urlStr = [NSString stringWithFormat:@"%@/v1.0/app/game/%@/apply/%@/pass", YueQiApp, model.extra[@"game_id"], model.extra[@"apply_id"]];
            [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
                [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
                //有多个元素
                [self.dataSource removeObjectAtIndex:indexPath.row];
                //删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                NSLog(@"同意%@", responseObject);
            } error:^(NSError *error) {
                NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
                [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
                //有多个元素
                [self.dataSource removeObjectAtIndex:indexPath.row];
                //删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
        }];
        
        
        
        /**
         *  拒绝申请申请
         */
        [cell setRefuseBlock:^(UIButton *sender) {
            MessageModel *model = [self getModelWith:sender];
            NSLog(@"点击了拒绝");
            NSString *urlStr = [NSString stringWithFormat:@"%@/v1.0/app/game/%@/apply/%@/refuse", YueQiApp, model.extra[@"game_id"], model.extra[@"apply_id"]];
            [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
                
                [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
                //有多个元素
                [self.dataSource removeObjectAtIndex:indexPath.row];
                //删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                NSLog(@"%@", responseObject);
            } error:^(NSError *error) {

                [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
                //有多个元素
                [self.dataSource removeObjectAtIndex:indexPath.row];
                //删除行
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

                NSLog(@"shibai");
            }];

        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
    } else {
        OtherMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell showData:model];
        
        
        /**
         *  查看详情(邀请我的)
         */
        [cell setActionBlock:^(UIButton *sender) {
            MessageModel *model = [self getModelWith:sender];
            if([model.type isEqualToString:MSG_TYPE_GAME_INVITE]) {
                ImviewMeViewController *inviteVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"invite"];
                inviteVC.title = @"邀请我的";
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteVC];
                [self presentViewController:nav animated:YES completion:nil];
            } else {
                
                /**
                 *  查看详情(约局详情)
                 */
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                NSString *urlStr = [NSString stringWithFormat:@"%@/%@/detail", GetPartyLis, model.extra[@"game_id"]];
                [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    NSDictionary *dic = responseObject;
                    PartyListModel *Partymodel = [[PartyListModel alloc] init];
                    [Partymodel setValuesForKeysWithDictionary:dic];
                    SponsorDetailViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"] ;
                    sponsorVC.model = Partymodel;
                    sponsorVC.title = @"约局详情";
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
                    [self presentViewController:nav animated:YES completion:nil];
                } error:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];

                }];
            }
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (MessageModel*)getModelWith:(UIButton *)sender {
    OtherMessageTableViewCell *cell = (OtherMessageTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    MessageModel *model = self.dataSource[path.row];
    return model;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *model = self.dataSource[indexPath.row];
    
    if ([model.type isEqualToString:MSG_TYPE_GAME_APPLY]) {
        return 150;
    } else {
        return 105;
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MessageModel *model = self.dataSource[indexPath.row];
        [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
        //有多个元素
        [self.dataSource removeObjectAtIndex:indexPath.row];
        //删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
