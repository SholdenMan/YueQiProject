//
//  MySponsorViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MySponsorViewController.h"
#import "YueQiTableViewCell.h"
#import "MJRefresh.h"
#import "PartyListModel.h"
#import "PersonViewController.h"
#import "SponsorDetailViewController.h"
#import "StartViewController.h"


@interface MySponsorViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, assign)BOOL isFlag;

@property (nonatomic , strong) NSMutableArray *dataSource;
@end

@implementation MySponsorViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.title = @"我的约局";
    self.page = 1;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"YueQiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.rowHeight = 230;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refresh];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)creatData{
    NSString *urlStr = [NSString stringWithFormat:@"%@size=10&page=%ld", MySponsorUrl, self.page];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *array = responseObject[@"items"];
        for (NSDictionary *modelDic in array) {
            PartyListModel *model = [[PartyListModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.dataSource addObject:model];
        }
        // 刷新表格
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        self.page += 1;
        self.isFlag = NO;

        NSLog(@"%@", responseObject);
        
    } error:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];

        NSLog(@"%@", error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
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
