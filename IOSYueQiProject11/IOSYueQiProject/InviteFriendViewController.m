//
//  InviteFriendViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "InviteFriendViewController.h"
#import "FriendTableViewCell.h"
#import "LaunchModel.h"
#import "SendMessageView.h"


@interface InviteFriendViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *nosomthingImage;
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic , strong) NSMutableArray *searchDataSource;

@property (nonatomic, strong) MBProgressHUD *hud;



@end

@implementation InviteFriendViewController

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
    
    self.myTextFiled.delegate = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTextFiled.returnKeyType = UIReturnKeySearch;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self creatData];
// Do any additional setup after loading the view.
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)tap {
    [self.myTextFiled resignFirstResponder];
}
- (void)creatData{
    NSString *str2 = [self.myTextFiled.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@?page=1&size=10&keyword=%@", FriendList, str2];
    [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            LgAccount *lgmodel = [[LgAccount alloc]init];
            [lgmodel setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:lgmodel];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.dataSource removeAllObjects];
    NSString *str2 = [textField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"%@?page=1&size=100000&keyword=%@", UserList, str2];
    [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            LgAccount *lgmodel = [[LgAccount alloc]init];
            [lgmodel setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:lgmodel];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        
    }];
    [self.myTextFiled resignFirstResponder];
    return YES;
}


#pragma mark === UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LgAccount *model = self.dataSource[indexPath.row];
    [cell setActionBlock:^(UIButton *sender) {
        [self.myTextFiled resignFirstResponder];
//        SendMessageView *sendView = [SendMessageView sendMessageVie];
//        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
//        [sendView setCancleBlock:^{
            LgAccount *model = [self getModelWith:sender];
            NSDictionary *pram =@{@"reason":@""};
            sender.enabled = NO;
            NSString *urlStr = [NSString stringWithFormat:@"%@/v1.0/app/game/%@/invite/%@", YueQiApp, self.teaID , model.ids];
            NSLog(@"邀请网址%@", urlStr);
            self.hud = [MBProgressHUD showMessag:@"正在发送申请" toView:nil];
            [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
                NSLog(@"成功了%@", responseObject);
                [sender setTitle:@"已邀请" forState:UIControlStateNormal];
                [self.hud hide:YES afterDelay:0];

                [MBProgressHUD showMessage:@"邀请成功" toView:nil];
                sender.enabled = YES;
            } error:^(NSError *error) {
                NSString *strMessage = [NSString stringWithFormat:@"邀请失败%@", [NewWorkingRequestManage newWork].errorStr];
                [self.hud hide:YES afterDelay:0];

                [MBProgressHUD showError:strMessage toView:nil];
                sender.enabled = YES;
            }];
//        }];
        
    }];

    [cell inviteList:model];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}


- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
}


- (LgAccount*)getModelWith:(UIButton *)sender {
    FriendTableViewCell *cell = (FriendTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    LgAccount *model = self.dataSource[path.row];
    
    

    return model;
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
