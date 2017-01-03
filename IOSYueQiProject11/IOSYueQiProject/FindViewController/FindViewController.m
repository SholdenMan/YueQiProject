//
//  FindViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "FindViewController.h"
#import "ListTwoTableViewCell.h"
#import "MoreteaShopTableViewCell.h"
#import "TeaListModel.h"
#import "ReadCycleModel.h"
#import "TigerCycleView.h"
#import "nearView.h"
#import "FindMoreViewController.h"
#import "OrderViewController.h"
#import "MJRefresh.h"
#import "ListTeaViewController.h"

@interface FindViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *myHeadView;
@property (nonatomic, strong)NSMutableArray *nearArray;
@property (nonatomic, strong)NSMutableArray *allShopArray;
@property (nonatomic, strong)NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)UITableViewHeaderFooterView *nearView;
@property (nonatomic, strong)UITableViewHeaderFooterView *recommendView;
@property (nonatomic, assign)BOOL isFlag;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.sectionFooterHeight = 0;
    // Do any additional setup after loading the view.
    self.title = @"发现";
    self.paytype = @"发现";
    
    self.myTableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    //第一分区的头VIEW
    self.nearView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, TheW, 40)];
    UILabel *nearLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 80, 20)];
    nearLabel.font = [UIFont systemFontOfSize:13];
    nearLabel.text = @"附近茶馆";
    [self.nearView addSubview:nearLabel];
    nearLabel.userInteractionEnabled = YES;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(TheW - 60, 10, 60, 20)];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textColor = Color(26, 163, 169);
    [btn setTitleColor:Color(26, 163, 169) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreShop) forControlEvents:UIControlEventTouchUpInside];
    [self.nearView addSubview:btn];
    
    //第二分区的头VIEW
    self.recommendView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, TheW, 40)];
    UILabel *recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 80, 20)];
    recommendLabel.font = [UIFont systemFontOfSize:13];
    recommendLabel.text = @"推荐茶馆";
    [self.recommendView addSubview:recommendLabel];
    self.myTableView.sectionFooterHeight = 0;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ListTwoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"listTwo"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MoreteaShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"moreShop"];

    [self refresh];

//    [self creatData];

}

- (void)moreShop{
    FindMoreViewController *findMoreVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"findmore"];
    findMoreVC.title = @"附近茶馆";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:findMoreVC];
    [self presentViewController:nav animated:YES completion:nil];
    
    NSLog(@"去更多的页面");
}


- (NSMutableArray *)nearArray {
    if (!_nearArray) {
        self.nearArray = [NSMutableArray array];
    }
    return _nearArray;
}

- (NSMutableArray *)allShopArray{
    if (!_allShopArray) {
        self.allShopArray = [NSMutableArray array];
    }
    return _allShopArray;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        self.isFlag = YES;
        [self creatData];
    }];
    [header beginRefreshing];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.myTableView.mj_footer = footer;
}


- (void)creatData{
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
    [NewWorkingRequestManage requestGetWith:FindUrl parDic:nil finish:^(id responseObject) {
        NSLog(@"地址%@", FindUrl);
        if (self.isFlag) {
            [self.nearArray removeAllObjects];
            [self.imageArray removeAllObjects];
            [self.allShopArray removeAllObjects];
        }
        for (NSDictionary *dic in responseObject[@"banners"]) {
            ReadCycleModel *imageModel = [[ReadCycleModel alloc] init];
            imageModel.url = dic[@"url"];
            [self.imageArray addObject:imageModel.url];
        }
        TigerCycleView *bannerView = [[TigerCycleView alloc ] initWithImageUrlArray:self.imageArray imageChangeTime:3 Frame:CGRectMake(0, 0, TheW, 200)] ;
        [self.myHeadView addSubview:bannerView];
//        NSMutableArray *nearbyArray = responseObject[@"nearby"];
//        NSString *countStr = [NSString stringWithFormat:@"%ld", nearbyArray.count];
//        if ([countStr isEqualToString:@"0"]) {
//            
//        }else{
            for (NSDictionary *dic in responseObject[@"nearby"]) {
                TeaListModel *model = [[TeaListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.nearArray addObject:model];
            }
            
//        }
        
        for (NSDictionary *dic in responseObject[@"recommend"]) {
            TeaListModel *model = [[TeaListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.allShopArray addObject:model];
        }
        [self.myTableView reloadData];
        // 刷新表格
//        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];

        NSLog(@"%@", responseObject);
    } error:^(NSError *error) {
        NSLog(@"%@", error);
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        if (self.nearArray.count) {
             return  self.nearArray.count;
        }else{
            return 0;
        }
    }else{
        if (self.allShopArray.count) {
            return self.allShopArray.count;
        }else{
            return 0;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        return 60;
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            MoreteaShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreShop" forIndexPath:indexPath];
            [cell setMyBlock:^{
                ListTeaViewController *listVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"list"];
                //            [listVC setModelBlock:^(TeaListModel *model) {
                //                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
                //                self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
                //                self.model.teaID = model.teaID;
                //                self.model.store = model.address;
                //                [self.myTableView reloadData];
                //
                //            }];
                listVC.type = @"暂定";
                listVC.paytype = self.paytype;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
                listVC.title = @"全部茶馆";
                [self presentViewController:nav animated:YES completion:nil];
            }];
            return cell;
        }
            break;
        case 1:
        {
             ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
                TeaListModel *model = self.nearArray[indexPath.row];
                [cell showDataWith:model];
                cell.chooseBtn.hidden = YES;
           
            return cell;
        }
            break;
        case 2:
        {
            ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
                TeaListModel *model = self.allShopArray[indexPath.row];
                [cell showDataWith:model];
                cell.chooseBtn.hidden = YES;

            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 200;
            break;
        case 1:
            return 40.0;
            break;
        case 2:
            return 40.0;
            break;
        default:
            return 0;
            break;
    }
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSLog(@"======%ld", section);
//    switch (section) {
//        case 0:
//        return self.myHeadView;
//            break;
//        case 1:
//        {
////            nearView *view = [[nearView alloc] initWithReuseIdentifier:@"header"];
////            view.titleLabel.text = @"附近额茶馆";
////            
////            return view;
//            return nil;
// 
//        }
//            break;
//        case 2:
//        {
//            nearView *view = [[nearView alloc] initWithReuseIdentifier:@"header"];
//            view.titleLabel.text = @"推荐茶馆";
//            view.moreButton.hidden = YES;
//            return nil;
//        }
//            break;
//        default:
//            return nil;
//            break;
//    }
    
    if (section==0) {
        return self.myHeadView;
    }else if(section == 1 ){
        return self.nearView;
    }else{
        return self.recommendView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    switch (indexPath.section) {
        case 0:
        {
            
            ListTeaViewController *listVC = [[UIStoryboard storyboardWithName:@"Sponsor" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"list"];
//            [listVC setModelBlock:^(TeaListModel *model) {
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:1];
//                self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
//                self.model.teaID = model.teaID;
//                self.model.store = model.address;
//                [self.myTableView reloadData];
//                
//            }];
            listVC.type = @"暂定";
            listVC.paytype = self.paytype;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:listVC];
            listVC.title = @"全部茶馆";
            [self presentViewController:nav animated:YES completion:nil];
            NSLog(@"去所有页面");
            
        }
            break;
        case 1:
        {
            TeaListModel *model = self.nearArray[indexPath.row];
            OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"order"];
            orderVC.paytype = self.paytype;
            orderVC.model = model;
            [self presentViewController:orderVC animated:NO completion:nil];

            
        }
            break;
        case 2:
        {
            TeaListModel *model = self.allShopArray[indexPath.row];
            OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"order"];
            orderVC.paytype = self.paytype;
            orderVC.model = model;
            [self presentViewController:orderVC animated:NO completion:nil];
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
