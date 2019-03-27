//
//  NSDictionary+Common.m
//  NewHoldGold
//
//  Created by zsgjs on 2018/3/20.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)

#pragma mark - JSON
+ (instancetype)dictionaryWithJSONString:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    if (JSONData)
    {
        NSDictionary *dictionary = [[self class] dictionaryWithJSONData:JSONData];
        return dictionary;
    }
    return nil;
}

+ (instancetype)dictionaryWithJSONData:(NSData *)JSONData
{
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                               options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments
                                                                 error:&error];
    if (error)
    {
        NSLog(@"error : %@", [error description]);
    }
    return dictionary;
}

- (NSString *)toUTF8JSONString
{
    NSString *JSONString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *JSONData = [self toJSONData];
        if (JSONData)
        {
            JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
        }
    }
    
    return JSONString;
}

- (NSData *)toJSONData
{
    NSData *JSONData = nil;
    NSError *error = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        JSONData = [NSJSONSerialization dataWithJSONObject:self
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        if (error)
        {
            NSLog(@"error : %@", [error description]);
        }
    }
    return JSONData;
}

@end
