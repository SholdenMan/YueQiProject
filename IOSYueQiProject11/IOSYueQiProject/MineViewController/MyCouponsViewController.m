//
//  MyCouponsViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyCouponsViewController.h"
#import "TicketTableViewCell.h"
#import "TicketModel.h"
#import "LoseTicketViewController.h"
@interface MyCouponsViewController ()
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *shixiaoData;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;




@end

@implementation MyCouponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.shixiaoData = [NSMutableArray array];
    [self creatDate];
    // Do any additional setup after loading the view.
}

- (void)creatDate{
    [self.myTableView registerNib:[UINib nibWithNibName:@"TicketTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"已失效" style:UIBarButtonItemStylePlain target:self action:@selector(shixiao)];

    NSString *urlStr = [NSString stringWithFormat:@"%@page=1&size=50", CouponsUrl];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        arr = responseObject[@"items"];
        for (NSDictionary *dic in arr) {
            TicketModel *model = [[TicketModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if ([model.state isEqualToString:@"1"]) {
                [self.dataSource addObject:model];
            }else {
                [self.shixiaoData addObject:model];
            }
        }
        [self.myTableView reloadData];

    } error:^(NSError *error) {
        NSLog(@"错误信息%@", error);
    }];
}
- (void)shixiao{
    LoseTicketViewController *loseVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"lose"];
    loseVC.title = @"已失效";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loseVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TicketModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    [cell setUseBlock:^(TicketModel *model) {
        if (self.order_no) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/usecoupon/%@", UseCouponsUrl, self.order_no,model.qrcode_id];
            [NewWorkingRequestManage requestPUTWith:urlStr parDic:nil finish:^(id responseObject) {
                NSString *str = @"已选择";
                NSLog(@"%@", responseObject);
                if (self.myBlock) {
                    self.myBlock(str);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            } error:^(NSError *error) {
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:self.view];
            }];
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketModel *model = self.dataSource[indexPath.row];
    if (self.myBlock) {
        self.myBlock(model.qrcode_id);
    }
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160.0f;
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
