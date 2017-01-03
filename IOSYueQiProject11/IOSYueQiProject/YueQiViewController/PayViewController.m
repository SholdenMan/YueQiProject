//
//  PayViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/19.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PayViewController.h"
#import "PartyListModel.h"
#import "PayModel.h"
#import "PayTableViewCell.h"
//微信SDK头文件
#import "WXApi.h"
#import "MainTabBarViewController.h"
#import "OrdersModel.h"
#import "MyCouponsViewController.h"
@interface PayViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *yueqiArray;
@property (nonatomic, strong)PayModel *payModel;
@property (nonatomic, strong)OrdersModel *orderModel;
@property (nonatomic, strong)NSMutableArray *orderArray;

@end

@implementation PayViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)orderArray{
    if (!_orderArray) {
        self.orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (NSMutableArray *)yueqiArray {
    if (!_yueqiArray) {
        self.yueqiArray = [NSMutableArray array];
    }
    return _yueqiArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付订单";
    self.payModel = [[PayModel alloc] init];
    self.myTableView.sectionFooterHeight = 2;
    self.myTableView.sectionHeaderHeight = 2;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"暂不支付" style:UIBarButtonItemStylePlain target:self action:@selector(noPay)];
    
    
    
    [self createData];
    // Do any additional setup after loading the view.
}
-(void)cancle{
   }

- (void)noPay{
    MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
    //                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
    [self presentViewController:successVC animated:YES completion:nil];
}
-(void)back{
    ShowAlertView *sendMessage = [ShowAlertView showAlertView];
    sendMessage.contentLabel.text = @"是否取消订单";
    [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
    [sendMessage setConfirmBlock:^{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", DeleOrderUrl,self.payModel.order_no];
        [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
            NSLog(@"%@", responseObject);
            [MBProgressHUD showSuccess:@"取消订单" toView:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } error:^(NSError *error) {
            NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
    }];
    [sendMessage setConfirmBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    //    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)createData{
           NSString *urlStr = [NSString stringWithFormat:@"%@%@", getOrder_noUrl, self.order_no];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            PayModel *model = [[PayModel alloc] init];
            [model setValuesForKeysWithDictionary:responseObject];
            [self.payModel setValuesForKeysWithDictionary:responseObject];
            model.useCoup = @"去选择优惠券";
            [self.dataArray addObject:model];
            [self.myTableView reloadData];

        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            NSLog(@"错误信息%@", [NewWorkingRequestManage newWork].errorStr);
            [MBProgressHUD showError: [NewWorkingRequestManage newWork].errorStr toView:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PayModel *model = self.dataArray.firstObject;
    if (section == 0) {
        return model.orderArray.count + 1;
    }else if(section == 1){
        return self.dataArray.count + 2;
    }else{
        return self.dataArray.count + 3;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PayModel *model = self.dataArray.firstObject;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLabel.text = model.title;
            cell.contentLabel.text = @"";
        }else{
            OrdersModel *orderModel = model.orderArray[indexPath.row - 1];
            cell.titleLabel.text = orderModel.name;
            cell.contentLabel.text = [NSString stringWithFormat:@"X%@", orderModel.num];
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                cell.titleLabel.text = @"订单编号:";
                cell.contentLabel.text = model.order_no;
            }
                break;
            case 1:{
                cell.titleLabel.text = @"创建时间:";
                cell.contentLabel.text =  [self dateText:[model.create_time doubleValue] / 1000];;
            }
                break;
           
            case 2:{
                cell.titleLabel.text = @"预定时间段:";
                cell.contentLabel.text = model.duration;
               
            }
                break;
            default:
            break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
                cell.titleLabel.text = @"订单金额:";
                cell.contentLabel.text = [NSString stringWithFormat:@"¥%@", model.price_text];
            }
                break;
            case 1:
            {
                cell.titleLabel.text = @"付费方式:";
                cell.contentLabel.text = model.pay_type_text;

            }
                break;
            case 2:
            {
                cell.titleLabel.text = @"优惠券:";
                cell.contentLabel.text = model.useCoup;

            }
                break;
            case 3:
            {
                cell.titleLabel.text = @"需付金额:";
                cell.contentLabel.textColor = [UIColor redColor];
                cell.contentLabel.text = [NSString stringWithFormat:@"¥%@", model.fee_text];

            }
                break;
            
            default:
                break;
        }
        
    }
    
  

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 2) {
            NSLog(@"1111");
            MyCouponsViewController *couponsVC = [[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"coupons"];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:couponsVC];
            couponsVC.title = @"我的优惠券";
            [couponsVC setMyBlock:^(NSString *str) {
                PayModel *model = self.dataArray.firstObject;
                model.useCoup = str;
                [self.myTableView reloadData];
            }];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    NSLog(@"2222");

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        NSString *titleStr =self.payModel.name;
//        return titleStr;
//    }else{
//        return nil;
//    }
//}

//时间戳转时间
- (NSString *)dateText:(double)date {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init]; [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

- (IBAction)payAction:(UIButton *)sender {
    UIColor *newColor = [[UIColor alloc] initWithRed:40/255. green:187/255. blue:75/255. alpha:1];
    UIColor *twoColor = [[UIColor alloc] initWithRed:42/255. green:192/255. blue:250/255. alpha:1];
    NSMutableArray *newArray = @[@{@"content":@"支付宝支付",@"color":newColor}, @{@"content":@"微信支付", @"color":twoColor}, @{@"content":@"取消", @"color":[UIColor blackColor]}].mutableCopy;
    SheetAlertView *sheetView = [SheetAlertView sheetAlertViewWith:newArray];
    [sheetView setSheetblock:^(NSInteger inter) {
        switch (inter) {
            case 0:
            {
                NSLog(@"===%@", self.payModel.order_no);
                //支付宝支付
                [HelpManager payWithOrder:self.payModel.order_no WithType:@"0" WithWeb:self];
               
            }
                break;
            case 1:
            {
                //微信支付
                [HelpManager payWithOrder:self.payModel.order_no WithType:@"1" WithWeb:self];

            }
                break;
            case 2:
            {
                NSLog(@"点击取消");
            }
                break;
                
            default:
                break;
        }
        [sheetView removeFromSuperview];
    }];

    
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];

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
