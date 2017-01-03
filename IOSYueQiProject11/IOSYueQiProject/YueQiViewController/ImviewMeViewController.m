//
//  ImviewMeViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/3.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ImviewMeViewController.h"
#import "InviteTableViewCell.h"
#import "PartyListModel.h"

@interface ImviewMeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation ImviewMeViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    // Do any additional setup after loading the view.
}

- (void)creatData{
    [self.myTableView registerNib:[UINib nibWithNibName:@"InviteTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"invite"];
    self.myTableView.rowHeight = 260;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [NewWorkingRequestManage requestGetWith:InviteMeUrl parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            PartyListModel *model = [[PartyListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invite" forIndexPath:indexPath];
     PartyListModel *model = self.dataSource[indexPath.row];
    [cell setChooseBlock:^(UIButton *sender) {
        if ([sender.titleLabel.text isEqualToString:@"拒绝"]) {
            NSLog(@"点击了拒绝");
            NSString *urlStr = [NSString stringWithFormat:@"%@/v1.0/app/game/%@/invite/%@/refuse", YueQiApp, model.ids, model.invite_id];
            [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.myTableView reloadData];
                [MBProgressHUD showMessage:@"已拒绝" toView:nil];
                NSLog(@"%@", responseObject);
            } error:^(NSError *error) {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.myTableView reloadData];
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
                NSLog(@"shibai");
            }];
           
        }else{
            NSLog(@"点击了同意");
            NSString *urlStr = [NSString stringWithFormat:@"%@/v1.0/app/game/%@/invite/%@/pass", YueQiApp, model.ids, model.invite_id];
            [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.myTableView reloadData];
                [MBProgressHUD showMessage:@"已同意" toView:nil];

                NSLog(@"同意%@", responseObject);
            } error:^(NSError *error) {
                NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [self.myTableView reloadData];
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];

            }];
        }
    }];
   
    [cell showData:model];
    return cell;
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
