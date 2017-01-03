//
//  StartCollectionViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StartModel;
@interface StartCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *startImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
- (void)showWith:(StartModel *)model;
@end
