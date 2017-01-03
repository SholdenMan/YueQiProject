//
//  InviteFriendViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LaunchModel;

@interface InviteFriendViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *myTextFiled;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic, strong)LaunchModel *model;
@property (nonatomic, strong)NSString *teaID;


@end
