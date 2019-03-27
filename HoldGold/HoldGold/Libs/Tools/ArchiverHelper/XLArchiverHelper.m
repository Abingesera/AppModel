//
//  XLArchiverHelper.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-31.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import "XLArchiverHelper.h"
#import "XLManagerFileHelper.h"
#define ZY_CACHE_EXPIRATION_AGE_NEVER     (1.0 / 0.0)   // inf

@implementation XLArchiverHelper

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires{
    NSDate *dt = [NSDate date];
    double now = [dt timeIntervalSince1970];
    NSMutableString *expiresString = [[NSMutableString alloc] init];
    NSData *dataExpires = [[expiresString stringByAppendingFormat:@"%f",now+expires] dataUsingEncoding:NSUTF8StringEncoding];
    [dataExpires writeToFile:[[XLManagerFileHelper getTempPath:key] stringByAppendingFormat:@"%@",@".expires"] atomically:NO];
    [data writeToFile:[XLManagerFileHelper getTempPath:key] atomically:NO];
    //    NSData *data2 = [NSData dataWithContentsOfFile:[XLManagerFileHelper getTempPath:key]];
    
}

+ (NSData *) get:(NSString *) key{
    __block NSData *data = [NSData data];
    dispatch_queue_t queue = dispatch_queue_create("com.getData.queue", DISPATCH_CURRENT_QUEUE_LABEL);
    
    dispatch_async(queue, ^ {
        if(![XLManagerFileHelper fileExists:[XLManagerFileHelper getTempPath:key]] || [self isExpired:[XLManagerFileHelper getTempPath:key]]){
            data = nil;
            //            return nil;
        } else {
            data = [NSData dataWithContentsOfFile:[XLManagerFileHelper getTempPath:key]];
        }
        
    });
    
    dispatch_barrier_sync(queue, ^{
        
    });
    
    return data;
}

+ (void)setObject:(id)object forKey:(NSString*)key
{
    dispatch_queue_t queue = dispatch_queue_create("com.saveData.queue", DISPATCH_CURRENT_QUEUE_LABEL);
    dispatch_async(queue, ^{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        [XLArchiverHelper setObject:data forKey:key withExpires:ZY_CACHE_EXPIRATION_AGE_NEVER];
    });
    dispatch_barrier_sync(queue, ^{
        
    });
}

+ (id)getObject:(NSString*)key
{
    @try {
        __block NSData *data = [NSData data];
        dispatch_queue_t queue = dispatch_queue_create("com.getData.queue", DISPATCH_CURRENT_QUEUE_LABEL);
        dispatch_async(queue, ^{
            NSData *getData = [XLArchiverHelper get:key];
            if (kStringIsEmpty(getData)) {
                data = nil;
            } else {
                data = [NSKeyedUnarchiver unarchiveObjectWithData:getData];
            }
            
        });
        
        dispatch_barrier_sync(queue, ^{
            
        });
        
        return data;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

// 新版本读本地方法
//+ (id)getNewObject:(NSString *)key{
//
//    NSData *data = [NSData dataWithContentsOfFile:[XLManagerFileHelper getTempPath:key]];
//
//    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//
//    return object;
//}
+ (BOOL)isExpired:(NSString *) key{
    NSData *data = [NSData dataWithContentsOfFile:[key stringByAppendingFormat:@"%@",@".expires"]];
    NSString *expires = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    double exp = [expires doubleValue];
    NSDate *dt = [NSDate date];
    double value = [dt timeIntervalSince1970];
    
//    NSLog(@"%f,%f",exp,value);
    
    //	if(exp > value){
    //
    //		return NO;
    //	}
    //	return YES;
    return NO;
}
+ (void)writeObjectToDocument:(id)object{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [data writeToFile:[XLManagerFileHelper getDocumentPath:@"cricleHomeDataPath"] atomically:YES];
}
#pragma mark -- 从本地获取数据
+ (id)getObjectFromDocument{
    NSData *data = [NSData dataWithContentsOfFile:[XLManagerFileHelper getDocumentPath:@"cricleHomeDataPath"]];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}
@end
