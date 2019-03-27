//
//  SystemApi.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SystemApi : NSObject

#define System_Api @"SystemApi/"

#define System_Api_Init @"Init"//初始化接口

/**
 *  成功回调
 */
typedef void (^RequestBlock)(id data);

/**
 *  初始化接口
 *
 *  @param paramDict 请求参数
 *  @param succ  成功回调
 *  @param fail  失败回调
 *
 */
+ (void)initWithDict:(NSMutableDictionary *)paramDict succ:(RequestBlock)succ fail:(RequestBlock)fail;

@end

