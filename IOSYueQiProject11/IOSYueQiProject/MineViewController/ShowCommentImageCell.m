//
//  ShowCommentImageCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ShowCommentImageCell.h"
#import "CommentImageCollectionCell.h"
#import "ShowCommentModel.h"

@implementation ShowCommentImageCell

- (void)awakeFromNib {
    // Initialization code
    
    
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"CommentImageCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CommentImage"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    
    
    layOut.itemSize = CGSizeMake((TheW -  46) / 3, 66);
    layOut.minimumInteritemSpacing = 2;
    
    layOut.minimumLineSpacing = 5;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCollectionView.collectionViewLayout = layOut;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void) showData:(ShowCommentModel *)model {
    self.iconImage.layer.cornerRadius = 23;
    self.iconImage.layer.masksToBounds = YES;

    [self.stareView show:5];
    self.stareView.scorePercent = [model.grade floatValue] / 5.;
    self.stareView.allowIncompleteStar = YES;
    self.stareView.hasAnimation = YES;
    self.stareView.userInteractionEnabled = NO;
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.nick_name;
    self.pingCount.text = model.grade;
    self.contentLabel.text = model.content;
    self.dataSource = model.images;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommentImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentImage" forIndexPath:indexPath];
    NSDictionary *dic = self.dataSource[indexPath.row];
    [cell showData:dic];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.indexPathBlock) {
        self.indexPathBlock(indexPath);
    }
}





@end
