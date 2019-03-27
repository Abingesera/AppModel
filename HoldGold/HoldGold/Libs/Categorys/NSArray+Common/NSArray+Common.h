//
//  NSArray+Common.h
//  MALToolKit
//
//  Created by wxw on 14-6-30.
//  Copyright (c) 2014年 qianmiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Common)

// JSON
+ (instancetype)arrayWithJSONString:(NSString *)JSONString;
+ (instancetype)arrayWithJSONData:(NSData *)JSONData;
- (NSString *)toUTF8JSONString;
- (NSData *)toJSONData;
- (NSArray *)filterObjectsByKey:(NSString *)key;

- (NSArray *)filterContactObjectsBykey:(NSString *)key;
@end
