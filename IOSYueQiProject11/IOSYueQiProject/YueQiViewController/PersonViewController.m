//
//  PersonViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PersonViewController.h"
#import "InformationTableViewCell.h"
#import "TotalTableViewCell.h"
#import "WorkTableViewCell.h"
#import "OftenTableViewCell.h"
#import "PersonModel.h"
#import "TeaShopModel.h"
#import "ChatViewController.h"

@interface PersonViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *myHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong)PersonModel *model;
@property (nonatomic, strong)NSMutableArray *teaShopArray;
@property (nonatomic, strong)TeaShopModel *teaModel;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.myTableView.estimatedRowHeight = 44.0f;
//    // 告诉系统, 高度自己计算
//    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.teaShopArray = [NSMutableArray array];
    [self.myTableView registerNib:[UINib nibWithNibName:@"InformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"information"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"TotalTableViewCell" bundle:nil] forCellReuseIdentifier:@"total"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"WorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"work"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"OftenTableViewCell" bundle:nil] forCellReuseIdentifier:@"often"];
//    self.myTableView.sectionHeaderHeight = 10;
//    self.myTableView.sectionFooterHeight = 10;
    [self creatDate];
       // Do any additional setup after loading the view.
}
- (void)creatDate{
    self.iconImView.layer.masksToBounds = YES;
    self.iconImView.layer.cornerRadius = 35;
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/detail", UserList, self.userID];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.model = [[PersonModel alloc] init];
        [self.model setValuesForKeysWithDictionary:responseObject];
        self.nameLabel.text = self.model.nick_name;
        self.contentLabel.text = [NSString stringWithFormat:@"账号:%@", self.model.user_id];
        [self.iconImView sd_setImageWithURL:[NSURL URLWithString:self.model.portrait] placeholderImage:nil];
        self.timeLabel.text = self.model.distance_text;
        self.distanceLabel.text = [HelpManager stringFromDateString:self.model.last_coords_time];
        NSLog(@"数组;%@", self.model.stores);
        if ([self.model.firend isEqualToString:@"1"]) {
            [self.myBtn setTitle:@"聊天" forState:UIControlStateNormal];
        }else{
            [self.myBtn setTitle:@"添加好友" forState:UIControlStateNormal];
        }
        for (NSMutableDictionary *dic in self.model.stores) {
            TeaShopModel *teaModel = [[TeaShopModel alloc] init];
            [teaModel setValuesForKeysWithDictionary:dic];
            [self.teaShopArray addObject:teaModel];
        }
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark-----tableview代理方法 UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.teaShopArray.count;
    }else{
        return 1;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        NSString *str = @"常去茶馆";
        return str;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"information" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell showModel:self.model];
            return cell;
        }
            break;
        case 1:{
            TotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"total" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [cell showModel:self.model];
            return cell;
        }
            break;
        case 2:{
                WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"work" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell showMode:self.model];
                return cell;
            }
            break;
        case 3:{
                OftenTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"often" forIndexPath:indexPath];
            TeaShopModel *model = [[TeaShopModel alloc] init];
            model = self.teaShopArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell showModel:model];
                return cell;
            }
            break;
            
        default:{
            return nil;
        }
            break;
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.myHeaderView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 165;
    }else if(section == 3){
        return 30;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 220.0;
    }else if(indexPath.section == 2){
        return 70.0;
    }else{
        return 60;
    }
}
- (IBAction)jubaoAction:(UIButton *)sender {
    [MBProgressHUD showSuccess:@"举报成功" toView:nil];
}
- (IBAction)addAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"聊天"]) {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.model.user_id conversationType:EMConversationTypeChat];
        chatVC.title = [NSString stringWithFormat:@"%@", self.model.nick_name];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
        [self presentViewController:nav animated:YES completion:nil];

    }else if([sender.titleLabel.text isEqualToString:@"添加好友"]){
        SendMessageView *sendView = [SendMessageView sendMessageVie];
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        [sendView setCancleBlock:^{
            NSString *urlStr = [NSString stringWithFormat:@"%@", ToApplyForFriend];
            NSDictionary *pram = @{@"target_id":self.model.user_id, @"reason":sendView.MyTextView.text};
            sender.enabled = NO;
            [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
                [MBProgressHUD showSuccess:@"添加成功" toView:nil];
            } error:^(NSError *error) {
                sender.enabled = YES;
                NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            }];
        }];

    }
}
- (IBAction)juBaoAction:(UIButton *)sender {
    SendMessageView *sendView = [SendMessageView sendMessageVie];
    sendView.chooseLabel.text = @"请填写举报理由";
    [[UIApplication sharedApplication].keyWindow addSubview:sendView];
    [sendView setCancleBlock:^{
        NSDictionary *pram = @{@"type":@"3", @"description":sendView.MyTextView.text, @"version":@"1.0.1"};
        sender.enabled = NO;
        [NewWorkingRequestManage requestPostWith:ReportUrl parDic:pram finish:^(id responseObject) {
            [MBProgressHUD showSuccess:@"举报成功,我们会如实核查." toView:self.view];
        } error:^(NSError *error) {
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
        }];
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
