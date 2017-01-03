//
//  MessageClassViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MessageClassViewController.h"
#import "MessageClassTableViewCell.h"
#import "FriendRequestsViewController.h"
#import "OtherMessageListController.h"

@interface MessageClassViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSArray *dataSource;


@end

@implementation MessageClassViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"消息";
    [self.myTableView registerNib:[UINib nibWithNibName:@"MessageClassTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.dataSource = @[@{@"iconImage":@"icon-friendyy", @"content":@"好友申请"}, @{@"iconImage":@"icon- agencyyy", @"content":@"约局消息"}, @{@"iconImage":@"icon-systemyy", @"content":@"系统消息"}];
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)back {
  [self dismissViewControllerAnimated: YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }else {
        return 72;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell showData:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    switch (indexPath.row) {
        case 0:
        {
            FriendRequestsViewController *friendRequestVC = [[FriendRequestsViewController alloc] init];
            [self.navigationController pushViewController:friendRequestVC animated:YES];
        }
            break;
        case 1:
        {
            OtherMessageListController *otherVC = [[OtherMessageListController alloc] init];
            [self.navigationController pushViewController:otherVC animated:YES];

            otherVC.title = @"约局消息";
        }
            break;
        case 2:
        {
            OtherMessageListController *otherVC = [[OtherMessageListController alloc] init];
            [self.navigationController pushViewController:otherVC animated:YES];

            otherVC.title = @"系统消息";

        }
            break;
            
        default:
            break;
    }
    
}

- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
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
