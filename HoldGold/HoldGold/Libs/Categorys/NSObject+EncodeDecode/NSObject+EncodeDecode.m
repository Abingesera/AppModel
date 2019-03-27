//
//  NSObject+EncodeDecode.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 14-1-16.
//  Copyright (c) 2014年 zsgjs. All rights reserved.
//

#import "NSObject+EncodeDecode.h"


@implementation NSObject (EncodeDecode)
- (void)encodeWithCoder:(NSCoder *)encoder {
	[NSObjectAutoEncodeDecode encodeObject:self withCoder:encoder];
}

- (id)initWithCoder:(NSCoder *)decoder {
	self = [self init];
    if (self) {
        
    }
    return [NSObjectAutoEncodeDecode initObject:self withCoder:decoder];
}

@end
