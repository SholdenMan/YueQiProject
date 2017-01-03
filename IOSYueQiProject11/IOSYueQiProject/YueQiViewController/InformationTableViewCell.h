//
//  InformationTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonModel;
@interface InformationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *relationLabel;
- (void)showModel:(PersonModel *)model;
@end
