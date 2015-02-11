//
//  JSChatViewUIRender.h
//  JSChatView
//
//  Created by Song Lanlan on 8/2/15.
//  Copyright (c) 2015 Song Lanlan. All rights reserved.
//

#import "JSChatCellViewModel.h"

#import "JSChatCell.h"

@class JSChatInputView;

@protocol JSChatViewUIRender <NSObject>

-(UIImageView*)createHeadImageViewInCell:(JSChatCell*)cell headBgView:(UIView*)bgView;
-(void)renderSenderHead:(UIImageView *)headerView headBgView:(UIView*)bgView
                 inCell:(JSChatCell*)cell;

-(UIView*)createSenderNameViewInCell:(JSChatCell*)cell;
-(void)renderSenderNameView:(UIView*)nameView inCell:(JSChatCell*)cell;

-(UIView*)createSendTimeViewInCell:(JSChatCell*)cell;
-(void)renderSendTimeView:(UIView*)nameView inCell:(JSChatCell*)cell;

@optional

-(void)inputViewDidInit:(JSChatInputView*)inputView;

@end
