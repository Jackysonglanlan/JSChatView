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

@interface JSChatCell (){
    NSString *voiceURL;
    
    UIView *headImageBackView;
    UIImageView *headImageView;
    
    __weak JSMsgContentHandlerPool *contentHandlerPool;
    
    __weak JSMessageContentHandler *contentHandler;
    __weak id<JSChatCellDelegate> delegate;
}

@property (nonatomic, strong) JSChatBubbleBgView *bubbleBgView;

@end

@implementation JSChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            handler:(JSMessageContentHandler*)handler
           delegate:(id<JSChatCellDelegate>)dele{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        contentHandler = handler;
        delegate = dele;
        
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间
        _msgSendTimeView = [delegate createSendTimeViewInCell:self];
        [self.contentView addSubview:self.msgSendTimeView];
        
        // 2、创建头像
        headImageBackView = [[UIView alloc]init];
        [self.contentView addSubview:headImageBackView];

        headImageView = [delegate createHeadImageViewInCell:self headBgView:headImageBackView];
        headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *headGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(headImageDidTap)];
        [headImageView addGestureRecognizer:headGR];
        
        // 3、创建头像下标
        _senderNameView = [delegate createSenderNameViewInCell:self];
        [self.contentView addSubview:self.senderNameView];
        
        // 4、创建bubble
        self.bubbleBgView = [JSChatBubbleBgView new];
        
        [contentHandler createStructureInBubbleBgView:self.bubbleBgView cellContentView:self.contentView];
        [self.contentView addSubview:self.bubbleBgView];
    }
    return self;
}

//头像点击
- (void)headImageDidTap{
    if ([delegate respondsToSelector:@selector(headImageDidTapWithImageBgView:headView:cell:viewModel:)]){
        [delegate headImageDidTapWithImageBgView:headImageBackView headView:headImageView
                                            cell:self viewModel:self.viewModel];
    }
}

//内容及Frame设置
- (void)setViewModel:(JSChatCellViewModel *)viewModel{

    _viewModel = viewModel;
    JSChatMessage *message = viewModel.message;
    
    // 1、设置时间
    [delegate renderSendTimeView:self.msgSendTimeView inCell:self];
    
    // 2、设置头像
    [delegate renderHeadImageView:headImageView headBgView:headImageBackView inCell:self];
    
    // 3、设置下标
    [delegate renderSenderNameView:self.senderNameView inCell:self];

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



