//
//  NSDate+Formatter.h
//  SystemXinDai
//
//  Created by LvJianfeng on 16/3/26.
//  Copyright © 2016年 LvJianfeng. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

static NSUInteger globalFirstWeekday;
static NSCalendar *globalCalendar = nil;

static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSWeekCalendarUnit |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);

__attribute__((constructor))
static void initialize_firstWeekday()
{
    globalFirstWeekday = 1;
}

__attribute__((constructor))
static void initialize_calendar()
{
    globalCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    globalCalendar.firstWeekday = globalFirstWeekday;
}

__attribute__((destructor))
static void destroy_firstWeekday()
{
    
}

__attribute__((destructor))
static void destroy_calendar()
{
    globalCalendar = nil;
}


+ (NSDate *)yesterday{
    return  [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
}

+(NSDateFormatter *)formatter {
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDoesRelativeDateFormatting:YES];
    });
    
    return formatter;
}

+(NSDateFormatter *)formatterWithoutTime {
    
    static NSDateFormatter *formatterWithoutTime = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatterWithoutTime = [[NSDate formatter] copy];
        [formatterWithoutTime setTimeStyle:NSDateFormatterNoStyle];
    });
    
    return formatterWithoutTime;
}

+(NSDateFormatter *)formatterWithoutDate {
    
    static NSDateFormatter *formatterWithoutDate = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        formatterWithoutDate = [[NSDate formatter] copy];
        [formatterWithoutDate setDateStyle:NSDateFormatterNoStyle];
    });
    
    return formatterWithoutDate;
}

#pragma mark -
#pragma mark Formatter with date & time
-(NSString *)formatWithUTCTimeZone {
    return [self formatWithTimeZoneOffset:0];
}

-(NSString *)formatWithLocalTimeZone {
    return [self formatWithTimeZone:[NSTimeZone localTimeZone]];
}

-(NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset {
    return [self formatWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
}

-(NSString *)formatWithTimeZone:(NSTimeZone *)timezone {
    NSDateFormatter *formatter = [NSDate formatter];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

#pragma mark -
#pragma mark Formatter without time
-(NSString *)formatWithUTCTimeZoneWithoutTime {
    return [self formatWithTimeZoneOffsetWithoutTime:0];
}

-(NSString *)formatWithLocalTimeZoneWithoutTime {
    return [self formatWithTimeZoneWithoutTime:[NSTimeZone localTimeZone]];
}

-(NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset {
    return [self formatWithTimeZoneWithoutTime:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
}

-(NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone {
    NSDateFormatter *formatter = [NSDate formatterWithoutTime];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}

#pragma mark -
#pragma mark Formatter without date
-(NSString *)formatWithUTCWithoutDate {
    return [self formatTimeWithTimeZone:0];
}
-(NSString *)formatWithLocalTimeWithoutDate {
    return [self formatTimeWithTimeZone:[NSTimeZone localTimeZone]];
}

-(NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset {
    return [self formatTimeWithTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
}

-(NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone {
    NSDateFormatter *formatter = [NSDate formatterWithoutDate];
    [formatter setTimeZone:timezone];
    return [formatter stringFromDate:self];
}
#pragma mark -
#pragma mark Formatter  date
+ (NSString *)currentDateStringWithFormat:(NSString *)format
{
    NSDate *chosenDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:chosenDate];
    return date;
}
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds {
    NSDate *date = [NSDate date];
    NSDateComponents *components = [NSDateComponents new];
    [components setSecond:seconds];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *dateSecondsAgo = [calendar dateByAddingComponents:components toDate:date options:0];
    return dateSecondsAgo;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}
- (NSString *)dateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:self];
    return date;
}
- (NSString *)yyyyMMByLineWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    return [formatter stringFromDate:self];
}

- (NSString *)mmddByLineWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString *)mmddChineseWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日"];
    return [formatter stringFromDate:self];
}

- (NSString *)hhmmssWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [formatter setDateFormat:@"HH:mm:ss"];
    return [formatter stringFromDate:self];
}

- (NSString *)yyyyMMddByLineWithDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString *)morningOrAfterWithHH{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *status = [formatter stringFromDate:self];
    if (status.intValue > 0 && status.intValue < 12) {
        return @"上午好";
    }else{
        return @"下午好";
    }
    return @"";
}

- (NSString *)toStringWithFormatter:(NSString *)formatter
{
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)toDateString
{
    return [self toStringWithFormatter:@"yyyy-MM-dd"];
}

- (NSString *)toDateTimeString
{
    return [self toStringWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)toTimeString
{
    return [self toStringWithFormatter:@"HH:mm:ss"];
}

- (NSString *)toFullDateTimeString
{
    return [self toStringWithFormatter:@"yyyy-MM-dd HH:mm:ss zzz"];
}

+ (void)setFirtWeekday:(NSUInteger)firstWeekday
{
    globalFirstWeekday = firstWeekday;
    globalCalendar.firstWeekday = firstWeekday;
}

+ (void)setCalendar:(NSCalendar *)calendar
{
    globalCalendar = calendar;
}

- (NSDate *)dateWithUnitFlags:(NSCalendarUnit)unitFlags
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:unitFlags];
    
    return [globalCalendar dateFromComponents:components];
}

- (NSDateComponents *)dateComponents
{
    return [self dateComponentsWithUnitFlags:componentFlags];
}

- (NSDateComponents *)dateComponentsWithUnitFlags:(NSCalendarUnit)unitFlags
{
    NSDateComponents *components = [globalCalendar components:unitFlags fromDate:self];
    
    return components;
}

- (NSInteger)year
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitYear];
    
    return components.year;
}

- (NSInteger)month
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitMonth];
    
    return components.month;
}

- (NSInteger)week
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSWeekCalendarUnit];
    
    return components.week;
}

- (NSInteger)day
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitDay];
    
    return components.day;
}

- (NSInteger)hour
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitHour];
    
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitMinute];
    
    return components.minute;
}

- (NSInteger)second
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitSecond];
    
    return components.second;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:NSCalendarUnitWeekday];
    
    return components.weekday;
}

- (NSDate *)dateByAppendingDateComponents:(NSDateComponents *)dateComponents
{
    return [globalCalendar dateByAddingComponents:dateComponents toDate:self options:0];
}

- (NSDate *)dateByAppendingYear:(NSInteger)year
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.year = year;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingMonth:(NSInteger)month
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.month = month;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingWeek:(NSInteger)week
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.weekday = week;
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingDay:(NSInteger)day
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.day = day;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingHour:(NSInteger)hour
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.hour = hour;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingMinute:(NSInteger)minute
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.minute = minute;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAppendingSecond:(NSInteger)second
{
    NSDateComponents *components = [self dateComponentsWithUnitFlags:componentFlags];
    components.second = second;
    
    return [globalCalendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDateComponents *)dateComponentsToDate:(NSDate *)anotherDate
{
    return [self dateComponentsToDate:anotherDate withUnitFlags:componentFlags];
}

- (NSDateComponents *)dateComponentsToDate:(NSDate *)anotherDate withUnitFlags:(NSCalendarUnit)unitFlags
{
    NSDate *fromDate;
    NSDate *toDate;
    [globalCalendar rangeOfUnit:unitFlags startDate:&fromDate
                       interval:NULL forDate:self];
    [globalCalendar rangeOfUnit:unitFlags startDate:&toDate
                       interval:NULL forDate:anotherDate];
    
    NSDateComponents *components = [globalCalendar components:unitFlags fromDate:fromDate toDate:toDate options:0];
    return components;
}

- (NSInteger)yearToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitYear];
    
    return components.year;
}

- (NSInteger)monthToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitMonth];
    return components.month;
}

- (NSInteger)weekToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitWeekday];
    return components.weekday;
}

- (NSInteger)dayToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitDay];
    
    return components.day;
}

- (NSInteger)hourToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitHour];
    
    return components.hour;
}

- (NSInteger)minuteToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitMinute];
    
    return components.minute;
}

- (NSInteger)secondToDate:(NSDate *)anotherDate
{
    NSDateComponents *components = [self dateComponentsToDate:anotherDate withUnitFlags:NSCalendarUnitSecond];
    
    return components.second;
}


@end
