//
//  ChooseTeaShopViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChooseTeaShopViewController.h"
#import "ListTwoTableViewCell.h"
#import "TeaListModel.h"
#import "OrderViewController.h"
@interface ChooseTeaShopViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation ChooseTeaShopViewController

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
    [self.myTableView registerNib:[UINib nibWithNibName:@"ListTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"listTwo"];
    [self getdataWith:nil];
}
- (void)getdataWith:(NSString *)string{
    NSString *jindu = [userDef objectForKey:@"longitude"];
    NSString *weidu = [userDef objectForKey:@"latitude"];
    NSString *urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=1&longitude=%@&latitude=%@", TeaListUrl, jindu, weidu];
    NSString *newStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [NewWorkingRequestManage requestGetWith:newStr parDic:nil finish:^(id responseObject) {
        NSArray *arr = responseObject[@"items"];
        for (NSDictionary *dic in arr) {
            TeaListModel *model = [[TeaListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)quanbuAction:(UIButton *)sender {
    
}
- (IBAction)distanceAction:(UIButton *)sender {
    
}

#pragma mark ---  UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
    TeaListModel *model = self.dataSource[indexPath.row];
    [cell showDataWith:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeaListModel *model = self.dataSource[indexPath.row];
    OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    orderVC.model = model;
    [self presentViewController:orderVC animated:NO completion:nil];
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
