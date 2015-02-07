//
//  UUInputFunctionView.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSChatViewUIResponder.h"

@class JSChatInputView;

@protocol UUInputViewDelegate <NSObject>

// text
- (void)inputView:(JSChatInputView *)inputView sendMessage:(NSString *)message;

// image
- (void)inputView:(JSChatInputView *)inputView sendPicture:(UIImage *)image;

// audio
- (void)inputView:(JSChatInputView *)inputView sendVoice:(NSString*)recordedFilePath time:(NSInteger)second;

@end

@interface JSChatInputView : UIView 

@property (nonatomic, readonly) UIButton *btnSendMessage;
@property (nonatomic, readonly) UIButton *btnChangeVoiceState;
@property (nonatomic, readonly) UIButton *btnVoiceRecord;
@property (nonatomic, readonly) UITextView *textInputView;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, strong) UIViewController *superVC;

@property (nonatomic, weak) id<UUInputViewDelegate> delegate;

@property (nonatomic, weak) id<JSChatViewUIResponder> uiResponder;

- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;

@end
