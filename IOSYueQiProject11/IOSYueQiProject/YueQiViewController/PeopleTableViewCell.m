//
//  PeopleTableViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/8.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PeopleTableViewCell.h"
#import "PersonCollectionViewCell.h"
#import "PartyListModel.h"
#import "PartyPersonModel.h"

@interface PeopleTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic , assign) NSInteger count;
@end


@implementation PeopleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.personView registerNib:[UINib nibWithNibName:@"PersonCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    self.personView.delegate = self;
    self.personView.dataSource = self;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(61, 90);
    layOut.minimumInteritemSpacing = 1;
    layOut.minimumLineSpacing = 1;
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.personView.collectionViewLayout = layOut;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.model.join isEqualToString:@"1"]) {
        if ([self.model.owned isEqualToString:@"1"]) {
            cell.deleBtn.hidden = NO;
        }else{
            cell.deleBtn.hidden = YES;
        }
    }else{
        cell.deleBtn.hidden = YES;
    }
    cell.ownModel = self.model;
    [cell showDataDetail:self.dataSource[indexPath.row] with:@"detail"];
    
    [cell setMyBlock:^(PartyPersonModel *model) {
        NSLog(@"踢人了");
        ShowAlertView  *sendMessage = [ShowAlertView showAlertView];
        sendMessage.contentLabel.text = @"是否将他踢出?";
        [sendMessage setConfirmBlock:^{
            NSString *urlStr = [NSString stringWithFormat:@"%@%@/members/%@", KickOutUrl, cell.ownModel.ids, model.user_id];
            [NewWorkingRequestManage requestDELETEWith:urlStr parDic:nil finish:^(id responseObject) {
                NSLog(@"成功%@", responseObject);
                [MBProgressHUD showMessage:@"删除成功" toView:nil];
                [self.personView reloadData];
            } error:^(NSError *error) {
                NSLog(@"错误信息%@", [NewWorkingRequestManage newWork].errorStr);
                [MBProgressHUD showMessage:[NewWorkingRequestManage newWork].errorStr toView:nil];
            }];
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:sendMessage];
    }];
    return cell;
}
- (void)showData:(PartyListModel *)model {
    self.model = model;
       self.count = model.members.count;
    self.dataSource = [NSMutableArray arrayWithArray:model.members];
    self.teaID = model.ids;
    if (model.members.count < 4) {
        for (NSInteger i = 0; i < 4 - self.count; i++) {
            PartyPersonModel *model = [[PartyPersonModel alloc] init];
            model.user_id = @"";
            model.nick_name = @"";
            model.gender = @"";
            model.portrait = @"http://static.binvshe.com/static/party/icon-plus.png";
            model.role = @"";
            [self.dataSource addObject:model];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.count - 1) {
        NSLog(@"点击邀请");
        if (self.inviteBlock) {
            self.inviteBlock(_teaID);
        }else{
            [MBProgressHUD showMessage:@"请先加入" toView:nil];
        }
        return;
    }
    PartyPersonModel *model = self.dataSource[indexPath.row];
    if (self.myBlock) {
        self.myBlock(model);
    }
    
}


@end
