//
//  UUMessageContentHandler.h
//  TestCom
//
//  Created by admin on 15/2/4.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSChatMessage.h"

#import "JSChatBubbleBgView.h"

/**
 * Abstract !!! *Never* instantiate this class directly!
 */
@interface JSMessageContentHandler : NSObject

@property(nonatomic,retain) JSChatMessage *message;

#pragma mark subclass override

/**
 * The message will be set to handler if return YES, then the following methods will be called.
 */
-(BOOL)canHandleMessage:(JSChatMessage*)message;

-(CGSize)calculateContentSize;

- (void)createStructureInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView;

- (void)beforeRenderContentViewFromMe:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView;

- (void)beforeRenderContentViewFromOther:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView;

- (void)renderContentInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView;

@end
