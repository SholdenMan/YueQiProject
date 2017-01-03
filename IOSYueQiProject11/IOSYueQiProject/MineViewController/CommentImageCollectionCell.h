//
//  CommentImageCollectionCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentImageCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

- (void)showData:(NSDictionary *)dic;

@end
