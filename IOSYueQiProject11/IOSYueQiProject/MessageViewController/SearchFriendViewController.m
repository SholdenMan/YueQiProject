//
//  SearchFriendViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SearchFriendViewController.h"
#import "FriendTableViewCell.h"
#import "SendMessageView.h"
@interface SearchFriendViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UITableView *myTebleView;
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *nosomthingImage;

@end

@implementation SearchFriendViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleView.layer.cornerRadius = 5;
    self.titleView.layer.masksToBounds = YES;
    self.titleView.layer.borderWidth = 0.5;
    self.titleView.layer.borderColor = AColor(81, 81, 81, 100).CGColor;
    self.navigationItem.hidesBackButton = YES;
    self.searchTF.delegate = self;
    self.myTebleView.tableFooterView = [UIView new];
    self.myTebleView.rowHeight = 60;
    [self.myTebleView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    self.myTebleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    self.searchTF.returnKeyType = UIReturnKeySearch;
}
- (void)tap {
    [self.searchTF resignFirstResponder];
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
        [self.myTebleView reloadData];
    } error:^(NSError *error) {
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
    [self.searchTF resignFirstResponder];
    return YES;
}


- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [cell showSearchList:model];
    
    [cell setActionBlock:^(UIButton *sender) {
        [self.searchTF resignFirstResponder];
        SendMessageView *sendView = [SendMessageView sendMessageVie];
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        [sendView setCancleBlock:^{
            LgAccount *model = [self getModelWith:sender];
            NSString *urlStr = [NSString stringWithFormat:@"%@", ToApplyForFriend];
            NSDictionary *pram = @{@"target_id":model.ids, @"reason":sendView.MyTextView.text};
            sender.enabled = NO;
            [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
               sender.enabled = YES;
//                model.status = @"2";
//                [self.myTebleView reloadRowsAtIndexPaths:@[[self getIndexPathWith:sender]] withRowAnimation:UITableViewRowAnimationFade];
                NSLog(@"%@", responseObject);
            } error:^(NSError *error) {
                sender.enabled = YES;
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];

                NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
            }];
            
        }];
        
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    
}


- (void)deselect
{
    [self.myTebleView deselectRowAtIndexPath:[self.myTebleView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LgAccount*)getModelWith:(UIButton *)sender {
    FriendTableViewCell *cell = (FriendTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTebleView indexPathForCell:cell];
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
