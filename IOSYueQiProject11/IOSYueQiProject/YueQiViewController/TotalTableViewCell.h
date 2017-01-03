//
//  TotalTableViewCell.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/2.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPieChartView.h"
#import "PersonModel.h"


@interface TotalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *cancelLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (nonatomic, strong) HKPieChartView *pieChartView;

- (void)showModel:(PersonModel*)model;
@end
