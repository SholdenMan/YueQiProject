//
//  MessageClassTableViewCell.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)showData:(NSDictionary *)dic;
@end
