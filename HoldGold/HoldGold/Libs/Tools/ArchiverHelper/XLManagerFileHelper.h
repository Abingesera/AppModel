//
//  XLManagerFileHelper.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-31.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface XLManagerFileHelper : NSObject

+ (NSString *)getTempPath:(NSString*)key;
+ (NSString *)getDocumentPath:(NSString*)key;

+ (BOOL)fileExists:(NSString *)filepath;

+ (BOOL)writeImageToPath:(NSString *)path image:(UIImage *)image;
+ (BOOL)writeImageToPath:(NSString *)path imageUrl:(NSString *)url;
@end
