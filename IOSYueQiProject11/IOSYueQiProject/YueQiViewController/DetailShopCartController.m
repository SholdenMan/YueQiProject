//
//  DetailShopCartController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "DetailShopCartController.h"
#import "FoodListCell.h"
#import "FoodListModel.h"
#import "PayViewController.h"


@interface DetailShopCartController () <UITableViewDataSource, UITableViewDelegate>

{
    float allPrice;

}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation DetailShopCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.rowHeight = 92;

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FoodListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"food"];
    [self getPrice];
}


- (IBAction)payAction:(UIButton *)sender {
    NSMutableArray *itemArray = [NSMutableArray array];
    for (FoodListModel *model in self.dataSource) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:model.ids forKey:@"goods_id"];
        [dic setValue:[NSString stringWithFormat:@"%ld", model.count] forKey:@"num"];
        [itemArray addObject:dic];
    }
    NSDictionary *pram = @{@"game_id":self.game_id,
                           @"items":itemArray};
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/goods/orders", makeOrder, @"1"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
        [MBProgressHUD  hideHUDForView:self.view animated:YES];

        PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
        payVC.order_no = responseObject[@"order_no"];
        [self presentViewController:nav animated:YES completion:nil];

        
        
        NSLog(@"%@",responseObject);
    } error:^(NSError *error) {
        [MBProgressHUD  hideHUDForView:self.view animated:YES];
    }];
    
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodListCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"food" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setAddBlock:^(UIButton *sender) {
        NSIndexPath *path = [self getIndexPathWith:sender];
        FoodListModel *model = [self getModelWith:sender];
        model.count += 1;
        [self getPrice];
        [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    [cell setReduceBlock:^(UIButton *sender) {
        NSIndexPath *path = [self getIndexPathWith:sender];
        FoodListModel *model = [self getModelWith:sender];
        model.count -= 1;
        if (model.count < 0) {
            model.count = 0;
        }
        [self getPrice];
        [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FoodListModel *model =  self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}


- (FoodListModel*)getModelWith:(UIButton *)sender {
    FoodListCell *cell = (FoodListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    FoodListModel *model = self.dataSource[path.row];
    return model;
}

- (NSIndexPath *) getIndexPathWith:(UIButton *)sender {
    FoodListCell *cell = (FoodListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}

- (void) getPrice {
    allPrice = 0;
    for (FoodListModel *model in self.dataSource) {
        allPrice += (model.count * [model.price floatValue]);
    }
    self.priceLabel.text = [NSString stringWithFormat:@"%.2lf", allPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
