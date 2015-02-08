//
//  JSChatViewUIRender.h
//  JSChatView
//
//  Created by Song Lanlan on 8/2/15.
//  Copyright (c) 2015 Song Lanlan. All rights reserved.
//

#import "JSChatCellViewModel.h"

@protocol JSChatViewUIRender <NSObject>

-(void)renderSenderHead:(UIImageView *)headerView headBgView:(UIView*)bgView
              viewModel:(JSChatCellViewModel*)viewModel;

@end
