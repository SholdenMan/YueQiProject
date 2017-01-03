//
//  CommentImageCollectionCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "CommentImageCollectionCell.h"

@implementation CommentImageCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)showData:(NSDictionary *)dic {
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]] placeholderImage:[UIImage imageNamed:@""]];
}
@end
