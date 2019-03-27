//
//  XLManagerFileHelper.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-31.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import "XLManagerFileHelper.h"

@implementation XLManagerFileHelper

+ (NSString *)getTempPath:(NSString*)key{
    //	NSString *tempPath = NSTemporaryDirectory(); // 此处使用的师temp文件夹
    
    //1, 此处使用的是library/catch文件夹
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *tempPath = [paths firstObject];
    
    //    2, 获取Documents目录路径的方法：
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *docDir = [paths objectAtIndex:0];
    
    
    return [tempPath stringByAppendingPathComponent:key];
}

+ (BOOL)fileExists:(NSString *)filepath{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filepath]) {
        return YES;
    }else{
    
        return NO;
    }
    
	return [fileManager fileExistsAtPath:filepath];
}

+ (BOOL)writeImageToPath:(NSString *)path image:(UIImage *)image{
    NSData *data = UIImagePNGRepresentation(image);
    return [data writeToFile:path atomically:YES];
}

+ (BOOL)writeImageToPath:(NSString *)path imageUrl:(NSString *)url{
    
#pragma mark  处理图片，http->https请求  img1.zsgjs.com
//    NSString *imgUrl = [ZJPublics HttpsInsteadofhttp:url];

//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [data writeToFile:path atomically:YES];
}

+ (NSString *)getDocumentPath:(NSString*)key{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingPathComponent:key];
}
@end
