//
//  TZTestCell.m
//  TZImagePickerController
//
//  Created by 谭真 on 16/1/3.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import "TZTestCell.h"

@implementation TZTestCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
        self.clipsToBounds = YES;
        
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.frame = CGRectMake(self.frame.size.width - 30, 0, 30, 30);
        // btnDelete.backgroundColor = [UIColor redColor];
        [_btnDelete setImage:[UIImage imageNamed:@"fbhd_sc"] forState:UIControlStateNormal];
       // btnDelete.tag = self.index;
        [_btnDelete addTarget:self
                      action:@selector(deletePhotoItem:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDelete];

    }
    return self;
}

/*
 删除图片
 */
-(void)deletePhotoItem:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(messagePhotoItemView:didSelectDeleteButtonAtIndexPath:)]){
        [self.delegate messagePhotoItemView:self
               didSelectDeleteButtonAtIndexPath:_indexPath];
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        _btnDelete.hidden = YES;
    }
    else
        _btnDelete.hidden = NO;
    
    _indexPath = indexPath;
}
- (void)layoutSubviews {
    [super layoutSubviews];

    _imageView.frame = self.bounds;
}

@end
