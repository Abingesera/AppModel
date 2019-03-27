//
//  MyKeyChainManager.h
//  GetUUid
//
//  Created by 掌金 on 16/4/21.
//  Copyright © 2016年 zhangjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyKeyChainManager : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

@end
