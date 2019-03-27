//
//  XLArchiverHelper.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-31.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//


@interface XLArchiverHelper : NSObject

+ (void) setObject:(NSData *) data forKey:(NSString *) key withExpires:(int) expires;
+ (NSData *) get:(NSString *) key;

+ (BOOL)isExpired:(NSString *) key;

+ (void)setObject:(id)object forKey:(NSString*)key;
+ (id)getObject:(NSString*)key;



+ (void)writeObjectToDocument:(id)object;
+ (id)getObjectFromDocument;
//+ (id)getNewObject:(NSString *)key;

@end
