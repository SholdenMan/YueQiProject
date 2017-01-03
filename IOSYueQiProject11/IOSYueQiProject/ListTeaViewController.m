//
//  ListTeaViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ListTeaViewController.h"
//#import "ListTeaTableViewCell.h"
#import "ListTwoTableViewCell.h"
#import "CWStarRateView.h"
#import "TeaDetailModel.h"
#import "OrderViewController.h"
#import "MJRefresh.h"

#import "EmptySourceView.h"

@interface ListTeaViewController ()<UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) CWStarRateView *starRateView;
@property (nonatomic, strong)NSMutableArray *dateArray;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, assign)BOOL isFlag;
@property (nonatomic, strong)NSString *urlStr;
@end

@implementation ListTeaViewController
@synthesize quanchengBtn, distanceBtn;



- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        self.isFlag = YES;
        self.page = 1;
        [self getdata:nil];
    }];
    [header beginRefreshing];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(getdata:)];
    self.myTableView.mj_footer = footer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.dateArray = [NSMutableArray array];
    [self creatData];
    [self refresh];
}
- (void)viewDidUnload {
    //    [btnSelect release];
    distanceBtn = nil;
    quanchengBtn = nil;
    [self setDistanceBtn:nil];
    [self setQuanchengBtn:nil];
    [super viewDidUnload];
}
     
- (void)creatData{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    UINib *cellNib = [UINib nibWithNibName:@"ListTwoTableViewCell" bundle:nil];
    [self.myTableView registerNib:cellNib forCellReuseIdentifier:@"listTwo"];
    
    }
- (void)getdata:(NSDictionary *)condition{
    NSString *jindu = [userDef objectForKey:@"longitude"];
    NSString *weidu = [userDef objectForKey:@"latitude"];
    NSString *newStr = [NSString string];
    if (self.urlStr) {
        newStr = [self.urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    }else{
        NSString *urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=%ld&longitude=%@&latitude=%@", TeaListUrl,self.page, jindu, weidu];
        newStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        
    }
    [NewWorkingRequestManage requestGetWith:newStr parDic:condition finish:^(id responseObject) {
        if (self.isFlag) {
            [self.dateArray removeAllObjects];
        }
        NSArray *arr = responseObject[@"items"];
        for (NSDictionary *dic in arr) {
            TeaListModel *model = [[TeaListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dateArray addObject:model];
        }
        // 刷新表格
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        self.page += 1;
        self.isFlag = NO;
        
        [self checkData];
        
    } error:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
    
}


- (void)checkData
{
    if (self.dateArray.count == 0) {
        EmptySourceView *empty = [EmptySourceView shareEmptySourceView];
        self.myTableView.tableFooterView = empty;
    }else{
        self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
}



- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

     
- (IBAction)allAction:(UIButton *)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"全部", @"集美区", @"海沧区", @"湖里区", @"同安区", @"翔安区",nil];
    if(dropDowns == nil) {
        
        [dropDown hideDropDown:self.distanceBtn];
        [self rel];
        
        CGFloat f = arr.count * 40;
        dropDowns = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDowns.delegate = self;
    }
    else {
        [dropDowns hideDropDown:sender];
        [self rels];


    }
}


- (IBAction)distanceAction:(UIButton *)sender {
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"距离优先", @"好评优先",nil];
    if(dropDown == nil) {
        [dropDowns hideDropDown:self.quanchengBtn];
        [self rels];
        
        CGFloat f = arr.count * 40;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

-(void)rels{
    //    [dropDown release];
    NSLog(@"-----%@, %@", distanceBtn.titleLabel.text, quanchengBtn.titleLabel.text);
    dropDowns = nil;
}

-(void)rel{
    //    [dropDown release];
    NSLog(@"-----%@, %@", distanceBtn.titleLabel.text, quanchengBtn.titleLabel.text);
    dropDown = nil;
}
- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    
    if (sender == dropDown) {
        [self rel];
        [self creaEE];
    } else {
        [self rels];
        [self creaEE];

    }
}

- (void)creaEE {
    //    [dropDown release];
    NSString *jindu = [userDef objectForKey:@"longitude"];
    NSString *weidu = [userDef objectForKey:@"latitude"];
    self.isFlag = YES;
    self.page = 1;
    
    if ([quanchengBtn.titleLabel.text isEqualToString:@"全部"]) {
        
        if ([distanceBtn.titleLabel.text isEqualToString:@"距离优先"]) {
            self.urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=%ld&longitude=%@&latitude=%@&orderby=grade desc", TeaListUrl,(long)self.page, jindu, weidu];
            
        }else{
            self.urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=%ld&longitude=%@&latitude=%@&orderby=distance asc", TeaListUrl,self.page, jindu, weidu];
        }
    }else{
        if ([distanceBtn.titleLabel.text isEqualToString:@"距离优先"]) {
            self.urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=%ld&longitude=%@&latitude=%@&orderby=grade desc&district=%@", TeaListUrl,self.page, jindu, weidu, quanchengBtn.titleLabel.text];
            
        }else{
            self.urlStr = [NSString stringWithFormat:@"%@city=厦门&size=20&page=%ld&longitude=%@&latitude=%@&orderby=distance asc&district=%@", TeaListUrl,self.page, jindu, weidu, quanchengBtn.titleLabel.text];
        }
        
    }
    [self getdata:nil];
    
    
    NSLog(@"-----%@, %@", distanceBtn.titleLabel.text, quanchengBtn.titleLabel.text);
    
    dropDown = nil;
}

#pragma mark ----UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArray.count;
//    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listTwo" forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//设置cell点击效果

    TeaListModel *model = self.dateArray[indexPath.row];
    
    [cell showDataWith:model];
    if ([self.type isEqualToString:@"暂定"]) {
        if ([model.teaID isEqualToString:self.nowShop]) {
            cell.chooseBtn.hidden = NO;
            cell.chooseBtn.userInteractionEnabled = NO;
        }else{
        cell.chooseBtn.hidden = YES;
            cell.chooseBtn.userInteractionEnabled = YES;

        }
    }else{
        cell.chooseBtn.hidden = NO;
        cell.chooseBtn.userInteractionEnabled = YES;

    }
    [cell setChooseBlock:^(UIButton *sender) {
      TeaListModel *model = [self getModelWith:sender];
        self.modelBlock(model);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    return cell;
}
- (TeaListModel*)getModelWith:(UIButton *)sender {
    ListTwoTableViewCell *cell = (ListTwoTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    TeaListModel *model = self.dateArray[path.row];
    return model;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.type isEqualToString:@"暂定"]) {
        TeaListModel *model = self.dateArray[indexPath.row];
        OrderViewController *orderVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"order"];
        orderVC.model = model;
        orderVC.paytype = self.paytype;
        orderVC.gameID = self.gameID;
        orderVC.beginTime = self.beginTime;
        [self presentViewController:orderVC animated:NO completion:nil];

    }else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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
