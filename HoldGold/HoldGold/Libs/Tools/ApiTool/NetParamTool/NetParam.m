//
//  NetParam.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "NetParam.h"

@implementation NetParam

#pragma mark 处理网络请求的参数，返回加密后的url，再调用RCNetRequestTool进行请求
+ (NSString *)handleParameterPost:(NSMutableDictionary *)dict key:(NSString *)key token:(NSString *)token{
    
    // 定义字典进行P的赋值
    NSMutableDictionary *pDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    //获取当前时间的秒数，即为token的值
    NSDate *now = [NSDate date];
    NSTimeInterval nowT  = [now timeIntervalSince1970]*1;
    long long int date = (long long int)nowT;
    NSString *time = [NSString stringWithFormat:@"%lld",date];
    
    // 参数的拼接 os和token
    [pDict setObject:[NSString stringWithFormat:@"%@&%@", time, token] forKey:@"token"];
    [pDict setObject:@"iPhone" forKey:@"os"];
    NSString *pString = [pDict JSONString];
    
    NSString *string = [NSString stringWithFormat:@"p=%@", [XLEncrytHelper newDesEncryptStr:pString key:key]];
    
    return string;
    
}


#pragma mark 处理get请求的参数
+ (NSString *)handleParameterGet:(NSString *)url secondUrl:(NSString *)secondUrl key:(NSString *)key flag:(NSInteger)flag{
    
    NSString *encryUrl = nil;
    
    if ([secondUrl rangeOfString:@"&"].location != NSNotFound) {
        
        NSLog(@"这个字符串中有a");
        
        NSString *tt =   [[secondUrl componentsSeparatedByString:@"&"] lastObject];
        NSString *ttLast = [[tt componentsSeparatedByString:@"="] lastObject];
        NSString *ttLastEN = [XLEncrytHelper newDesEncryptStr:ttLast key:key];
        NSString *newtt = [[[tt componentsSeparatedByString:@"="] firstObject] stringByAppendingFormat:@"=%@",ttLastEN];
        
        
        NSString *tid =   [[[[secondUrl componentsSeparatedByString:@"&"] firstObject] componentsSeparatedByString:@"="] lastObject];
        
        NSString *tidLastEN = [XLEncrytHelper newDesEncryptStr:tid key:key];
        NSString *newtid = [[[[[secondUrl componentsSeparatedByString:@"&"] firstObject] componentsSeparatedByString:@"="] firstObject] stringByAppendingFormat:@"=%@",tidLastEN];
        
        encryUrl = [newtid stringByAppendingFormat:@"&%@",newtt];
        
    }else{
        NSString *SPTid =   [[secondUrl componentsSeparatedByString:@"="] lastObject];
        NSString *encrySPTid = [XLEncrytHelper newDesEncryptStr:SPTid key:key];
        NSString *encrySPTidEqual = [NSString stringWithFormat:@"=%@",encrySPTid];
        encryUrl = [[[secondUrl componentsSeparatedByString:@"="] firstObject] stringByAppendingString:encrySPTidEqual];
    }
    
    
    //地址的拼接
    encryUrl = [url stringByAppendingString:encryUrl];
    //获取当前时间的秒数，即为token的值
    NSDate *now = [NSDate date];
    NSTimeInterval nowT  = [now timeIntervalSince1970]*1;
    long long int date = (long long int)nowT;
    NSString *time = [NSString stringWithFormat:@"%lld",date];
    NSString *token = [NSString stringWithFormat:@"%@&s1GKMGi0fbi0",time];
    //对token加密并拼接
    token = [XLEncrytHelper newDesEncryptStr:token key:key];
    
    //将token值与H和P参数进行拼接
    //encryUrl = [NSString stringWithFormat:@"%@&token=%@",encryUrl ,token];
    encryUrl = [NSString stringWithFormat:@"%@?token=%@",encryUrl ,token];
    
    
    return encryUrl;
}

@end
