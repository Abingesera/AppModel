//
//  NSArray+Common.m
//  MALToolKit
//
//  Created by wxw on 14-6-30.
//  Copyright (c) 2014年 qianmiao. All rights reserved.
//

#import "NSArray+Common.h"

@implementation NSArray (Common)

// JSON
+ (instancetype)arrayWithJSONString:(NSString*)JSONString
{
    NSData* JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    if (JSONData) {
        NSArray* array = [[self class] arrayWithJSONData:JSONData];
        return array;
    }

    return nil;
}

+ (instancetype)arrayWithJSONData:(NSData*)JSONData
{
    NSError* error = nil;
    NSArray* array = [NSJSONSerialization JSONObjectWithData:JSONData
                                                     options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments
                                                       error:&error];
    if (error) {
        NSLog(@"error : %@", [error description]);
    }
    return array;
}

- (NSString*)toUTF8JSONString
{
    NSString* JSONString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData* JSONData = [self toJSONData];
        if (JSONData) {
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
    }

    return JSONString;
}

- (NSData*)toJSONData
{
    NSData* JSONData = nil;
    NSError* error = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        JSONData = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        if (error) {
            NSLog(@"error : %@", [error description]);
        }
    }

    return JSONData;
}

- (NSArray *)filterObjectsByKey:(NSString *)key
{
    NSMutableSet *tempValues = [[NSMutableSet alloc] init];
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if(![tempValues containsObject:[obj valueForKey:key]]) {
            [tempValues addObject:[obj valueForKey:key]];
            [result addObject:obj];
        }
    }
    return result;
}

//过滤邮箱解析失败的联系人
- (NSArray *)filterContactObjectsBykey:(NSString *)key
{
    NSMutableSet *tempValues = [[NSMutableSet alloc] init];
    NSMutableArray *result = [NSMutableArray array];
    
    for (id obj in self) {
        if (![tempValues containsObject:[obj valueForKey:key]]) {
            if ([obj valueForKey:key]) {
                [tempValues addObject:[obj valueForKey:key]];
            }
            [result addObject:obj];
        }
    }
    
    return result;
}

@end
