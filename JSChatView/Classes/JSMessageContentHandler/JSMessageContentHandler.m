//
//  UUMessageContentHandler.m
//  TestCom
//
//  Created by admin on 15/2/4.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSMessageContentHandler.h"

#import "JSShortHand.h"

@implementation JSMessageContentHandler

- (void)dealloc{
    JS_releaseSafely(_message);
    [super dealloc];
}

#pragma mark subclass override

-(BOOL)canHandleMessage:(JSChatMessage*)message{
    return NO;
}

-(CGSize)calculateContentSize{
    return CGSizeZero;
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
