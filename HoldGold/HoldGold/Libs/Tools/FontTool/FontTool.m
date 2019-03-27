//
//  FontTool.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "FontTool.h"

@implementation FontTool
+ (UIFont *)setRegularFontWithSizeNumber:(FontSizeNumber)sizeNumber
{
    
    //以 iphone6 为标准适配字体大小
    if (IPHONE_35_inch) {
        sizeNumber = sizeNumber *0.8;
    }
    
    //    if (iPhoneX) {
    //        sizeNumber = sizeNumber *1.1;
    //    }
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:sizeNumber];
    if (font==nil) {
        font = [UIFont systemFontOfSize:sizeNumber];
    }
    return font;
}

+ (UIFont *)setMediumFontWithSizeNumber:(FontSizeNumber)sizeNumber{
    
    //以 iphone6 为标准适配字体大小
    if (IPHONE_35_inch) {
        sizeNumber = sizeNumber *0.8;
    }
    
    //    if (iPhoneX) {
    //        sizeNumber = sizeNumber *1.1;
    //    }
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:sizeNumber];
    if (font==nil) {
        font = [UIFont boldSystemFontOfSize:sizeNumber];
    }
    return font;
    
}

+ (UIFont *)setOtherFontWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber {
    //以 iphone6 为标准适配字体大小
    if (IPHONE_35_inch) {
        sizeNumber = sizeNumber *0.8;
    }
    
    //    if (iPhoneX) {
    //        sizeNumber = sizeNumber *1.1;
    //    }
    
    UIFont *font = [UIFont fontWithName:fontName size:sizeNumber];
    if (font==nil) {
        font = [UIFont systemFontOfSize:sizeNumber];
    }
    return font;
}

+ (UIFont *)setFontWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber{
    
    UIFont *font = [UIFont fontWithName:fontName size:sizeNumber];
    
    if (font==nil) {
        font = [UIFont systemFontOfSize:sizeNumber];
    }
    return font;
    
}

+ (UIFont *)setFontAutoMatchWithFontName:(NSString *)fontName SizeNumber:(FontSizeNumber)sizeNumber{
    
    if (sizeNumber*ScaleW >= sizeNumber) {
        
    }else{
        sizeNumber = sizeNumber*ScaleW;
    }
    UIFont *font = [UIFont fontWithName:fontName size:sizeNumber];
    if (font==nil) {
        font = [UIFont systemFontOfSize:sizeNumber];
    }
    return font;
}

+ (UIFont *)createFontWithFontName:(NSString *)fontName SizeFont:(CGFloat)SizeFont {
    
    UIFont *font = [UIFont fontWithName:fontName size:SizeFont];
    
    if (font==nil) {
        font = [UIFont systemFontOfSize:SizeFont];
    }
    return font;
}

+ (UIFont *)createFontAutoMatchWithFontName:(NSString *)fontName SizeFont:(CGFloat)SizeFont{
    
    if (SizeFont*ScaleW >= SizeFont) {
        
    }else{
        SizeFont = SizeFont*ScaleW;
    }
    UIFont *font = [UIFont fontWithName:fontName size:SizeFont];
    if (font==nil) {
        font = [UIFont systemFontOfSize:SizeFont];
    }
    return font;
}


//设置字间距
+ (NSMutableAttributedString *)setFontSpace:(NSNumber*)space font:(UIFont *)font content:(NSString *)content{
    
    if (kStringIsEmpty(content)) {
        content = @"";
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSDictionary *contentDic = @{NSKernAttributeName:space,NSFontAttributeName:font};//字间距
    NSMutableAttributedString * contentString = [[NSMutableAttributedString alloc] initWithString:content attributes:contentDic];
    [contentString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    return contentString;
}
@end
