//
//  MessageSingleCell.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/10/10.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MessageSingleCell.h"
#import "UserFMDBHelper.h"
#import "OtherModel.h"

@implementation MessageSingleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(EMConversation *)conversaion {
    if ([conversaion unreadMessagesCount] == 0) {
        _countLabel.hidden = YES;
    } else {
        _countLabel.hidden = NO;
    }
    if ([conversaion unreadMessagesCount] >= 100) {
        _countLabel.text = @"99+";
    } else {
        _countLabel.text = [NSString stringWithFormat:@"%d",[conversaion unreadMessagesCount]];

    }
    _countLabel.layer.cornerRadius = 10;
    _countLabel.layer.masksToBounds = YES;
    
    
    self.iconImage.layer.cornerRadius = 23;
    self.iconImage.layer.masksToBounds = YES;
    
    switch (conversaion.type) {
        case 0:
        {
            if (conversaion.lastReceivedMessage.ext[@"nickname"]) {
                _nameLabel.text = conversaion.lastReceivedMessage.ext[@"nickname"];
                [_iconImage sd_setImageWithURL:[NSURL URLWithString:conversaion.lastReceivedMessage.ext[@"avatarURLPath"]]];
            } else {
                NSMutableArray *array = [[UserFMDBHelper shareFMDBHelper] searchMessageModelWith:conversaion.latestMessage.to];
                NSString *str = conversaion.latestMessage.to;
                OtherModel *model = [array firstObject];
                _nameLabel.text = model.othername;
                [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
            }
        }
            break;
        case 1:
        {
            NSMutableArray *array = [[UserFMDBHelper shareFMDBHelper] searchMessageModelWith:conversaion.latestMessage.to];
            OtherModel *model = [array firstObject];
            _nameLabel.text = model.othername;
            [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
         
        }
            break;
            
        default:
            break;
    }
    
    
    if (conversaion.latestMessage) {
        _dateLabel.hidden = NO;
        _dateLabel.text = [HelpManager getDate:[NSString stringWithFormat:@"%lld", conversaion.latestMessage.timestamp]];
    }else {
        _dateLabel.hidden = YES;
    }

    // 获取消息体
    id body = conversaion.latestMessage.body;
    
    if ([body isKindOfClass:[EMTextMessageBody class]]) {
        EMTextMessageBody *textBody = body;
        _contentLabel.text = textBody.text;
    }else if ([body isKindOfClass:[EMVoiceMessageBody class]]){
        _contentLabel.text = @"[语音]";
    }else if([body isKindOfClass:[EMImageMessageBody class]]){
        _contentLabel.text = @"[图片]";
    }else if([body isKindOfClass:[EMLocationMessageBody class]]){
        _contentLabel.text = @"[位置]";
    } else {
        _contentLabel.text = @"";
    }
    _contentLabel.textColor = [UIColor grayColor];
}

@end
