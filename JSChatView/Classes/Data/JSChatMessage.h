//
//  UUMessage.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    UUMessageTypeText     = 0 , // 文字
    UUMessageTypePicture  = 1 , // 图片
    UUMessageTypeVoice    = 2   // 语音
} UUMessageType;


typedef enum {
    UUMessageFromMe    = 100,   // 自己发的
    UUMessageFromOther = 101    // 别人发得
} UUMessageFrom;


@interface JSChatMessage : NSObject

@property(nonatomic,retain) id msgId;

@property (nonatomic, copy) NSString *senderHeadURL;

@property (nonatomic, copy) NSString *sendTime;
@property (nonatomic, assign) BOOL showSendTime;

@property (nonatomic, copy) NSString *senderName;

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) UIImage  *picture;
@property (nonatomic, copy) NSData   *voice;
@property (nonatomic, copy) NSString *strVoiceTime;

@property (nonatomic, assign) UUMessageType type;
@property (nonatomic, assign) UUMessageFrom from;

@property(nonatomic,retain) NSDictionary *info;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end
