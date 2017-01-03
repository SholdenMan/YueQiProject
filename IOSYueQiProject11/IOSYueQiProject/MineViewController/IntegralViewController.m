//
//  IntegralViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "IntegralViewController.h"
#import "MJRefresh.h"
#import "IntegralTableViewCell.h"
#import "IntegralModel.h"
@interface IntegralViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (weak, nonatomic) IBOutlet UIButton *ruleBtn;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@property (weak, nonatomic) IBOutlet UILabel *allLabel;


@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;


@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;



@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, assign)BOOL isFlag;
@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSString *selectStr;


/**
 *  判断按钮是否为选中状态
 */
//@property(nonatomic,assign) BOOL IsSelectedButton;
/**
 *  用来记录被选中的按钮
 */
//@property(nonatomic,strong)UIButton *selectedButton;
/**
 *  用来记录上一次点击的按钮
 */
//@property(nonatomic,strong)UIButton *clickButton;
@end

@implementation IntegralViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.integralLabel.text = self.source;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.page = 1;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"IntegralTableViewCell" bundle:nil] forCellReuseIdentifier:@"integral"];
    [self creatBtn:self.allBtn WithLab:self.allLabel];

    self.selectStr = @"全部";
    [self refresh];
    // Do any additional setup after loading the view.
}


- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        self.isFlag = YES;
        self.page = 1;
        [self creatDataWith:self.selectStr];
    }];
    
    [header beginRefreshing];
    
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatDataWith:)];
    self.myTableView.mj_footer = footer;
}
- (void)back {
    [self dismissViewControllerAnimated: YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)allAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:self.allLabel];
    self.selectStr = @"全部";
    [self refresh];

}

- (IBAction)incomeAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:self.incomeLabel];
    self.selectStr = @"收入";
    [self refresh];

}

- (IBAction)payforAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:self.payLabel];
    self.selectStr = @"支出";
    [self refresh];

}



- (void)creatBtn:(UIButton *)sender WithLab:(UILabel *)labsender {
    [self.allBtn setTitleColor:Color(185, 185, 185) forState:UIControlStateNormal];
    self.allLabel.backgroundColor = [UIColor clearColor];
    
    [self.incomeBtn setTitleColor:Color(185, 185, 185) forState:UIControlStateNormal];
    self.incomeLabel.backgroundColor = [UIColor clearColor];
    
    [self.payBtn setTitleColor:Color(185, 185, 185) forState:UIControlStateNormal];
    self.payLabel.backgroundColor = [UIColor clearColor];
    
    [sender setTitleColor:Color(0, 177, 180) forState:UIControlStateNormal];
    labsender.backgroundColor = Color(0, 177, 180);
}



- (void)creatDataWith:(NSString *)type{
    type = self.selectStr;
    NSString *urlStr = [NSString string];
    if ([type isEqualToString:@"全部"]) {
    urlStr = [NSString stringWithFormat:@"%@page=%ld&size=10",MyIntegralUrl, self.page];
    }else if([type isEqualToString:@"支出"]){
        urlStr = [NSString stringWithFormat:@"%@page=%ld&size=10&type=0",MyIntegralUrl, self.page];
    }else{
        urlStr = [NSString stringWithFormat:@"%@page=%ld&size=10&type=1",MyIntegralUrl, self.page];
    }
   [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
       NSLog( @"%@", responseObject);
       if (self.isFlag) {
           [self.dataSource removeAllObjects];
       }
       
       NSArray *array = responseObject[@"items"];
       for (NSDictionary *modelDic in array) {
           IntegralModel *model = [[IntegralModel alloc] init];
           [model setValuesForKeysWithDictionary:modelDic];
           [self.dataSource addObject:model];
       }
       // 刷新表格
       [self.myTableView reloadData];
       [self.myTableView.mj_header endRefreshing];
       [self.myTableView.mj_footer endRefreshing];
       self.page += 1;
       self.isFlag = NO;

    } error:^(NSError *error) {
        NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];

    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataSource.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"integral" forIndexPath:indexPath];
    IntegralModel *model = self.dataSource[indexPath.row];
//    cell.payBtn.layer.masksToBounds = YES;
//    cell.payBtn.layer.borderWidth = 1;
//    cell.payBtn.layer.borderColor =  Color(100,100,100).CGColor;
    [cell.payBtn setTitle:model.remark forState:UIControlStateNormal];
    cell.timeLabel.text = [HelpManager getDateStringWithDate:model.create_time];
    cell.nameLabel.text = model.name;
    cell.integralLabel.text = model.score;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
