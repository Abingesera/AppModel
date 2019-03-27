//
//  NSObjectAutoEncodeDecode.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 14-1-16.
//  Copyright (c) 2014年 zsgjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObjectAutoEncodeDecode : NSObject
+ (void)encodeObject:(id)obj withCoder:(NSCoder *)encoder;

+ (id)initObject:(id)obj withCoder:(NSCoder *)decoder;
@end
