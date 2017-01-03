//
//  MyOrderViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
#import "CommentViewController.h"
#import "PayViewController.h"
#import "MJRefresh.h"

@interface MyOrderViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic , assign) NSInteger page;
@property (nonatomic, assign)BOOL isFlag;

@end

@implementation MyOrderViewController

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;

    [self refresh];
    
    // Do any additional setup after loading the view.
}
- (void)refresh{
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


- (void)creatData {
    NSString *urlStr = [NSString string];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    if (self.orderby) {
        urlStr = [NSString stringWithFormat:@"%@size=10&page=%ld&state=%@", MyOrderUrl,self.page, self.orderby];
    }else{
        urlStr = [NSString stringWithFormat:@"%@size=10&page=%ld",MyOrderUrl, self.page];
    }
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        for (NSDictionary *dic in responseObject[@"items"]) {
            MyOrderModel *model = [[MyOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        self.page += 1;
        self.isFlag = NO;
    } error:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ======UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MyOrderModel *model = [[MyOrderModel alloc] init];
    model = self.dataSource[indexPath.row];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    [cell showMode:model];
    [cell setMyBlock:^(UIButton *sender) {
        if ([sender.titleLabel.text isEqualToString:@"评价"]) {
            CommentViewController *commentVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"comment"];
            commentVC.title = @"评价";
            commentVC.orderID = model.order_id;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:commentVC];
            [self presentViewController:nav animated:YES completion:nil];

        }else if([sender.titleLabel.text isEqualToString:@"立即支付"]){
            NSLog(@"去支付");
            PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
            payVC.order_no = model.order_no;
            NSString *urlStr = [NSString stringWithFormat:@"%@%@", getOrder_noUrl, payVC.order_no];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [self presentViewController:nav animated:YES completion:nil];

            } error:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                NSLog(@"错误信息%@", [NewWorkingRequestManage newWork].errorStr);
                [MBProgressHUD showError: [NewWorkingRequestManage newWork].errorStr toView:nil];
            }];
        }else if([sender.titleLabel.text isEqualToString:@"退款"]){
            ShowAlertView *sendMessage = [ShowAlertView showAlertView];
            sendMessage.contentLabel.text = @"是否取消订单？约局开始1小时内取消订单不退款";
            [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
            [sendMessage  setConfirmBlock:^{
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", DeleOrderUrl,model.order_no];
                [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
                    NSLog(@"%@", responseObject);
                    [MBProgressHUD showSuccess:@"取消订单" toView:nil];
                    
                } error:^(NSError *error) {
                    NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
                    [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];                    
                }];

            }];
        }
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
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
