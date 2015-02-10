//
//  UUTextMessageHandler.m
//  TestCom
//
//  Created by admin on 15/2/6.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSTextMessageHandler.h"

#import "JSChatCellViewModel.h"

#import "JSShortHand.h"

#define kTag_TextLabel 1000

@implementation JSTextMessageHandler

-(BOOL)canHandleMessage:(JSChatMessage*)message{
    return message.type == UUMessageTypeText;
}

-(CGSize)calculateContentSize{
    return [self.message.strContent sizeWithFont:ChatContentFont
                               constrainedToSize:CGSizeMake(ChatContentW, CGFLOAT_MAX)
                                   lineBreakMode:NSLineBreakByWordWrapping];
}

- (void)createStructureInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    DLog(@"1");
    
    UIButton *v = [[UIButton buttonWithType:UIButtonTypeSystem] autorelease];
    v.titleLabel.numberOfLines = 0;
    v.tag = kTag_TextLabel;
    
    [v addTarget:self action:@selector(foo) forControlEvents:UIControlEventTouchUpInside];
    
    [bubbleBgView.drawableAreaView addSubview:v];
}

- (void)foo {
    DLog(@"button tapped...");
}

- (void)beforeRenderContentViewFromMe:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    DLog(@"2");
}

- (void)beforeRenderContentViewFromOther:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    DLog(@"3");
}

- (void)renderContentInBubbleBgView:(JSChatBubbleBgView*)bubbleBgView cellContentView:(UIView*)contentView{
    DLog(@"4");
    
    UIButton *v = (UIButton*)[bubbleBgView.drawableAreaView viewWithTag:kTag_TextLabel];
    
    CGRect areaF = bubbleBgView.drawableAreaView.frame;
    
    v.frame = CGRectMake(0, 0, CGRectGetWidth(areaF), CGRectGetHeight(areaF));
    
    [v setTitle:self.message.strContent forState:UIControlStateNormal];

    contentView.backgroundColor = [UIColor blueColor];
}

@end
