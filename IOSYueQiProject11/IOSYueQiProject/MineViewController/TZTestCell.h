//
//  TZTestCell.h
//  TZImagePickerController
//
//  Created by 谭真 on 16/1/3.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TZTestCell;
@protocol MessagePhotoItemDelegate <NSObject>

- (void)messagePhotoItemView:(TZTestCell *)messagePhotoItemView
didSelectDeleteButtonAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TZTestCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSIndexPath *indexPath;


@property (nonatomic, strong) UIButton *btnDelete;

@property(nonatomic,weak)id<MessagePhotoItemDelegate>delegate;
@end

