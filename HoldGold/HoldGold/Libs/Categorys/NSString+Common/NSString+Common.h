//
//  NSString+Common.h
//  NewHoldGold
//
//  Created by zsgjs on 2017/11/21.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

+ (NSString *)UUID;

@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;

#pragma mark - string

+ (instancetype)stringWithUTF8Data:(NSData *)data;
+ (instancetype)stringWithData:(NSData *)data usingEncoding:(NSStringEncoding)encoding;

// string methods
- (NSArray *)split:(NSString *)separator;
- (NSString *)replaceAll:(NSString*)target with:(NSString *)replacement;
- (NSString *)substringFromIndex:(NSUInteger)begin toIndex:(NSUInteger)end;
- (NSString *)stringByTrimmingNewLineCharacterSet;
- (NSString *)stringByTrimmingWhiteAndNewLineCharacterSet;
- (NSString *)urlEncoded;
- (NSString *)urlDecode;
- (NSString *)encodeStringWithUTF8;
- (NSString *)substringWithRegex:(NSString *)regex;
- (NSString *)reverse;

- (NSComparisonResult)compareTo:(NSString *)anotherString;
- (NSComparisonResult)compareToIgnoreCase:(NSString *)string;

- (BOOL)contains:(NSString *)string;
- (BOOL)startsWith:(NSString *)prefix;
- (BOOL)endsWith:(NSString *)suffix;
- (BOOL)equals:(NSString *) anotherString;
- (BOOL)equalsIgnoreCase:(NSString *)anotherString;

- (NSInteger)indexOfChar:(unichar)ch;
- (NSInteger)indexOfChar:(unichar)ch fromIndex:(int)index;
- (NSInteger)indexOfString:(NSString *)string;
- (NSInteger)indexOfString:(NSString *)string fromIndex:(int)index;
- (NSInteger)lastIndexOfChar:(unichar)ch;
- (NSInteger)lastIndexOfChar:(unichar)ch fromIndex:(int)index;
- (NSInteger)lastIndexOfString:(NSString *)string;
- (NSInteger)lastIndexOfString:(NSString *)string fromIndex:(int)index;

#pragma mark - valid

- (BOOL)isValidFileName;
- (BOOL)isValidEmailAddress;
- (BOOL)isValidMobileNumber;
- (BOOL)isInternationValidMobileNumber;
- (BOOL)isURLRegular;

///返回非nil字符串，为nil则返回@""
- (NSString *)nonilString;

///判断是否为nil、NULL、@“”
+ (BOOL)isNil:(NSString *)string;


#pragma mark - pinyin

//- (NSString *)pinYin;
//- (NSString *)jianPin;

#pragma mark - date string

- (NSDate *)toDateWithFormatter:(NSString *)formatter;

// yyyy-MM-dd
- (NSDate *)toDate;

// yyyy-MM-dd HH:mm:ss
- (NSDate *)toDateTime;

// yyyy-MM-dd HH:mm:ss zzz
- (NSDate *)toFullDateTime;

// HH:mm:ss
- (NSDate *)toTime;

#pragma mark - encrypt and decrypt

- (NSString *)md5String32:(NSString *)srcString;

- (NSString *)md5String16:(NSString *)srcString;

//截取URL 参数
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

//动态计算文字的高度
- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font;

#pragma mark 计算字体自适应大小
- (CGSize)calculateTextWidthWithFont:(UIFont *)font AndWithMAXWidth:(CGFloat)MaxWidth AndWithMaxHeigth:(CGFloat)MaxHeight;

//动态计算富文本的高度
-(CGSize)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;

//构造富文本
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font;


//时间去重合并
+(NSString *)dateCompare:(NSString *)str1 withStr:(NSString *)str2;

+(NSString *)dateStrCompare:(NSString *)startStr withStr:(NSString *)endStr;

@end
