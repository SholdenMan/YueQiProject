//
//  OrderViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/18.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "OrderViewController.h"
#import "TeaDetailsTableViewCell.h"
#import "FootTableViewCell.h"
#import "ShopDetailModel.h"
#import "MoreModel.h"
#import "BoxTableViewCell.h"
#import "TeaListModel.h"
#import "ReadCycleModel.h"
#import "TigerCycleView.h"
#import "TeaDetailModel.h"
#import "BoxDetailViewController.h"
#import "ShowCommentVC.h"
#import "SheetAlertView.h"



@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (nonatomic, strong)NSMutableArray *iamgeArray;
@property (nonatomic, strong)NSMutableArray *moreArray;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *baseArray;
@property (nonatomic, strong)UIView *taocanView;
@property (weak, nonatomic) IBOutlet UIButton *myCollection;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *jubaoBtn;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iamgeArray = [NSMutableArray array];
    self.moreArray = [NSMutableArray array];
    self.baseArray = [NSMutableArray array];
    self.dataSourceArray = [NSMutableArray array];
    self.taocanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TheW, 20)];
    UILabel *taocanLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, TheW, 10)];
    taocanLabel.text = @"套餐详情";
    taocanLabel.font = [UIFont systemFontOfSize:13];
    [self.taocanView addSubview:taocanLabel];
    self.myTableView.sectionHeaderHeight = 5;
    self.myTableView.sectionFooterHeight = 5;
    self.myTableView.estimatedRowHeight = 60.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;

    [self creatData];
    // Do any additional setup after loading the view.
}

- (void)creatData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.myTableView registerNib:[UINib nibWithNibName:@"TeaDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FootTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BoxTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    NSString *jindu = [userDef objectForKey:@"longitude"];
    NSString *weidu = [userDef objectForKey:@"latitude"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/detail?longitude=%@&latitude=%@", ShopDetailUrl, self.model.teaID, jindu, weidu];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        ShopDetailModel *model = [[ShopDetailModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        [self.baseArray addObject:model];
        for (NSDictionary *dic in responseObject[@"images"]) {
            ReadCycleModel *imageModel = [[ReadCycleModel alloc] init];
            imageModel.url = dic[@"url"];
            [self.iamgeArray addObject:imageModel.url];
        }
        if ([model.favorite isEqualToString:@"1"]) {
            self.myCollection.selected = YES;
        } else {
            self.myCollection.selected = NO;
        }
        TigerCycleView *bannerView = [[TigerCycleView alloc ] initWithImageUrlArray:self.iamgeArray imageChangeTime:3 Frame:CGRectMake(0, 0, TheW, 200)] ;
        [self.bannerView addSubview:bannerView];
        for (NSDictionary *dic in responseObject[@"categories"]) {
            TeaDetailModel *model = [[TeaDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataSourceArray addObject:model];
        }
//        MoreModel *moreModel = [[MoreModel alloc] init];
//        moreModel.business_begin = responseObject[@"business_begin"];
//        moreModel.business_end = responseObject[@"business_end"];
//        [self.moreArray addObject:moreModel];
        [self.myTableView reloadData];
        
        NSLog(@"%@", responseObject);
    } error:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        NSLog(@"失败%@", error);
    }];
}




- (IBAction)shareAction:(UIButton *)sender {
    
}
- (IBAction)collectAction:(UIButton *)sender {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",MyFavoriteUrl, self.model.teaID];
    sender.enabled = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (sender.isSelected) {
        [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
            sender.enabled = YES;
            //        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            sender.selected = !sender.selected;
            //        }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }else{
        [NewWorkingRequestManage requestPostWith:urlStr parDic:nil finish:^(id responseObject) {
            sender.enabled = YES;
            //        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            sender.selected = !sender.selected;
            //        }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } error:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
   
    

    
    
}
- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)jubaoAction:(UIButton *)sender {
    [MBProgressHUD showMessage:@"举报成功" toView:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark   ---    UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.baseArray.count;
        
    }else if(section == 1){
        return self.dataSourceArray.count;
    }else{
        return self.baseArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
             TeaDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            ShopDetailModel *model = self.baseArray[indexPath.row];
            [cell showDataWith:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell setCommentMyBlock:^(UIButton *sender) {
            UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ShowComment"];
                ShowCommentVC *showVC = (ShowCommentVC *)nav.topViewController;
                showVC.teaID = model.teaID;
                [self presentViewController:nav animated:YES completion:nil];
            }];
            [cell setCallBlock:^(UIButton *sender) {
                NSMutableArray *newArray = [NSMutableArray array];
                NSArray * tagsArray = [model.tel componentsSeparatedByString:@";"];
                for (NSString *tel in tagsArray) {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:tel forKey:@"content"];
                    [dic setObject:Color(64, 64, 64) forKey:@"color"];
                    [newArray addObject:dic];
                }
                NSDictionary *dic = @{@"content":@"取消", @"color":Color(64, 64, 64)};
                [newArray addObject:dic];
                SheetAlertView *seet = [SheetAlertView sheetAlertViewWith:newArray];
                [seet setSheetblock:^(NSInteger index) {
                    NSLog(@"%ld", index);
                    if ((index == tagsArray.count)) {
                        [seet removeFromSuperview];

                    }else{
                        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tagsArray[index]];
                        UIWebView * callWebview = [[UIWebView alloc] init];
                        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
                        [self.view addSubview:callWebview];


                    }
                    

                }];
                [[UIApplication sharedApplication].keyWindow addSubview:seet];
            }];
            return cell;
        }
            break;
        case 1:
        {
            BoxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            TeaDetailModel *model = self.dataSourceArray[indexPath.row];
            [cell showModel:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        case 2:
        {
            FootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            ShopDetailModel *model = self.baseArray[indexPath.row];
            [cell showWith:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
   
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 107;
//    }else if(indexPath.section == 1){
//        return 50;
//    }else{
//        return 60;
//    }
//
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 200;
    }else if(section == 1){
        return 30;
    }else{
        return 0;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.myHeaderView;
    }else if(section == 1){
        return self.taocanView;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        BoxDetailViewController *boxDetailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"box"];
        boxDetailVC.paytype = self.paytype;
        boxDetailVC.gameID = self.gameID;
        boxDetailVC.beginTime = self.beginTime;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:boxDetailVC];
        TeaDetailModel *model = self.dataSourceArray[indexPath.row];
        boxDetailVC.model = model;
        boxDetailVC.string = self.model.teaID;
        boxDetailVC.title = @"选购详情";
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
