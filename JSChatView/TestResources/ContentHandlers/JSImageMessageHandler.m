//
//  UUImageMessageHandler.m
//  TestCom
//
//  Created by admin on 15/2/6.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSImageMessageHandler.h"

#import "JSChatCellViewModel.h"

@implementation JSImageMessageHandler

-(BOOL)canHandleMessage:(JSChatMessage*)message{
    return message.type == UUMessageTypePicture;
}

-(CGSize)calculateContentSize{
    return CGSizeMake(ChatPicWH, ChatPicWH);
}

- (void)createStructureInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    
}

- (void)beforeRenderContentViewFromMe:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
}

- (void)beforeRenderContentViewFromOther:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
}

- (void)renderContentInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    bubbleBgView.backgroundColor = [UIColor redColor];
}


@end
