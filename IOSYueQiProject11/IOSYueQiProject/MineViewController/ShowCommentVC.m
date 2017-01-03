//
//  ShowCommentVC.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShowCommentVC.h"

#import "CWStarRateView.h"

#import "ShowCommentCell.h"

#import "ShowCommentImageCell.h"

#import "ShowCommentModel.h"

#import "MJRefresh.h"

#import "ZoomImageViewController.h"

@interface ShowCommentVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *pingCount;
@property (weak, nonatomic) IBOutlet UIView *stareView;

@property (strong, nonatomic) CWStarRateView *starRateView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic , strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;

@property (nonatomic , assign) NSInteger lastId;

@end

@implementation ShowCommentVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self.stareView layoutIfNeeded];
    
    CGRect rect = self.stareView.frame;
    self.starRateView = [[CWStarRateView alloc] initWithFrame:rect numberOfStars:5];
    self.starRateView.scorePercent = 3.5 / 5.;
    self.starRateView.allowIncompleteStar = YES;
    self.starRateView.hasAnimation = YES;
    self.starRateView.userInteractionEnabled = NO;
    [self.headView addSubview:self.starRateView];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    // 借助约束, 进行自适应, 先设置预估值
    self.myTableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;

    [self.myTableView registerNib:[UINib nibWithNibName:@"ShowCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CommentCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"ShowCommentImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ImageCell"];

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.pingCount.text = self.grade;
    [self refresh];
}

- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        self.isFlag = YES;
        self.lastId = 0;
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
    NSString *url = [NSString stringWithFormat:@"%@?size=10&last_id=%ld&store_id=%@", getCommentList, self.lastId, self.teaID];
    [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
        
        NSDictionary *dic = responseObject;
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSLog(@"-----%@", responseObject);
        for (NSDictionary *modelDic in dic[@"items"]) {
            ShowCommentModel *model = [[ShowCommentModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
        ShowCommentModel *model = self.dataSource.lastObject;

        self.lastId = [model.ids integerValue];
        self.isFlag = NO;

    } error:^(NSError *error) {
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:self.view];
        
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
    }];
    
    
    
    
    
    
//    for (NSInteger i = 0; i < 5; i++) {
//        NSDictionary *dic = @{@"nick_name":@"杨立哲",
//                              @"portrait":@"http://static.binvshe.com/static/default/portrait.png",
//                              @"grade":@"3.5",
//                              @"content":@"评论内容",
//                              @"images": @[@{@"url":@"http://static.binvshe.com/static/123/20161104222251102203_120*120.png",
//                                            },
//                                           @{@"url":@"http://static.binvshe.com/static/123/20161104222251102203_120*120.png"}],
//                              @"anonymous":@"1"};
//        ShowCommentModel *model = [[ShowCommentModel alloc] init];
//        [model setValuesForKeysWithDictionary:dic];
//        [self.dataSource addObject:model];
//    }
}


#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowCommentModel *model = self.dataSource[indexPath.row];

    if (!model.images) {
        ShowCommentCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showData:model];
        return cell;

    } else {
        ShowCommentImageCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showData:model];
        NSMutableArray *imgArray = [NSMutableArray array];
        for (NSDictionary *dic in model.images) {
            NSString *pic = dic[@"url"];
            [imgArray addObject:pic];
        }
        [cell setIndexPathBlock:^(NSIndexPath *index) {
            ZoomImageViewController *vc = [[ZoomImageViewController alloc]init];
            [vc addImageArray:imgArray andImageIndex:index.row];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }];
    
        return cell;
    }
   
}


-(void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
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
