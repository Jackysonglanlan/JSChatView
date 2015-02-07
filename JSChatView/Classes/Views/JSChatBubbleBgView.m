//
//  UUMessageContentButton.m
//  BloodSugarForDoc
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import "JSChatBubbleBgView.h"

#define kValue_Bubble_Image_Left_Edge_Width 11
#define kValue_Bubble_Image_Right_Edge_Width 11

@implementation JSChatBubbleBgView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        
        _drawableAreaView = [UIView new];
        _drawableAreaView.backgroundColor = [UIColor grayColor];
        [self addSubview:_drawableAreaView];
    }
    return self;
}

- (void)adjustDrawableAreaViewWithMsgFrom:(UUMessageFrom)from {
    CGFloat x = (from == UUMessageFromOther) ? kValue_Bubble_Image_Left_Edge_Width : 0;
    CGFloat wOffset = (from == UUMessageFromOther) ? 0 : -kValue_Bubble_Image_Right_Edge_Width;
    _drawableAreaView.frame = CGRectMake(x, 0, CGRectGetWidth(self.frame) + wOffset, CGRectGetHeight(self.frame));
}

@end
