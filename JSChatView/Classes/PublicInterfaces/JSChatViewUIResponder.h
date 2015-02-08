//
//  JSChatViewUIResponder.h
//  JSChatView
//
//  Created by Song Lanlan on 7/2/15.
//  Copyright (c) 2015 Song Lanlan. All rights reserved.
//

@class JSChatInputView;
@class JSChatCell;
@class JSChatCellViewModel;

@protocol JSChatViewUIResponder <NSObject>

@optional

- (void)headerViewInCell:(JSChatCell *)cell didTapWithViewModel:(JSChatCellViewModel*)viewModel;

- (void)inputView:(JSChatInputView *)inputView sendTextBtnDidTapWithText:(NSString *)message;

- (void)chooseImageBtnDidTapWithInputView:(JSChatInputView *)inputView;

- (void)recordAudioDidBeginWithButton:(UIButton *)button;

- (void)recordAudioDidEndWithButton:(UIButton *)button;

- (void)recordAudioDidCancelWithButton:(UIButton *)button;

- (void)recordAudioBtnDragExit:(UIButton*)button;

- (void)recordAudioBtnDragEnter:(UIButton*)button;

@end

