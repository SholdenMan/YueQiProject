//
//  ListTeaViewController.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeaListModel.h"
#import "NIDropDown.h"


@interface ListTeaViewController : BaseViewController <NIDropDownDelegate>


{
    IBOutlet UIButton *quanchengBtn;
    IBOutlet UIButton *distanceBtn;
    NIDropDown *dropDowns;
    NIDropDown *dropDown;
}



@property (retain, nonatomic) IBOutlet UIButton *quanchengBtn;
@property (retain, nonatomic) IBOutlet UIButton *distanceBtn;
@property (nonatomic, strong)void(^modelBlock)(TeaListModel *);
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *nowShop;
@property (nonatomic, strong)NSString *paytype;
@property (nonatomic, strong)NSString *gameID;
@property (nonatomic, strong)NSString *beginTime;
- (IBAction)allAction:(UIButton *)sender;
- (IBAction)distanceAction:(UIButton *)sender;
@end
