//
//  SponsorTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SponsorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (nonatomic, strong)void(^cancleBlock)(UIButton *button);

@end
