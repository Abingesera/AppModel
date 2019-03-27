//
//  SystemApi.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "SystemApi.h"

@implementation SystemApi

#pragma mark 初始化接口
+ (void)initWithDict:(NSMutableDictionary *)paramDict succ:(RequestBlock)succ fail:(RequestBlock)fail {
    
    if (kDictIsEmpty(paramDict)) {
        return;
    }
    
    NSString *jsonString = [NetParam handleParameterPost:paramDict key:Root_Key token:Root_Token];
    
    [NetRequest postWithUrlString:[NSString stringWithFormat:@"%@%@%@",Root_Url,System_Api,System_Api_Init] parameters:jsonString success:^(id data) {
        
        NSString *stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *json = [XLEncrytHelper newDesDecryptStr:stringFromData key:Root_Key];
        NSDictionary *tempdict = [json dictionaryWithJsonString:json];
        
        if (!kDictIsEmpty(tempdict)) {
            
            if ([tempdict[@"s"] integerValue] == 200) {//初始化成功
                
                NSDictionary *appInfo = tempdict[@"d"];
                if (!kDictIsEmpty(appInfo)) {
                    [XLArchiverHelper setObject:appInfo forKey:App_Info];//缓存app信息
                    
                }else {
                    
                }
                if ([appInfo[@"deviceStaus"] integerValue] == 0) {//账号正常
                    
                    succ(@"初始化成功");
                    
                }else if ([appInfo[@"deviceStaus"] integerValue] == 400) {//账号被拉黑
                    
                    fail(@"400");
                }
                
            }else {
                NSString *errorMsg = [NSString stringWithFormat:@"%@",tempdict[@"d"]];
                fail(errorMsg);
            }
            
        }else {
            fail(@"初始化失败");
        }
        
    } failure:^(NSError *error) {
        fail(@"网络请求失败");
    }];
    
}

@end
