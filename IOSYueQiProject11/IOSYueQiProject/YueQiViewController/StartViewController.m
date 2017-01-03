//
//  StartViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "StartViewController.h"
#import "ListTwoTableViewCell.h"
#import "PersonCollectionViewCell.h"
#import "ChatViewController.h"
#import "PartyListModel.h"
#import "TeaListModel.h"
#import "PartyPersonModel.h"
#import "SendMessageView.h"
#import "ShoppingCartController.h"
#import "OrderViewController.h"
#import "BoxRenewalVC.h"
#import "CountDownButton.h"
@interface StartViewController ()
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet CountDownButton *timeBtnss;

@property (nonatomic, assign)NSInteger count;
@end

@implementation StartViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeBtnss.imageName = @"icon-timeyyyy";
    NSLog(@"%@", NSStringFromCGRect(self.timeBtnss.frame));

//    [self.view layoutIfNeeded];
    [self.timeBtnss show];
    CGFloat time = [self.model.end_time floatValue] / 1000;
    [self.timeBtnss showTime:time];
    
    self.timeBtnss.titleLabel.textColor = [UIColor redColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.dataArray = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    self.dataSource = [NSMutableArray arrayWithArray:self.model.members];
    self.count = self.dataSource.count;
    if (self.count < 4) {
        for (NSInteger i = 0; i < 4 - self.count; i++) {
            PartyPersonModel *model = [[PartyPersonModel alloc] init];
            model.user_id = @"";
            model.nick_name = @"";
            model.gender = @"";
            model.portrait = @"http://static.binvshe.com/static/party/default_avatar.png";
            model.role = @"";
            [self.dataSource addObject:model];
        }
    }
//    for (PartyPersonModel *model in self.dataSource) {
//        [self.numberArray addObject:model];
//    }

    [self creatData];
    // Do any additional setup after loading the view.
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)creatData{
//    if ([self.model.state isEqualToString:@"3"]) {
//        self.title = @"进行中";
//    }else{
        self.title = @"等待开始";
//    }
    [self.myTableView registerNib:[UINib nibWithNibName:@"ListTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"listTwo"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"PersonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(61, 90);
    layOut.minimumInteritemSpacing = 1;
    layOut.minimumLineSpacing = 1;
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCollectionView.collectionViewLayout = layOut;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-messageyyyy"] style:UIBarButtonItemStylePlain target:self action:@selector(chart)];
    
    NSString *jindu = [userDef objectForKey:@"longitude"];
    NSString *weidu = [userDef objectForKey:@"latitude"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?longitude=%@&latitude=%@", ShopDetailUrl, self.model.store_id, jindu, weidu];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        TeaListModel *model = [[TeaListModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        [self.dataArray addObject:model];
        self.numLabel.text = responseObject[@"room_info"];
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)chart{
    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:self.model.im_group_id conversationType:EMConversationTypeGroupChat];
    chatVC.title = [NSString stringWithFormat:@"聊天室"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)eatingAction:(UIButton *)sender {
    UINavigationController *nav = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"shopping"];
    ShoppingCartController *shopVC = (ShoppingCartController *)nav.topViewController;
    shopVC.storeId = self.model.store_id;
    shopVC.game_id = self.model.ids;
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)waterAction:(id)sender {
    ShowAlertView  *sendMessage = [ShowAlertView showAlertView];
    sendMessage.contentLabel.text = @"是否需要添茶水";
    [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
    [sendMessage  setConfirmBlock:^{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@/server/tea", CallteaUrl, self.model.ids];
        [NewWorkingRequestManage requestPostWith:urlStr parDic:nil finish:^(id responseObject) {
            [MBProgressHUD showMessage:@"呼叫成功" toView:self.view];

        } error:^(NSError *error) {
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        }];
    }];
}
- (IBAction)serveAction:(id)sender {
    ShowAlertView  *sendMessage = [ShowAlertView showAlertView];
    //http://17178.xmappservice.com/v1.0/app/games/355/server/tea
    sendMessage.contentLabel.text  = @"是否呼叫服务";
    [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
    [sendMessage  setConfirmBlock:^{
        
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/server/other", CallteaUrl, self.model.ids];
            [NewWorkingRequestManage requestPostWith:urlStr parDic:nil finish:^(id responseObject) {
                [MBProgressHUD showMessage:@"呼叫成功" toView:self.view];
                
            } error:^(NSError *error) {
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            }];

    }];
    
}
- (IBAction)payAction:(id)sender {
    ShowAlertView  *sendMessage = [ShowAlertView showAlertView];
    sendMessage.contentLabel.text  = @"是否付费";
    
    [sendMessage setConfirmBlock:^{
        BoxRenewalVC *boxRenewalVC = [[BoxRenewalVC alloc] init];
        boxRenewalVC.title = @"包厢续费";
        boxRenewalVC.game_id = self.model.ids;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:boxRenewalVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
}


#pragma mark ---  UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果
    cell.chooseBtn.hidden  = YES;
    cell.newdisLabel.hidden = YES;
    cell.distanceLabel.hidden = YES;
    TeaListModel *model  = self.dataArray.firstObject;
    [cell showDataWith:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeaListModel *model  = self.dataArray.firstObject;
    OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"order"];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:orderVC];
    orderVC.model = model;
    [self presentViewController:orderVC animated:NO completion:nil];
}

#pragma mark --- UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    PartyPersonModel *model = self.dataSource[indexPath.row];
    NSLog(@"11111%@",model.portrait);
    [cell showData:model with:@"home"];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.count - 1) {
        return;
    }
       PartyPersonModel *model = self.dataSource[indexPath.row];
    if (self.myBlock) {
        self.myBlock(model);
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
