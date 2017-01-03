//
//  nearView.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/24.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nearView : UITableViewHeaderFooterView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
