//
//  SearchResultViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SearchResultViewController.h"
#import "YueQiTableViewCell.h"
#import "PersonViewController.h"
#import "ImviewMeViewController.h"
#import "ScanningViewController.h"
#import "SponsorDetailViewController.h"
#import "StartViewController.h"
#import "ScreenViewController.h"
#import "PartyListModel.h"
@interface SearchResultViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextFiled;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation SearchResultViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myTableView registerNib:[UINib nibWithNibName:@"YueQiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.rowHeight = 230;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancleAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self creatDataswith:textField.text];
    [self.myTextFiled resignFirstResponder];
    return YES;
}

- (void)creatDataswith:(NSString *)str{
    NSString *url = [NSString string];
        url = [NSString stringWithFormat:@"%@/search?keyword=%@", GetPartyLis, str];
    //http://17178.xmappservice.com/v1.0/app/games/search?keyword=213
//    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
        
        [self.dataSource removeAllObjects];
        NSArray *array = responseObject[@"items"];
        for (NSDictionary *modelDic in array) {
            PartyListModel *model = [[PartyListModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.dataSource addObject:model];
        }
        // 刷新表格
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YueQiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PartyListModel *model = self.dataSource[indexPath.row];
    
    [cell setMyBlock:^(PartyPersonModel *sender) {
        PersonViewController *personVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"person"];
        personVC.userID = sender.user_id;
        [self presentViewController:personVC animated:YES completion:nil];
        NSLog(@"%@", sender.user_id);
    }];
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PartyListModel *model = self.dataSource[indexPath.row];
    if (model.state.integerValue > 3) {
        StartViewController *startVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"startID"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:startVC];
        startVC.model = model;
        [self presentViewController:nav animated:YES completion:nil];
        
    }else{
        SponsorDetailViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"] ;
        sponsorVC.model = model;
        sponsorVC.title = @"约局详情";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
        [self presentViewController:nav animated:YES completion:nil];
        
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
