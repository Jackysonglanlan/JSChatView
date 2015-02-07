//
//  UUMessageContentButton.h
//  BloodSugarForDoc
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSChatMessage.h"

/**
 * Use UIButton as our bubble background view, it can handle the bubble image automatically. (Set its backgroundImage)
 */
@interface JSChatBubbleBgView : UIButton

@property(nonatomic,readonly) UIView *drawableAreaView;

- (void)adjustDrawableAreaViewWithMsgFrom:(UUMessageFrom)from;

@end
