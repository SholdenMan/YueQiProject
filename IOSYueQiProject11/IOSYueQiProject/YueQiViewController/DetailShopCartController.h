//
//  DetailShopCartController.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailShopCartController : BaseViewController

@property (nonatomic , strong) NSMutableArray *dataSource;


///约局id
@property (nonatomic , copy) NSString *game_id;

@end
