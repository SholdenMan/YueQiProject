//
//  myCollectionViewCell.h
//  CyL
//
//  Created by lanouhn on 16/5/7.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *cycleImage;

- (void)showData:(NSString *)url;

@end
