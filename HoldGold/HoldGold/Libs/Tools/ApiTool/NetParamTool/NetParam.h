//
//  NetParam.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetParam : NSObject

/**
 *  处理post请求的参数
 *
 *  @param dict     请求参数
 *  @param key     加解密的key
 *  @param token    加解密的token
 */
+ (NSString *)handleParameterPost:(NSMutableDictionary *)dict key:(NSString *)key token:(NSString *)token;


/**
 *  处理get请求的参数
 *
 *  @param url     地址
 *  @param key    加解密的key
 *  @param flag    区分用
 */
+ (NSString *)handleParameterGet:(NSString *)url secondUrl:(NSString *)secondUrl key:(NSString *)key flag:(NSInteger)flag;

@end

NS_ASSUME_NONNULL_END
