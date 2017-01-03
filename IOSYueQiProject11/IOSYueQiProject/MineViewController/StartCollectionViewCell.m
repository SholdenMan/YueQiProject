//
//  StartCollectionViewCell.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "StartCollectionViewCell.h"
#import "StartModel.h"
@implementation StartCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWith:(StartModel *)model{
    if (model.isLight) {
        self.startImage.image = [UIImage imageNamed:@"icon-zunyy-p"];
    }else{
        self.startImage.image = [UIImage imageNamed:@"icon-zunyy-n"];
    }
    self.contentLabel.text = model.content;
}
@end
