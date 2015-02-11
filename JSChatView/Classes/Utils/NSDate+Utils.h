//
//  NSDate+Utils.h
//  BloodSugar
//
//  Created by PeterPan on 13-12-27.
//  Copyright (c) 2013年 shake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (JSChatView_Utils)

+ (NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

#pragma mark - Getter
- (NSInteger)year;
- (NSInteger)hour;
- (NSInteger)minute;

#pragma mark - Date String
- (NSString *)stringMonthDay;
- (NSString *)stringYearMonthDay;
- (NSString *)stringYearMonthDayCompareToday;                 //返回“今天”，“明天”，“昨天”，或年月日

#pragma mark - Date and string convert
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

@end
