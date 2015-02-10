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

#import "UIKit+AFNetworking.h"

@interface JSViewController ()<JSChatViewUIRender>

@end

@implementation JSViewController{
    JSChatViewManager *chatManager;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self testChatView];
}

-(UIImageView*)createHeadImageViewInCell:(JSChatCell*)cell headBgView:(UIView*)bgView{
    bgView.layer.cornerRadius = 22;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];

    UIImageView *headImageView = [[UIImageView new] autorelease];
    headImageView.layer.cornerRadius = 20;
    headImageView.layer.masksToBounds = YES;
    [bgView addSubview:headImageView];

    return headImageView;
}

-(void)renderSenderHead:(UIImageView *)headerView headBgView:(UIView*)bgView
                 inCell:(JSChatCell*)cell{
    CGRect iconF = cell.viewModel.iconF;
    
    bgView.frame = iconF;
    headerView.frame = CGRectMake(2, 2, CGRectGetWidth(iconF)-4, CGRectGetHeight(iconF)-4);

    [headerView setImageWithURL:[NSURL URLWithString:cell.viewModel.message.senderHeadURL]
               placeholderImage:[UIImage imageNamed:@"chatfrom_doctor_icon"]];
}

-(UIView*)createSenderNameViewInCell:(JSChatCell*)cell{
    UILabel *name = [[UILabel new] autorelease];
    name.textColor = [UIColor grayColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = ChatTimeFont;
    return name;
}

-(void)renderSenderNameView:(UIView*)nameView inCell:(JSChatCell*)cell{
    UILabel *name = (UILabel*)nameView;
    
    JSChatCellViewModel *viewModel = cell.viewModel;
    name.text = viewModel.message.senderName;
    
    if (viewModel.nameF.origin.x > 160) {
        name.frame = CGRectMake(viewModel.nameF.origin.x - 50, viewModel.nameF.origin.y + 3, 100, viewModel.nameF.size.height);
        name.textAlignment = NSTextAlignmentRight;
    }else{
        name.frame = CGRectMake(viewModel.nameF.origin.x, viewModel.nameF.origin.y + 3, 80, viewModel.nameF.size.height);
        name.textAlignment = NSTextAlignmentLeft;
    }
}

-(UIView*)createSendTimeViewInCell:(JSChatCell*)cell{
    UILabel *time = [[UILabel new] autorelease];
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [UIColor grayColor];
    time.font = ChatTimeFont;
    return time;
}

-(void)renderSendTimeView:(UIView*)timeView inCell:(JSChatCell*)cell{
    UILabel *time = (UILabel*)timeView;
    
    JSChatCellViewModel *viewModel = cell.viewModel;

    time.text = viewModel.message.sendTime;
    time.frame = viewModel.timeF;
}

- (void)testChatView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    chatManager = [[JSChatViewManager alloc] initWithTableView:tableView];
    
    [chatManager registerContentHandler:JSTextMessageHandler.class];
    [chatManager registerContentHandler:JSImageMessageHandler.class];
    [chatManager registerContentHandler:JSAudioMessageHandler.class];
    
    chatManager.uiRender = self;
    
    [self.view addSubview:chatManager.chatView];
}

@end
