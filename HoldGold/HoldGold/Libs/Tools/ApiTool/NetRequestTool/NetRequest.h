//
//  NetRequest.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetRequest : NSObject

//宏定义成功block 回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block 回调失败信息
typedef void (^HttpFailure)(NSError *error);

/**
 *  GET请求
 *
 *  @param urlString  请求地址
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;


/**
 *  POST请求
 *
 *  @param urlString  请求地址
 *  @param parameters 请求参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)postWithUrlString:(NSString *)urlString parameters:(id )parameters success:(HttpSuccess)success failure:(HttpFailure)failure;


@end

NS_ASSUME_NONNULL_END
