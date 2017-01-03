//
//  FriendRequestsViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FriendRequestsViewController.h"
#import "FriendRequestsTableViewCell.h"
#import "JPUSHService.h"
#import "MessageModel.h"
@interface FriendRequestsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSouce;
@property (weak, nonatomic) IBOutlet UIImageView *nosomthingImage;

@end

@implementation FriendRequestsViewController

- (NSMutableArray *)dataSouce {
    if (!_dataSouce) {
        self.dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.title = @"好友申请";
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView  registerNib:[UINib nibWithNibName:@"FriendRequestsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    self.myTableView.rowHeight = 60;
    [self creatData];
    
}

- (void)creatData {
    [self.dataSouce removeAllObjects];
    NSMutableArray *array = [[[[[FMDBHelper shareFMDBHelper] searchMessageModelWith:MSG_FRIEND_REQUEST]reverseObjectEnumerator] allObjects]mutableCopy];
    for (MessageModel *model in array) {
        [self.dataSouce addObject:model];
    }
    [self.myTableView reloadData];
}

//做对应的操作
- (void)networkDidReceiveMessage:(NSNotification *)notification{
    [self creatData];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSouce.count == 0) {
        self.nosomthingImage.hidden = NO;
    } else {
        self.nosomthingImage.hidden = YES;
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendRequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   [cell setActionBlock:^(UIButton *sender) {
       MessageModel *model = [self getModelWith:sender];
       NSString *urlStr = [NSString stringWithFormat:@"%@/%@/agree", ThroughTheApplication, model.extra[@"request_id"]];
       sender.enabled = NO;
       [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
           sender.enabled = YES;
           model.isRead = @"1";
           [[FMDBHelper shareFMDBHelper] upDataMessageWith:model.msg_id WithUpdata:@"1"];
           [self.myTableView reloadRowsAtIndexPaths:@[[self getIndexPathWith:sender]] withRowAnimation:UITableViewRowAnimationFade];
           NSLog(@"%@", responseObject);
       } error:^(NSError *error) {
           sender.enabled = YES;
           NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
       }];
   }];
    MessageModel *model = self.dataSouce[indexPath.row];
    [cell showData:model];
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MessageModel *model = self.dataSouce[indexPath.row];
        if ([model.isRead isEqualToString:@"0"]) {
            NSString *urlStr = [NSString stringWithFormat:@"%@/%@/refuse", ThroughTheApplication, model.extra[@"request_id"]];
            [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
                NSLog(@"%@", responseObject);
            } error:^(NSError *error) {
                NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
            }];
        }
        [[FMDBHelper shareFMDBHelper] deleteMessageWith:model.msg_id];
        //有多个元素
        [self.dataSouce removeObjectAtIndex:indexPath.row];
        //删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (MessageModel*)getModelWith:(UIButton *)sender {
    FriendRequestsTableViewCell *cell = (FriendRequestsTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    MessageModel *model = self.dataSouce[path.row];
    return model;
}

- (NSIndexPath *) getIndexPathWith:(UIButton *)sender {
    FriendRequestsTableViewCell *cell = (FriendRequestsTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
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
