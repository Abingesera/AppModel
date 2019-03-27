//
//  FontTool.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PingFangSCRegular @"PingFangSC-Regular"
#define PingFangSCMedium @"PingFangSC-Medium"
#define PingFangSCLight @"PingFangSC-Light"
#define PingFangSCSemibold @"PingFangSC-Semibold"

@interface FontTool : NSObject

+ (UIFont *)setRegularFontWithSizeNumber:(FontSizeNumber)sizeNumber;

+ (UIFont *)setMediumFontWithSizeNumber:(FontSizeNumber)sizeNumber;

+ (UIFont *)setOtherFontWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber;


/**
 固定大小字体
 
 @param fontName 字体名
 @param sizeNumber 字号
 */
+ (UIFont *)setFontWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber;


/**
 根据屏幕进行字体适配
 
 @param fontName 字体名
 @param sizeNumber 字号
 
 */
+ (UIFont *)setFontAutoMatchWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber;


/**
 固定大小字体
 
 @param fontName 字体名
 @param SizeFont 字号
 */
+ (UIFont *)createFontWithFontName:(NSString *)fontName SizeFont:(CGFloat)SizeFont;

/**
 根据屏幕进行字体适配
 
 @param fontName 字体名
 @param SizeFont 字号
 
 */
+ (UIFont *)createFontAutoMatchWithFontName:(NSString *)fontName SizeFont:(CGFloat)SizeFont;


/**
 设置字间距
 
 @param space 间距
 @param font 字体
 @param content 内容
 
 */
+ (NSMutableAttributedString *)setFontSpace:(NSNumber*)space font:(UIFont *)font content:(NSString *)content;


@end

