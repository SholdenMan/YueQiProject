//
//  BoxDetailViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/21.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "BoxDetailViewController.h"
#import "TeaDetailModel.h"
#import "TeaDetailsTableViewCell.h"
#import "FootTableViewCell.h"
#import "ChooseTableViewCell.h"
#import "TeaDetailModel.h"
#import "BoxModel.h"
#import "ShopDetailModel.h"
#import "TimeTableViewCell.h"
#import "PayViewController.h"
#import "ShowCommentVC.h"

@interface BoxDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *myHeadView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *moreArray;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)NSMutableArray *detailArray;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic, strong)MBProgressHUD *hud;


@end

@implementation BoxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.moreArray  =  [NSMutableArray array];
    self.detailArray = [NSMutableArray array];
    self.time = [HelpManager getCurrentTimestamp];
    [self creatData];

//    http://17178.xmappservice.com/v1.0/app/store/1/room/categories/1?begin_time=1231232132132&end_time=3123213213132
    
    // Do any additional setup after loading the view.
}

- (void)creatData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    NSString *nowTime = [HelpManager getCurrentTimestamp];
    self.myTableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"ChooseTableViewCell" bundle:nil] forCellReuseIdentifier:@"choose"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"TeaDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"FootTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
     [self.myTableView registerNib:[UINib nibWithNibName:@"TimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"time"];
    self.myTableView.sectionHeaderHeight = 5;
    self.myTableView.sectionFooterHeight = 5;
    NSString *beginTime = [NSString stringWithFormat:@"%ld", nowTime.integerValue *1000];
    NSString *store = self.string;
    NSString *room = self.model.ids;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/room/categories/%@?begin_time=%@", getBoxDetail,store, room, beginTime];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        BoxModel *boxmodel = [[BoxModel alloc] init];
        boxmodel.nowtime = [NSString stringWithFormat:@"%ld", [HelpManager getCurrentTimestamp].integerValue];
        [boxmodel setValuesForKeysWithDictionary:responseObject];
        [self.dataSource addObject:boxmodel];
        self.nameLabel.text = responseObject[@"store"][@"name"];
        self.timeLabel.text = [NSString stringWithFormat:@"茶馆包厢(%@小时)", boxmodel.hours];
        self.numberLabel.text = boxmodel.idel_rooms;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:boxmodel.cover] placeholderImage:nil];
        ShopDetailModel *shopmodel = [[ShopDetailModel alloc] init];
        [shopmodel setValuesForKeysWithDictionary:responseObject[@"store"]];
        [self.moreArray addObject:shopmodel];
        [self.myTableView reloadData];
        
        NSLog(@"成功");
    } error:^(NSError *error) {
        NSLog(@"失败");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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


#pragma mark   ---    UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            ChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choose" forIndexPath:indexPath];
            BoxModel *box = self.dataSource.firstObject;
            cell.jiageLabel.text = [NSString stringWithFormat:@"¥%@", box.price];
            cell.shichangjiaLabel.text = [NSString stringWithFormat:@"门市价 ¥%@", box.original_price];
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;
            [cell setMyBlock:^{
                NSLog(@"预定");
                self.hud = [MBProgressHUD showMessag:@"正在预定" toView:nil];

               
                if (!self.beginTime) {
                    self.beginTime = [NSString stringWithFormat:@"%ld", self.time.integerValue *1000];
                }else{
                    self.beginTime = [NSString stringWithFormat:@"%ld", self.beginTime.integerValue];
                }
                if ([self.paytype isEqualToString:@"发现"]) {
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/room", BuyUrl, self.string];
                    NSDictionary *dic = @{@"catid":self.self.model.ids, @"begin_time":self.beginTime};
                    
                    [NewWorkingRequestManage requestPostWith:urlStr parDic:dic finish:^(id responseObject) {
                        NSLog(@"%@", responseObject);
                        [MBProgressHUD showMessage:@"成功" toView:nil];

                        [self.hud hide:YES afterDelay:0];

                        PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
                        payVC.order_no = responseObject[@"order_no"];;
                        [self presentViewController:nav animated:YES completion:nil];

                    } error:^(NSError *error) {
                        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
                        [self.hud hide:YES afterDelay:0];

                    }];
                }else{
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/order",GetPartyLis, self.gameID];
                    NSDictionary *dic = @{@"catid":self.self.model.ids, @"begin_time":self.beginTime};
                    [NewWorkingRequestManage requestPUTWith:urlStr parDic:dic finish:^(id responseObject) {
                        [MBProgressHUD showMessage:@"成功" toView:nil];
                        [self.hud hide:YES afterDelay:0];
                        NSLog(@"成功%@", responseObject);
                        
                        PayViewController *payVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"pay"];
                        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:payVC];
                        payVC.order_no = responseObject[@"order_no"];
                        [self presentViewController:nav animated:YES completion:nil];
                    } error:^(NSError *error) {
                        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
                        [self.hud hide:YES afterDelay:0];

                        NSLog(@"失败%@", error);
                    }];
                }

            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
            break;
        case 1:
        {
            TimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"time" forIndexPath:indexPath];
            BoxModel *box = self.dataSource.firstObject;
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            if (self.beginTime) {
                ;
                [cell.timeBtn setTitle:[self dateText:[self.beginTime doubleValue] / 1000] forState:UIControlStateNormal];
            }else{
                NSString *str = [NSString stringWithFormat:@"%f", [box.nowtime doubleValue] - +28800];
                 [cell.timeBtn setTitle:[HelpManager getDateStringWithDate:str] forState:UIControlStateNormal];
            }
            
            
            [cell setTimeBlock:^(NSDate *date) {
                NSDateFormatter *newData = [[NSDateFormatter alloc] init];
                [newData setDateFormat:@"MM月dd日HH时mm分"];
                self.timeData = date;
               NSTimeInterval time = [self.timeData timeIntervalSince1970];
                self.time = [NSString stringWithFormat:@"%f", time];
                NSString *timeStr = [newData stringFromDate:date];
                [cell.timeBtn setTitle:timeStr forState:UIControlStateNormal];
                
                NSString *times = [NSString stringWithFormat:@"%.f",[date timeIntervalSince1970] *1000 ];

                NSDictionary *dic = @{@"begin_time":times};
                
                NSString *urlStr = [NSString stringWithFormat:@"%@/%@", GetPartyLis, self.gameID];

                [NewWorkingRequestManage requestPUTWith:urlStr parDic:dic finish:^(id responseObject) {
                    NSLog(@"修改成功%@", responseObject);
                } error:^(NSError *error) {
                    NSLog(@"错误信息%@", [NewWorkingRequestManage newWork].errorStr);
                }];
            }];
            return cell;
        }
            break;
        case 2:
        {
            TeaDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            ShopDetailModel *model = self.moreArray[indexPath.row];
            [cell showDataWith:model];
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
                    if (index == tagsArray.count) {
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
        case 3:
        {
            FootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.titleLabel.text = @"套餐详情";
            BoxModel *box = self.dataSource.firstObject;
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            cell.moreLAbel.text = [NSString stringWithFormat:@"%@", box.descriptionss];
            return cell;
        }
            break;
        case 4:
        {
            FootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.titleLabel.text = @"购买须知";
            BoxModel *box = self.dataSource.firstObject;
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            cell.moreLAbel.text = [NSString stringWithFormat:@"%@", box.attention];
            return cell;
        }
            break;
        case 5:
        {
            FootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            cell.titleLabel.text = @"更多信息";
            cell.selectionStyle =     UITableViewCellSelectionStyleNone;

            ShopDetailModel *model = self.moreArray[indexPath.row];
            cell.moreLAbel.text = [NSString stringWithFormat:@"营业时间: %@ -- %@(次日)", model.business_begin, model.business_end];
            return cell;
        }
            break;
            
            
        default:
            return nil;
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSString *)dateText:(double)date {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init]; [formatter setDateFormat:@"MM月dd日HH时mm分"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
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
