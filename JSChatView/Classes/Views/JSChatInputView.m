//
//  UUInputFunctionView.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "JSChatInputView.h"

#import "ACMacros.h"

@interface JSChatInputView ()<UIActionSheetDelegate,UITextViewDelegate>{
    BOOL isbeginVoiceRecord;
    
    UILabel *inputPlaceHolder;
}
@end

@implementation JSChatInputView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //发送消息
        _btnSendMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnSendMessage.frame = CGRectMake(CGRectGetWidth(frame)-40, 5, 30, 30);
        self.isAbleToSendTextMessage = NO;
        [self.btnSendMessage setTitle:@"" forState:UIControlStateNormal];
        [self.btnSendMessage setBackgroundImage:[UIImage imageNamed:@"Chat_take_picture"] forState:UIControlStateNormal];
        self.btnSendMessage.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnSendMessage addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnSendMessage];
        
        //改变状态（语音、文字）
        _btnChangeVoiceState = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnChangeVoiceState.frame = CGRectMake(5, 5, 30, 30);
        isbeginVoiceRecord = NO;
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        self.btnChangeVoiceState.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.btnChangeVoiceState addTarget:self action:@selector(voiceRecord:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnChangeVoiceState];

        //语音录入键
        _btnVoiceRecord = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnVoiceRecord.frame = CGRectMake(70, 5, Main_Screen_Width-70*2, 30);
        self.btnVoiceRecord.hidden = YES;
        [self.btnVoiceRecord setBackgroundImage:[UIImage imageNamed:@"chat_message_back"] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [self.btnVoiceRecord setTitle:@"Hold to Talk" forState:UIControlStateNormal];
        [self.btnVoiceRecord setTitle:@"Release to Send" forState:UIControlStateHighlighted];
        
        [self.btnVoiceRecord addTarget:self action:@selector(beginRecordVoice:)
                      forControlEvents:UIControlEventTouchDown];
        [self.btnVoiceRecord addTarget:self action:@selector(endRecordVoice:)
                      forControlEvents:UIControlEventTouchUpInside];
        [self.btnVoiceRecord addTarget:self action:@selector(cancelRecordVoice:)
                      forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel];
        [self.btnVoiceRecord addTarget:self action:@selector(remindDragExit:)
                      forControlEvents:UIControlEventTouchDragExit];
        [self.btnVoiceRecord addTarget:self action:@selector(remindDragEnter:)
                      forControlEvents:UIControlEventTouchDragEnter];
        [self addSubview:self.btnVoiceRecord];
        
        //输入框
        _textInputView = [[UITextView alloc]initWithFrame:CGRectMake(45, 5, Main_Screen_Width-2*45, 30)];
        self.textInputView.layer.cornerRadius = 4;
        self.textInputView.layer.masksToBounds = YES;
        self.textInputView.delegate = self;
        self.textInputView.layer.borderWidth = 1;
        self.textInputView.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
        [self addSubview:self.textInputView];
        
        //输入框的提示语
        inputPlaceHolder = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 30)];
        inputPlaceHolder.text = @"Input the contents here";
        inputPlaceHolder.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
        [self.textInputView addSubview:inputPlaceHolder];
        
        //分割线
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
        
        //添加通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidShowOrHide:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidEndEditing:) name:UIKeyboardWillHideNotification object:nil];
        
        if ([self.uiRender respondsToSelector:@selector(inputViewDidInit:)]) {
            [self.uiRender inputViewDidInit:self];
        }
    }
    return self;
}

#pragma mark - 录音touch事件
- (void)beginRecordVoice:(UIButton *)button{
    if ([self.uiResponder respondsToSelector:@selector(recordAudioDidBeginWithButton:)]) {
        [self.uiResponder recordAudioDidBeginWithButton:button];
    }

}

- (void)endRecordVoice:(UIButton *)button{
    if ([self.uiResponder respondsToSelector:@selector(recordAudioDidEndWithButton:)]) {
        [self.uiResponder recordAudioDidEndWithButton:button];
    }
}

- (void)cancelRecordVoice:(UIButton *)button{
    if ([self.uiResponder respondsToSelector:@selector(recordAudioDidCancelWithButton:)]) {
        [self.uiResponder recordAudioDidCancelWithButton:button];
    }
}

- (void)remindDragExit:(UIButton *)button{
    if ([self.uiResponder respondsToSelector:@selector(recordAudioBtnDragExit:)]) {
        [self.uiResponder recordAudioBtnDragExit:button];
    }
}

- (void)remindDragEnter:(UIButton *)button{
    if ([self.uiResponder respondsToSelector:@selector(recordAudioBtnDragEnter:)]) {
        [self.uiResponder recordAudioBtnDragEnter:button];
    }
}

#pragma mark - Keyboard methods

//跟随键盘高度变化
-(void)keyboardDidShowOrHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.frame;
    newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height;
    self.frame = newFrame;
    
    [UIView commitAnimations];
}

//改变输入与录音状态
- (void)voiceRecord:(UIButton *)sender
{
    self.btnVoiceRecord.hidden = !self.btnVoiceRecord.hidden;
    self.textInputView.hidden  = !self.textInputView.hidden;
    isbeginVoiceRecord = !isbeginVoiceRecord;
    if (isbeginVoiceRecord) {
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_ipunt_message"] forState:UIControlStateNormal];
        [self.textInputView resignFirstResponder];
    }else{
        [self.btnChangeVoiceState setBackgroundImage:[UIImage imageNamed:@"chat_voice_record"] forState:UIControlStateNormal];
        [self.textInputView becomeFirstResponder];
    }
}

//发送消息（文字图片）
- (void)sendMessage:(UIButton *)sender
{
    if (self.isAbleToSendTextMessage) {
        NSString *resultStr = [self.textInputView.text stringByReplacingOccurrencesOfString:@"   " withString:@""];
        if ([self.uiResponder respondsToSelector:@selector(inputView:sendTextBtnDidTapWithText:)]) {
            [self.uiResponder inputView:self sendTextBtnDidTapWithText:resultStr];
        }
        if ([self.delegate respondsToSelector:@selector(inputView:afterSendTextBtnTapWithText:)]) {
            [self.delegate inputView:self afterSendTextBtnTapWithText:resultStr];
        }
    }
    else{
        [self.textInputView resignFirstResponder];
        
        if ([self.uiResponder respondsToSelector:@selector(chooseImageBtnDidTapWithInputView:)]) {
            [self.uiResponder chooseImageBtnDidTapWithInputView:self];
        }

    }
}

#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    inputPlaceHolder.hidden = (self.textInputView.text.length > 0);
}

- (void)textViewDidChange:(UITextView *)textView{
    BOOL isNoInput = (textView.text.length > 0);
    [self changeSendBtnWithPhoto:!isNoInput];
    inputPlaceHolder.hidden = isNoInput;
}

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto
{
    self.isAbleToSendTextMessage = !isPhoto;
    [self.btnSendMessage setTitle:isPhoto?@"":@"send" forState:UIControlStateNormal];
    self.btnSendMessage.frame = RECT_CHANGE_width(self.btnSendMessage, isPhoto?30:35);
    UIImage *image = [UIImage imageNamed:isPhoto?@"Chat_take_picture":@"chat_send_message"];
    [self.btnSendMessage setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    inputPlaceHolder.hidden = (self.textInputView.text.length > 0);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
