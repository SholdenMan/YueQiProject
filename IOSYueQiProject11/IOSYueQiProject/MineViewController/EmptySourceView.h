//
//  EmptySourceView.h
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/29.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptySourceView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *content;



+ (EmptySourceView *)shareEmptySourceView;




@end
