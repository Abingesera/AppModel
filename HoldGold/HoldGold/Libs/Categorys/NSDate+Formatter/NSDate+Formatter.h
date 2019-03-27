//
//  NSDate+Formatter.h
//  SystemXinDai
//
//  Created by LvJianfeng on 16/3/26.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatter)

+(NSDate *)yesterday;

+(NSDateFormatter *)formatter;
+(NSDateFormatter *)formatterWithoutTime;
+(NSDateFormatter *)formatterWithoutDate;

-(NSString *)formatWithUTCTimeZone;
-(NSString *)formatWithLocalTimeZone;
-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCTimeZoneWithoutTime;
-(NSString *)formatWithLocalTimeZoneWithoutTime;
-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

-(NSString *)formatWithUTCWithoutDate;
-(NSString *)formatWithLocalTimeWithoutDate;
-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)dateWithFormat:(NSString *)format;

//Other
- (NSString *)mmddByLineWithDate;
- (NSString *)yyyyMMByLineWithDate;
- (NSString *)yyyyMMddByLineWithDate;
- (NSString *)mmddChineseWithDate;
- (NSString *)hhmmssWithDate;

- (NSString *)morningOrAfterWithHH;



- (NSString *)toStringWithFormatter:(NSString *)formatter;
- (NSString *)toDateString;
- (NSString *)toDateTimeString;
- (NSString *)toTimeString;
- (NSString *)toFullDateTimeString;

+ (void)setFirtWeekday:(NSUInteger)firstWeekday;
+ (void)setCalendar:(NSCalendar *)calendar;

- (NSDate *)dateWithUnitFlags:(NSCalendarUnit)unitFlags;

- (NSDateComponents *)dateComponents;
- (NSDateComponents *)dateComponentsWithUnitFlags:(NSCalendarUnit)unitFlags;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)week;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)weekday;

- (NSDate *)dateByAppendingDateComponents:(NSDateComponents *)dateComponents;
- (NSDate *)dateByAppendingYear:(NSInteger)year;
- (NSDate *)dateByAppendingMonth:(NSInteger)month;
- (NSDate *)dateByAppendingWeek:(NSInteger)week;
- (NSDate *)dateByAppendingDay:(NSInteger)day;
- (NSDate *)dateByAppendingHour:(NSInteger)hour;
- (NSDate *)dateByAppendingMinute:(NSInteger)minute;
- (NSDate *)dateByAppendingSecond:(NSInteger)second;

- (NSDateComponents *)dateComponentsToDate:(NSDate *)anotherDate;
- (NSDateComponents *)dateComponentsToDate:(NSDate *)anotherDate withUnitFlags:(NSCalendarUnit)unitFlags;
- (NSInteger)yearToDate:(NSDate *)anotherDate;
- (NSInteger)monthToDate:(NSDate *)anotherDate;
- (NSInteger)weekToDate:(NSDate *)anotherDate;
- (NSInteger)dayToDate:(NSDate *)anotherDate;
- (NSInteger)hourToDate:(NSDate *)anotherDate;
- (NSInteger)minuteToDate:(NSDate *)anotherDate;
- (NSInteger)secondToDate:(NSDate *)anotherDate;
@end
