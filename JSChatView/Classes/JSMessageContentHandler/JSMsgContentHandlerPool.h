//
//  UUMsgContentHandlerPool.h
//  TestCom
//
//  Created by admin on 15/2/4.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSChatMessage.h"
#import "JSMessageContentHandler.h"

@interface JSMsgContentHandlerPool : NSObject

-(void)registerHandler:(Class)handlerClass;


-(JSMessageContentHandler*)handlerForMessage:(JSChatMessage*)msg;

@end
