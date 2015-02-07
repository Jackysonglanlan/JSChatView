//
//  UUMsgContentHandlerPool.m
//  TestCom
//
//  Created by admin on 15/2/4.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSMsgContentHandlerPool.h"

#import "JSTextMessageHandler.h"
#import "JSImageMessageHandler.h"
#import "JSAudioMessageHandler.h"

#import "JSShortHand.h"


@implementation JSMsgContentHandlerPool{
    // @{handler class name -> JSMessageContentHandler}
    NSMutableDictionary *handlerPool;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        handlerPool = [[NSMutableDictionary alloc] initWithCapacity:5]; // change if need
    }
    return self;
}

- (void)dealloc{
    JS_releaseSafely(handlerPool);
    [super dealloc];
}

#pragma mark public

-(void)registerHandler:(Class)handlerClass{
    handlerPool[NSStringFromClass(handlerClass)] = [[handlerClass new] autorelease];
}

-(JSMessageContentHandler*)handlerForMessage:(JSChatMessage*)msg{
//    DLog(@"%@",handlePool);
    
    for (JSMessageContentHandler *handler in [handlerPool allValues]) {
        if ([handler canHandleMessage:msg]) {
            return handler;
        }
    }
    
    NSString *reason = [NSString stringWithFormat:@"Can't find handler to handle message %@",msg];
    @throw [NSException exceptionWithName:@"Fatal Error" reason:reason userInfo:nil];
}

@end
