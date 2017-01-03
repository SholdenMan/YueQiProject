//
//  MyInfoViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : BaseViewController
@property (nonatomic, strong)LgAccount *myModel;
@property (nonatomic, strong)NSString *province;
@property (nonatomic, strong)NSString *district;
@property (nonatomic, strong)NSString *city;

@end
