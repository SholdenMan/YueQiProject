//
//  YueQiViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "YueQiViewController.h"
#import "YueQiTableViewCell.h"
#import "MJRefresh.h"
#import "PartyListModel.h"
#import "PersonViewController.h"
#import "ImviewMeViewController.h"
#import "ScanningViewController.h"
#import "SponsorDetailViewController.h"
#import "StartViewController.h"
#import "ScreenViewController.h"
#import "SearchResultViewController.h"

@interface YueQiViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (nonatomic , assign) NSInteger page;
@property (nonatomic, assign)BOOL isFlag;

@property (nonatomic , strong) NSMutableArray *dataSource;

@end

@implementation YueQiViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



- (void)refreshWith:(NSString *)str {
    if ([str isEqualToString:@"shaixuan"]) {
    }else{
        self.urlStr = NULL;
    }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部

        self.isFlag = YES;
        self.page = 1;
        [self creatDataswith:nil];
    }];
    
    [header beginRefreshing];
    
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatDataswith:)];
    self.myTableView.mj_footer = footer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWith:) name:@"homeRefreshssss" object:nil];
    // Do any additional setup after loading the view.
    self.title = @"局多多";
    self.page = 1;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"YueQiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.myTableView.rowHeight = 260;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *shaixuanItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-screenyyy"] style:UIBarButtonItemStylePlain target:self action:@selector(shaixuan)];
    UIButton *yaoqingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [yaoqingBtn addTarget:self action:@selector(yaoqing) forControlEvents:UIControlEventTouchUpInside];
    yaoqingBtn.frame = CGRectMake(0, 0, 50, 30);
    [yaoqingBtn setTitle:@"邀请我" forState:UIControlStateNormal];
    [yaoqingBtn setTitleColor:APPGreenColor forState:UIControlStateNormal];
    UIBarButtonItem *yaoqingItem = [[UIBarButtonItem alloc] initWithCustomView:yaoqingBtn];
    self.navigationItem.rightBarButtonItems = @[shaixuanItem, yaoqingItem];
    self.searchTF.delegate = self;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-saoys"] style:UIBarButtonItemStylePlain target:self action:@selector(saomiao)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    [self refreshWith:@"1"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTF resignFirstResponder];
    return YES;
}
//扫描
- (void)saomiao{
    ScanningViewController * sVC = [[ScanningViewController alloc]init];
    sVC.hidesBottomBarWhenPushed=YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sVC];
    sVC.title = @"扫描二维码";
    [self presentViewController:nav animated:YES completion:nil];
    
    
}
//筛选
- (void) shaixuan {
    ScreenViewController *screenVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"screen"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:screenVC];
    screenVC.title = @"筛选";
    [screenVC setMyBlock:^(NSString *str) {
        self.urlStr = str;
        [self refreshWith:@"shaixuan"];
        NSLog(@"拼接的url%@", str);
    }];
    [self presentViewController:nav animated:YES completion:nil];
    
}

//邀请
- (void) yaoqing {
    ImviewMeViewController *inviteVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"invite"];
    inviteVC.title = @"邀请我的";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inviteVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    
}
- (void)creatDataswith:(NSString *)str{
    NSString *url = [NSString string];
    if (self.urlStr) {
      url = [NSString stringWithFormat:@"%@?size=10&page=%ld&city=厦门&%@", GetPartyLis, self.page, self.urlStr];
    }else{
    url = [NSString stringWithFormat:@"%@?size=10&page=%ld&city=厦门", GetPartyLis, self.page];
    }
//    NSLog(@"%@", url);
//    NSString *urlStr = @"http://17178.xmappservice.com/v1.0/app/games?size=10&page=1&city=%E5%8E%A6%E9%97%A8";
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
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
        self.urlStr = NULL;

        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        self.page += 1;
        self.isFlag = NO;
    } error:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        NSLog(@"错误%@", error);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchAction:(UIButton *)sender {
    SearchResultViewController *searchRVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"searchR"];
    [self presentViewController:searchRVC animated:YES completion:nil];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
*/


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
        NSString *urlStr = [NSString stringWithFormat:@"%@%@/detail",TeaDetailUrl , model.ids];
        [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
            PartyListModel *newModel = [[PartyListModel alloc] init];
            [newModel setValuesForKeysWithDictionary:responseObject];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:startVC];
            startVC.model = newModel;
            
            [self presentViewController:nav animated:YES completion:nil];
        } error:^(NSError *error) {
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        }];

//
    }else{
        SponsorDetailViewController *sponsorVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:nil] instantiateViewControllerWithIdentifier:@"detail"] ;
        sponsorVC.title = @"约局详情";
        NSString *urlStr = [NSString stringWithFormat:@"%@%@/detail",TeaDetailUrl , model.ids];
        [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
            PartyListModel *newModel = [[PartyListModel alloc] init];
            [newModel setValuesForKeysWithDictionary:responseObject];
            sponsorVC.model = newModel;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sponsorVC];
            [self presentViewController:nav animated:YES completion:nil];
        } error:^(NSError *error) {
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        }];
    }
}


@end
