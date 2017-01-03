//
//  PersonCollectionViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/11/1.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PersonCollectionViewCell.h"
#import "UIImageView+EMWebCache.h"
#import "PartyListModel.h"

@implementation PersonCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

/**
 *  
    "user_id": 100560,
    "nick_name": "杨立哲",
    "gender": 1,
    "portrait": "http://static.binvshe.com/static/default/portrait.png",
    "role": 2
 */
- (void)showData:(PartyPersonModel *)model with:(NSString *)type {
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
    self.payLabel.hidden = YES;
    self.model = model;
        if ([type isEqualToString:@"detail"]) {
            if ([self.model.nick_name isEqualToString:@""]) {
                self.deleBtn.hidden =YES;
                self.hatView.hidden = YES;
            }else{
//                if ([self.ownModel.join isEqualToString:@"1"]) {
                    //                self.deleBtn.hidden = NO;
                    if ([model.role isEqualToString:@"2"]) {
                        self.hatView.hidden = NO;
                        self.deleBtn.hidden = YES;
                    }
                    else {
                        self.hatView.hidden = YES;
//                        self.deleBtn.hidden = NO;
                    }
//                }else{
//                    //没有加入
//                    self.deleBtn.hidden = YES;
//                    if ([model.role isEqualToString:@"2"]) {
//                        self.hatView.hidden = NO;
//                    } else{
//                        self.hatView.hidden = YES;
//                    }
//                }

            }
                    }else if([type isEqualToString:@"home"]){
            self.deleBtn.hidden = YES;
            if ([model.role isEqualToString:@"2"]) {
                self.hatView.hidden = NO;
            } else{
                self.hatView.hidden = YES;
            }
        }
    self.headView.layer.cornerRadius = 23;
    self.headView.layer.masksToBounds = YES;
    
    if ([model.gender isEqualToString:@"1"]) {
        self.genderView.image = [UIImage imageNamed:@"icon-boyyy-1"];
        self.genderView.hidden = NO;

    } else if ([model.gender isEqualToString:@"0"]) {
        self.genderView.image = [UIImage imageNamed:@"icon-girlyy-1"];
        self.genderView.hidden = NO;
    } else {
        self.genderView.hidden = YES;
    }
    self.nameLabel.text = model.nick_name;
}

- (void)showDataDetail:(PartyPersonModel *)model with:(NSString *)type {
    [self.headView sd_setImageWithURL:[NSURL URLWithString:model.portrait]];
    
    self.model = model;
    if ([type isEqualToString:@"detail"]) {
        if ([self.model.nick_name isEqualToString:@""]) {
            self.deleBtn.hidden =YES;
            self.hatView.hidden = YES;
        }else{
            //                if ([self.ownModel.join isEqualToString:@"1"]) {
            //                self.deleBtn.hidden = NO;
            if ([model.role isEqualToString:@"2"]) {
                self.hatView.hidden = NO;
                self.deleBtn.hidden = YES;
            }
            else {
                self.hatView.hidden = YES;
                //                        self.deleBtn.hidden = NO;
            }
        }
    }else if([type isEqualToString:@"home"]){
        self.deleBtn.hidden = YES;
        if ([model.role isEqualToString:@"2"]) {
            self.hatView.hidden = NO;
        } else{
            self.hatView.hidden = YES;
        }
    }
    if ([model.pay isEqualToString:@"1"]) {
        self.payLabel.hidden = NO;
    }else{
        self.payLabel.hidden = YES;
    }
    self.headView.layer.cornerRadius = 23;
    self.headView.layer.masksToBounds = YES;
    
    if ([model.gender isEqualToString:@"1"]) {
        self.genderView.image = [UIImage imageNamed:@"icon-boyyy-1"];
        self.genderView.hidden = NO;
        
    } else if ([model.gender isEqualToString:@"0"]) {
        self.genderView.image = [UIImage imageNamed:@"icon-girlyy-1"];
        self.genderView.hidden = NO;
    } else {
        self.genderView.hidden = YES;
    }
    self.nameLabel.text = model.nick_name;
}







- (IBAction)deleAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(self.model);
    }
}


@end
