//
//  JSChatViewUIResponder.h
//  JSChatView
//
//  Created by Song Lanlan on 7/2/15.
//  Copyright (c) 2015 Song Lanlan. All rights reserved.
//

@class JSChatInputView;
@class JSChatCell;

@protocol JSChatViewUIResponder <NSObject>

@optional

- (void)jsChatCell:(JSChatCell *)cell headImageDidTapWithUserId:(id)userId;

- (void)inputView:(JSChatInputView *)inputView sendTextBtnDidTapWithText:(NSString *)message;

- (void)chooseImageBtnDidTapWithInputView:(JSChatInputView *)inputView;

- (void)recordAudioBtnDidTapWithInputView:(JSChatInputView *)inputView;

@end

