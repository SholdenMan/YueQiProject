//
//  StartViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/11/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartyListModel;
@class PartyPersonModel;
@interface StartViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong)PartyListModel *model;
@property (nonatomic , copy) void(^myBlock)(PartyPersonModel *model);

@end
