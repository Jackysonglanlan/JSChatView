//
//  UUMessageCell.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "JSChatCell.h"
#import "JSChatMessage.h"
#import "JSChatCellViewModel.h"

#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"


@interface JSChatCell (){
    NSString *voiceURL;
    
    UIView *headImageBackView;
    UIImageView *headImageView;
    
    __weak JSMsgContentHandlerPool *contentHandlerPool;
    
    __weak JSMessageContentHandler *contentHandler;
}

@property (nonatomic, retain) JSChatBubbleBgView *bubbleBgView;

@end

@implementation JSChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            handler:(JSMessageContentHandler*)handler{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        contentHandler = handler;
        
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        [self.contentView addSubview:self.labelTime];
        
        // 2、创建头像
        headImageBackView = [[UIView alloc]init];
        headImageBackView.layer.cornerRadius = 22;
        headImageBackView.layer.masksToBounds = YES;
        headImageBackView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self.contentView addSubview:headImageBackView];
        
        headImageView = [UIImageView new];
        headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *headGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(headImageDidTap)];
        [headImageView addGestureRecognizer:headGR];
        [headImageBackView addSubview:headImageView];
        
        // 3、创建头像下标
        self.labelNum = [[UILabel alloc] init];
        self.labelNum.textColor = [UIColor grayColor];
        self.labelNum.textAlignment = NSTextAlignmentCenter;
        self.labelNum.font = ChatTimeFont;
        [self.contentView addSubview:self.labelNum];
        
        // 4、创建bubble
        self.bubbleBgView = [JSChatBubbleBgView new];
        
        [contentHandler createStructureInBubbleBgView:self.bubbleBgView cellContentView:self.contentView];
        [self.contentView addSubview:self.bubbleBgView];
    }
    return self;
}

//头像点击
- (void)headImageDidTap{
    if ([self.delegate respondsToSelector:@selector(headImageDidTapWithImageBgView:headView:cell:viewModel:)]){
        [self.delegate headImageDidTapWithImageBgView:headImageBackView headView:headImageView
                                                 cell:self viewModel:self.viewModel];
    }
}

//内容及Frame设置
- (void)setViewModel:(JSChatCellViewModel *)viewModel{

    _viewModel = viewModel;
    JSChatMessage *message = viewModel.message;
    
    // 1、设置时间
    self.labelTime.text = message.sendTime;
    self.labelTime.frame = viewModel.timeF;
    
    // 2、设置头像
    headImageBackView.frame = viewModel.iconF;
    headImageView.frame = CGRectMake(2, 2, ChatIconWH-4, ChatIconWH-4);
    
    if ([self.delegate respondsToSelector:@selector(renderHeadImageView:headBgView:viewModel:)]){
        [self.delegate renderHeadImageView:headImageView headBgView:headImageBackView viewModel:viewModel];
    }
    
    // 3、设置下标
    self.labelNum.text = message.senderName;
    if (viewModel.nameF.origin.x > 160) {
        self.labelNum.frame = CGRectMake(viewModel.nameF.origin.x - 50, viewModel.nameF.origin.y + 3, 100, viewModel.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentRight;
    }else{
        self.labelNum.frame = CGRectMake(viewModel.nameF.origin.x, viewModel.nameF.origin.y + 3, 80, viewModel.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentLeft;
    }

    // 4、设置内容
    
    self.bubbleBgView.frame = viewModel.contentF;
    [self.bubbleBgView adjustDrawableAreaViewWithMsgFrom:message.from];
    
    contentHandler.message = viewModel.message;
    
    [contentHandler beforeRenderContentViewFromMe:self.bubbleBgView cellContentView:self.contentView];

    [contentHandler renderContentInBubbleBgView:self.bubbleBgView cellContentView:self.contentView];

    //背景气泡图
    UIImage *normal;
    if (message.from == UUMessageFromMe) {
        normal = [UIImage imageNamed:@"chatto_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    else{
        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }
    
    // this is why we use UIButton as our bubble view, it can resize the backgroud image according to the image.
    // so we don't need to.
    [self.bubbleBgView setBackgroundImage:normal forState:UIControlStateNormal];
    [self.bubbleBgView setBackgroundImage:normal forState:UIControlStateHighlighted];
}

@end



