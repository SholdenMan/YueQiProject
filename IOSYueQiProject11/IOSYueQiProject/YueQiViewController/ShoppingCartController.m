//
//  ShoppingCartController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShoppingCartController.h"
#import "DetailShopCartController.h"
#import "OrderClassCell.h"
#import "OrderClassModel.h"
#import "FoodListCell.h"
#import "FoodListModel.h"
#import "UIButton+badege.h"
#import "MJRefresh.h"

@interface ShoppingCartController ()<UITableViewDataSource, UITableViewDelegate> {
    UIButton *btn;
    NSInteger allCount;
}

@property (weak, nonatomic) IBOutlet UITableView *classView;

@property (weak, nonatomic) IBOutlet UITableView *foodListView;

@property (nonatomic , strong) NSMutableArray *classDataSource;

@property (nonatomic , strong) NSMutableArray *detailCartSource;


//选中第几个 分类cell
@property (nonatomic , assign) NSInteger indexCell;


@property (nonatomic , copy) NSString *cate_no;

@end

@implementation ShoppingCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"茶点正餐";

    [self.classView registerNib:[UINib nibWithNibName:@"OrderClassCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"class"];
    [self.foodListView registerNib:[UINib nibWithNibName:@"FoodListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"food"];
    
    self.classView.delegate = self;
    self.classView.dataSource = self;
    self.classView.rowHeight = 67;
    self.classView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.classView.tableFooterView = [UIView new];
    
    self.foodListView.delegate = self;
    self.foodListView.dataSource = self;
    self.foodListView.rowHeight = 92;
    self.foodListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.foodListView.tableFooterView = [UIView new];
    
    
    self.indexCell = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon-Shopping-n"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [self creatClassData];
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//购物车详情
- (void) goDetail {
    
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DetailShop"];
    DetailShopCartController *detaVC = (DetailShopCartController *)nav.topViewController;
    
    detaVC.game_id = self.game_id;
    detaVC.dataSource = self.detailCartSource;
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSMutableArray *)classDataSource {
    if (!_classDataSource) {
        self.classDataSource = [NSMutableArray array];
    }
    return _classDataSource;
}


- (NSMutableArray *)detailCartSource {
    if (!_detailCartSource) {
        self.detailCartSource = [NSMutableArray array];
    }
    return _detailCartSource;
}

- (void)creatClassData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/goods/all", getGoodClass, self.storeId];
    
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSDictionary *dic = responseObject;
        for (NSDictionary *modelDic in dic[@"items"]) {
            OrderClassModel *model = [[OrderClassModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.classDataSource addObject:model];
        }
        OrderClassModel *firstModel = self.classDataSource.firstObject;
        firstModel.istap = @"1";
        [self.classView reloadData];
        [self.foodListView reloadData];
    } error:^(NSError *error) {
        
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.classView) {
        return self.classDataSource.count;
    } else {
        if (self.classDataSource.count == 0) {
            return 0;
        } else {
            OrderClassModel *classModel = self.classDataSource[self.indexCell];
            return classModel.goods.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.classView) {
        OrderClassCell *cell = [self.classView dequeueReusableCellWithIdentifier:@"class" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderClassModel *model =  self.classDataSource[indexPath.row];
        [cell showData:model];
        return cell;
    } else {
        
        FoodListCell *cell = [self.foodListView dequeueReusableCellWithIdentifier:@"food" forIndexPath:indexPath];
        [cell setAddBlock:^(UIButton *sender) {
            NSIndexPath *path = [self getIndexPathWith:sender];
            FoodListModel *model = [self getModelWith:sender];
            model.count += 1;
            btn.badgeValue = [NSString stringWithFormat:@"%ld", [self getCount]];
            [self.foodListView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        [cell setReduceBlock:^(UIButton *sender) {
            NSIndexPath *path = [self getIndexPathWith:sender];
            FoodListModel *model = [self getModelWith:sender];
            model.count -= 1;
            if (model.count < 0) {
                model.count = 0;
            }
            btn.badgeValue = [NSString stringWithFormat:@"%ld", [self getCount]];
            [self.foodListView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        OrderClassModel *classModel = self.classDataSource[self.indexCell];
        FoodListModel *model = classModel.goods[indexPath.row];
        [cell showData:model];
        return cell;
    }
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.classView) {
        for (OrderClassModel *model in self.classDataSource) {
            model.istap = @"0";
        }
        OrderClassModel *model = self.classDataSource[indexPath.row];
        model.istap = @"1";
        self.indexCell = indexPath.row;
        [self.classView reloadData];
        [self.foodListView reloadData];
    }
}



- (FoodListModel*)getModelWith:(UIButton *)sender {
    FoodListCell *cell = (FoodListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.foodListView indexPathForCell:cell];
    OrderClassModel *classModel = self.classDataSource[self.indexCell];
    FoodListModel *model = classModel.goods[path.row];
    return model;
}

- (NSIndexPath *) getIndexPathWith:(UIButton *)sender {
    FoodListCell *cell = (FoodListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.foodListView indexPathForCell:cell];
    return path;
}

- (NSInteger) getCount {
    allCount = 0;
    [self.detailCartSource removeAllObjects];
    for (OrderClassModel *model in self.classDataSource) {
        for (FoodListModel *models in model.goods) {
            allCount += models.count;
            if (models.count != 0) {
                [self.detailCartSource addObject:models];
            }
        }
    }
    return allCount;
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
