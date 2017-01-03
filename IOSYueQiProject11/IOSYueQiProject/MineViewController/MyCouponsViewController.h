//
//  MyCouponsViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCouponsViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong)NSString *order_no;
@property(nonatomic, copy)void (^myBlock)(NSString *);

@end
