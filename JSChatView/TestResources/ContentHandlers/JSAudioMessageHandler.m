//
//  UUAudioMessageHandler.m
//  TestCom
//
//  Created by admin on 15/2/6.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSAudioMessageHandler.h"

@implementation JSAudioMessageHandler

-(BOOL)canHandleMessage:(JSChatMessage*)message{
    return message.type == UUMessageTypeVoice;
}

-(CGSize)calculateContentSize{
    return CGSizeMake(120, 20);
}

- (void)createStructureInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    
}

- (void)beforeRenderContentViewFromMe:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
}

- (void)beforeRenderContentViewFromOther:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
}

- (void)renderContentInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    
}

@end
