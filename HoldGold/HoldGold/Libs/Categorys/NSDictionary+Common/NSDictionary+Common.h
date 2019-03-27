//
//  NSDictionary+Common.h
//  NewHoldGold
//
//  Created by zsgjs on 2018/3/20.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Common)
// JSON
+ (instancetype)dictionaryWithJSONString:(NSString *)JSONString;
+ (instancetype)dictionaryWithJSONData:(NSData *)JSONData;
- (NSString *)toUTF8JSONString;
- (NSData *)toJSONData;

@end
