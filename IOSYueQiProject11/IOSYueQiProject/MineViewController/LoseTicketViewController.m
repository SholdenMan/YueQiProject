//
//  LoseTicketViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "LoseTicketViewController.h"
#import "TicketTableViewCell.h"
#import "TicketModel.h"
@interface LoseTicketViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (nonatomic , strong) NSMutableArray *dataSource;
@end

@implementation LoseTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    [self creatDate];

    // Do any additional setup after loading the view.
}

- (void)creatDate{
    [self.myTableView registerNib:[UINib nibWithNibName:@"TicketTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    NSString *urlStr = [NSString stringWithFormat:@"%@page=1&size=50&vaild=0", CouponsUrl];
    [NewWorkingRequestManage requestGetWith:urlStr parDic:nil finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableArray *arr = [NSMutableArray array];
        arr = responseObject[@"items"];
        for (NSDictionary *dic in arr) {
            TicketModel *model = [[TicketModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
                [self.dataSource addObject:model];
        }
        [self.myTableView reloadData];
        
    } error:^(NSError *error) {
        NSLog(@"错误信息%@", error);
    }];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
