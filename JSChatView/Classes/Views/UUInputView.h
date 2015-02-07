//
//  UUInputFunctionView.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUInputView;

@protocol UUInputViewDelegate <NSObject>

// text
- (void)inputView:(UUInputView *)funcView sendMessage:(NSString *)message;

// image
- (void)inputView:(UUInputView *)funcView sendPicture:(UIImage *)image;

// audio
- (void)inputView:(UUInputView *)funcView sendVoice:(NSString*)recordedFilePath time:(NSInteger)second;

@end

@interface UUInputView : UIView 

@property (nonatomic, readonly) UIButton *btnSendMessage;
@property (nonatomic, readonly) UIButton *btnChangeVoiceState;
@property (nonatomic, readonly) UIButton *btnVoiceRecord;
@property (nonatomic, readonly) UITextView *textInputView;

@property (nonatomic, assign) BOOL isAbleToSendTextMessage;

@property (nonatomic, strong) UIViewController *superVC;

@property (nonatomic, weak) id<UUInputViewDelegate>delegate;


- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;

@end
