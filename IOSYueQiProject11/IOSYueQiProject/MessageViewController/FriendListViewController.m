//
//  FriendListViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FriendListViewController.h"
#import "FriendTableViewCell.h"
#import "MJRefresh.h"
#import "ChatViewController.h"
#import "OtherModel.h"

#import "UserFMDBHelper.h"
#import "PersonViewController.h"

@interface FriendListViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , strong) NSMutableArray *searchDataSource;
@property (weak, nonatomic) IBOutlet UIImageView *nosomthingImage;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;

@property (nonatomic , assign) BOOL isSearch;
@end

@implementation FriendListViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        self.searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    NSLog(@"%@", [userDef objectForKey:@"userID"]);
    [self.myTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Friendcell"];
    self.title = @"好友列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    self.searchTF.delegate = self;
    self.page = 1;
    self.searchTF.returnKeyType = UIReturnKeySearch;
//    [self creatData];
    [self refresh];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (void)tap {
    
    if (self.searchTF.isFirstResponder) {
        [self.searchTF resignFirstResponder];
        [self.dataSource removeAllObjects];
        [self.myTableView reloadData];
        self.isFlag = YES;
        self.page = 1;
        self.searchTF.text = @"";
        [self creatData];
    }
}

- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        self.isFlag = YES;
        self.page = 1;
        [self creatData];
    }];
    
    [header beginRefreshing];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.myTableView.mj_footer = footer;
}


- (void)creatData {
    
    NSString *str2 = [self.searchTF.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@?page=%ld&size=10&keyword=%@", FriendList, self.page, str2];
    [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        for (NSDictionary *dic in responseObject[@"items"]) {
            LgAccount *lgmodel = [[LgAccount alloc] init];
            [lgmodel setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:lgmodel];
        }
        self.page += 1;
        self.isFlag = NO;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];

    } error:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:self.view];
    }];
}



- (void)back {
    [self dismissViewControllerAnimated: YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Friendcell" forIndexPath:indexPath];
    LgAccount *model = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    //有多个元素

    [cell setActionBlock:^(UIButton *sender) {
        NSString *url = [NSString stringWithFormat:@"%@/%@", FriendList, model.ids];
        [NewWorkingRequestManage requestDELETEWith:url parDic:nil finish:^(id responseObject) {
            [self refresh];
        } error:^(NSError *error) {
            
        }];
    }];
    [cell showFriendList:model];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    LgAccount *model = self.dataSource[indexPath.row];
    {
        OtherModel *otherModel = [[OtherModel alloc] init];
        otherModel.othername = model.name;
        otherModel.icon = model.head;
        otherModel.userphone = model.ids;
        [[UserFMDBHelper shareFMDBHelper] insertMessageSearchWithContent:otherModel];

    }
    //model.ids 就是用户账号
//    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:model.user conversationType:EMConversationTypeChat];
//    chatVC.title = [NSString stringWithFormat:@"%@", model.name];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
//    [self presentViewController:nav animated:YES completion:nil];
//    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    PersonViewController *personVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"person"];
    personVC.userID = model.ids;
    [self presentViewController:personVC animated:YES completion:nil];

}


- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LgAccount *model = self.dataSource[indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@/%@", FriendList, model.ids];
        [NewWorkingRequestManage requestDELETEWith:url parDic:nil finish:^(id responseObject) {
            
        } error:^(NSError *error) {
            
        }];
        //有多个元素
        [self.dataSource removeObjectAtIndex:indexPath.row];
        //删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



#pragma 搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.dataSource removeAllObjects];
    [self.myTableView reloadData];
    self.isFlag = YES;
    self.page = 1;
    [self creatData];
    [self.searchTF resignFirstResponder];
    return YES;
}

//
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == range.location) {
        if (range.location == 0) {
            self.isSearch = YES;
        }
    } else {
        if (range.location == 0) {
            self.isSearch = NO;
        }
    }
    
    return YES;
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
