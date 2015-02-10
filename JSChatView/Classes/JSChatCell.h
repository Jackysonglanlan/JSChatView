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

-(UIImageView*)createHeadImageViewInCell:(JSChatCell*)cell headBgView:(UIView*)bgView;
-(void)renderHeadImageView:(UIImageView*)headView headBgView:(UIView*)bgView
                    inCell:(JSChatCell*)cell;

-(UIView*)createSenderNameViewInCell:(JSChatCell*)cell;
-(void)renderSenderNameView:(UIView*)nameView inCell:(JSChatCell*)cell;

-(UIView*)createSendTimeViewInCell:(JSChatCell*)cell;
-(void)renderSendTimeView:(UIView*)timeView inCell:(JSChatCell*)cell;

@optional

- (void)headImageDidTapWithImageBgView:(UIView*)bgView headView:(UIImageView*)headView
                                  cell:(JSChatCell *)cell
                             viewModel:(JSChatCellViewModel*)vm;

@end

@interface JSChatCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            handler:(JSMessageContentHandler*)handler
           delegate:(id<JSChatCellDelegate>)delegate;

@property (nonatomic, readonly) UIView *msgSendTimeView;
@property (nonatomic, readonly) UIView *senderNameView;

// set its message frame then render the content on the bubble bg view
@property (nonatomic, strong) JSChatCellViewModel *viewModel;

@end

