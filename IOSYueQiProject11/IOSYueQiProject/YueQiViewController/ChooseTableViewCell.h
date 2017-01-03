//
//  ChooseTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jiageLabel;
@property (weak, nonatomic) IBOutlet UILabel *shichangjiaLabel;
@property (nonatomic, copy)void (^myBlock)();

@end
