//
//  FindMoreViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/24.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FindMoreViewController.h"
#import "TeaListModel.h"
#import "ListTwoTableViewCell.h"
#import "OrderViewController.h"


@interface FindMoreViewController ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSString *payStye;


@end

@implementation FindMoreViewController
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    self.payStye = @"发现";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // Do any additional setup after loading the view.
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatData{
     [self.myTableView registerNib:[UINib nibWithNibName:@"ListTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"listTwo"];
    NSString *nearStr = [NSString stringWithFormat:@"%@page=1&size=10", NearShopUrl];
    [NewWorkingRequestManage requestGetWith:nearStr parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            TeaListModel *model = [[TeaListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ----UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
    TeaListModel *model = self.dataSource[indexPath.row];
    [cell showDataWith:model];
    cell.chooseBtn.hidden = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeaListModel *model = self.dataSource[indexPath.row];
    OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"order"];
    orderVC.model = model;
    orderVC.paytype = self.payStye;
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
