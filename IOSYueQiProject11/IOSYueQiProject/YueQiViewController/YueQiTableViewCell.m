//
//  YueQiTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "YueQiTableViewCell.h"
#import "PersonCollectionViewCell.h"
#import "PartyListModel.h"
#import "PartyPersonModel.h"

@interface YueQiTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic , assign) NSInteger count;
@property (nonatomic, strong)NSMutableArray *numberDataSource;
@end

@implementation YueQiTableViewCell

- (void)awakeFromNib {

    [self.personView registerNib:[UINib nibWithNibName:@"PersonCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.personView.delegate = self;
    self.personView.dataSource = self;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(61, 90);
    layOut.minimumInteritemSpacing = 1;
    layOut.minimumLineSpacing = 1;
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.personView.collectionViewLayout = layOut;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PartyListModel *)model {
    self.titleLabel.text = model.subject;
    self.dateLongLabel.text = [NSString stringWithFormat:@"%@小时", model.hours];
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@", model.street, model.distance_text];
     self.startDateLabel.text = [self dateText:[model.begin_time doubleValue] / 1000];
    self.count = model.members.count;
    self.dataSource = [NSMutableArray arrayWithArray:model.members];
    self.numberDataSource = [NSMutableArray array];
    for (PartyPersonModel *amodel in self.dataSource) {
    [self.numberDataSource addObject:amodel.user_id];
    }
    if (self.numberDataSource) {
        if ([self.numberDataSource containsObject:[userDef objectForKey:@"userID"]]) {
            self.myBtn.hidden = NO;
        }else{
            self.myBtn.hidden = YES;
        }
    }
        if ([model.pay_type isEqualToString:@"0"]) {
        self.typelabel.text = @"AA制";
        self.typelabel.backgroundColor = Color(90, 216, 218);
    } else {
        self.typelabel.backgroundColor = Color(249, 113, 117);
        self.typelabel.text = @"我请客";
    }
    
    
    if ([model.state isEqualToString:@"0"]) {
        self.stateLabel.text = @"等待加入";
    }
    
    if ([model.state isEqualToString:@"1"]) {
        self.stateLabel.text = @"选择茶馆";
    }
    
    if ([model.state isEqualToString:@"2"]) {
        self.stateLabel.text = @"等待支付";
    }
    
    if ([model.state isEqualToString:@"3"]) {
        self.stateLabel.text = @"等待开始";
    }
    
    if ([model.state isEqualToString:@"4"]) {
        self.stateLabel.text = @"进行中";
    }
    if ([model.state isEqualToString:@"5"]) {
        self.stateLabel.text = @"结束";
    }

    if (model.members.count < 4) {
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
    [self.personView reloadData];
    
    
}

- (NSString *)dateText:(double)date {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init]; [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

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
- (IBAction)jubaoAction:(UIButton *)sender {
    SendMessageView *sendView = [SendMessageView sendMessageVie];
    sendView.chooseLabel.text = @"请填写举报理由";
    [[UIApplication sharedApplication].keyWindow addSubview:sendView];
    [sendView setCancleBlock:^{
        NSDictionary *pram = @{@"type":@"3", @"description":sendView.MyTextView.text, @"version":@"1.0.1"};
        sender.enabled = NO;
        [NewWorkingRequestManage requestPostWith:ReportUrl parDic:pram finish:^(id responseObject) {
            [MBProgressHUD showSuccess:@"举报成功,我们会如实核查." toView:self];
        } error:^(NSError *error) {
            [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
            NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
        }];
    }];

}










@end
