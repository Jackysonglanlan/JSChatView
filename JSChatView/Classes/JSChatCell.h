//
//  UUMessageCell.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSChatBubbleBgView.h"
#import "JSChatCellViewModel.h"

#import "JSMsgContentHandlerPool.h"

@class JSChatCell;

@protocol JSChatCellDelegate <NSObject>

@optional
- (void)headImageDidClick:(JSChatCell *)cell userId:(NSString *)userId;
@end

@interface JSChatCell : UITableViewCell

@property (nonatomic, strong)UILabel *labelTime;
@property (nonatomic, strong)UILabel *labelNum;
@property (nonatomic, strong)UIButton *btnHeadImage;
@property (nonatomic, strong)UIImageView *lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            handler:(JSMessageContentHandler*)handler;

// set its message frame then render the content on the bubble bg view
@property (nonatomic, strong) JSChatCellViewModel *viewModel;

@property (nonatomic, weak)id<JSChatCellDelegate>delegate;

@end

