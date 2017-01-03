//
//  myCollectionViewCell.m
//  CyL
//
//  Created by lanouhn on 16/5/7.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "myCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation myCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.cycleImage];
    }
    return self;
}

- (UIImageView *)cycleImage {
    if (!_cycleImage) {
        self.cycleImage = [[UIImageView alloc]initWithFrame:self.bounds];
        self.cycleImage.backgroundColor = [UIColor cyanColor];
    }
    return _cycleImage;
}

- (void)showData:(NSString *)url {
    [self.cycleImage setImageWithURL:[NSURL URLWithString:url]];
}


@end
