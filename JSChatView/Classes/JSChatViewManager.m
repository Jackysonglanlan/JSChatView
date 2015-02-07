//
//  JSChatViewManager.m
//  TestCom
//
//  Created by Song Lanlan on 7/2/15.
//  Copyright (c) 2015 cmge. All rights reserved.
//

#import "JSChatViewManager.h"

#import "JSMsgContentHandlerPool.h"

#import "JSChatViewController.h"

#import "JSShortHand.h"

@implementation JSChatViewManager{
    JSMsgContentHandlerPool *pool;
    JSChatViewController *chatVC;
}

- (instancetype)initWithTableView:(UITableView*)tableView{
    self = [super init];
    if (self) {
        pool = [JSMsgContentHandlerPool new];
        chatVC = [[JSChatViewController alloc] initWithManager:self];
        chatVC.chatTableView = tableView;
    }
    return self;
}

- (void)dealloc{
    JS_releaseSafely(pool);
    JS_releaseSafely(chatVC);
    [super dealloc];
}

-(UIView*)chatView{
    return chatVC.view;
}

- (void)registerContentHandler:(Class)handlerClass {
    [pool registerHandler:handlerClass];
}

-(JSMessageContentHandler*)handlerForMessage:(JSChatMessage*)message{
    return [pool handlerForMessage:message];
}

@end
