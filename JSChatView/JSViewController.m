//
//  JSViewController.m
//  JSChatView
//
//  Created by Song Lanlan on 7/2/15.
//  Copyright (c) 2015 Song Lanlan. All rights reserved.
//

#import "JSViewController.h"

#import "JSChatViewManager.h"

#import "JSTextMessageHandler.h"
#import "JSImageMessageHandler.h"
#import "JSAudioMessageHandler.h"

@interface JSViewController ()

@end

@implementation JSViewController{
    JSChatViewManager *chatManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self testChatView];
}

- (void)testChatView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    chatManager = [[JSChatViewManager alloc] initWithTableView:tableView];
    
    [chatManager registerContentHandler:JSTextMessageHandler.class];
    [chatManager registerContentHandler:JSImageMessageHandler.class];
    [chatManager registerContentHandler:JSAudioMessageHandler.class];
    
    [self.view addSubview:chatManager.chatView];
}

@end
