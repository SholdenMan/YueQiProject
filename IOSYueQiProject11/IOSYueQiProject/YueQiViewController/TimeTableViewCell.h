//
//  TimeTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (nonatomic, copy)void(^timeBlock)(NSDate *);

@end
