//
//  UUChatTestVC.h
//  TestCom
//
//  Created by admin on 15/2/3.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSChatViewManager.h"

@interface JSChatViewController : UIViewController

- (id)initWithManager:(JSChatViewManager*)manager;

@property(nonatomic,retain) UITableView *chatTableView;

@end
