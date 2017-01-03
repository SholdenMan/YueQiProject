//
//  MyFavoriteViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyFavoriteViewController.h"
#import "MJRefresh.h"
#import "ListTwoTableViewCell.h"
#import "OrderViewController.h"

@interface MyFavoriteViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, assign)BOOL isFlag;


@end

@implementation MyFavoriteViewController
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
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(getdata:)];
    self.myTableView.mj_footer = footer;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.page = 1;
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ListTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"listTwo"];
    self.myTableView.rowHeight = 100;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatData];
    // Do any additional setup after loading the view.
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatData{
    NSString *urlStr = [NSString stringWithFormat:@"%@size=10&page=%ld", FavoriteUrl, self.page];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *arr = responseObject[@"items"];
        for (NSDictionary *dic in arr) {
            TeaListModel *model = [[TeaListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }

        
        
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        self.page += 1;
        self.isFlag = NO;
        NSLog(@"%@", responseObject);
    } error:^(NSError *error) {
        NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
}

#pragma mark ----UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果

    TeaListModel *model = self.dataSource[indexPath.row];
    cell.chooseBtn.hidden = YES;
    cell.newdisLabel.hidden = YES;
    [cell showDataWith:model];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        TeaListModel *model = self.dataSource[indexPath.row];
        OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"order"];
        orderVC.model = model;
//        orderVC.paytype = self.paytype;
//        orderVC.gameID = self.gameID;
//        orderVC.beginTime = self.beginTime;
        [self presentViewController:orderVC animated:YES completion:nil];
}


 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }



 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     TeaListModel *model =self.dataSource[indexPath.row];
     [self deleTeaAction:model];
     
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     [self.myTableView reloadData];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }

- (void)deleTeaAction:(TeaListModel *)model{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", DeleteFavoriteUrl, model.teaID];
    [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
        NSLog(@"成功%@", responseObject);
    } error:^(NSError *error) {
        NSLog(@"失败%@", [NewWorkingRequestManage newWork].errorStr);
    }];
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
