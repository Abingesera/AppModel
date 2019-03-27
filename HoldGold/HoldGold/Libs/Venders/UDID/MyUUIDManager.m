//
//  MyUUIDManager.m
//  GetUUid
//
//  Created by 掌金 on 16/4/21.
//  Copyright © 2016年 zhangjin. All rights reserved.
//


#import "MyUUIDManager.h"
#import "MyKeyChainManager.h"

@implementation MyUUIDManager
//这里需要修改为你自己的AppIdentifier
static NSString * const KEY_IN_KEYCHAIN = @"com.myuuid.uuid ＋ AppIdentifier";


+(void)saveUUID:(NSString *)uuid{
    if (uuid && uuid.length > 0) {
        [MyKeyChainManager save:KEY_IN_KEYCHAIN data:uuid];
    }
}

+(NSString *)getUUID{
//    //先获取keychain里面的UUID字段，看是否存在
//    NSString *uuid = (NSString *)[MyKeyChainManager load:KEY_IN_KEYCHAIN];
//    
//    //如果不存在则为首次获取UUID，所以获取保存。
//    if (!uuid || uuid.length == 0) {
//        CFUUIDRef puuid = CFUUIDCreate( nil );
//        
//        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
//        
//        uuid = [NSString stringWithFormat:@"%@", uuidString];
//        
//        [self saveUUID:uuid];
//        
//        CFRelease(puuid);
//        
//        CFRelease(uuidString);
//    }
//    
//    return uuid;
    
    //先获取keychain里面的UUID字段，看是否存在
    NSString *uuid = (NSString *)[MyKeyChainManager load:KEY_IN_KEYCHAIN];
    
    //如果不存在则为首次获取UUID，所以获取保存。
    if (!uuid || uuid.length == 0) {
        //        CFUUIDRef puuid = CFUUIDCreate( nil );
        //
        //        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        //
        //        uuid = [NSString stringWithFormat:@"%@", uuidString];
        
        
        NSString *macaddress;
        
        if (isIOS7) {
            
            macaddress = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            
        }else{
            
            macaddress =  [[UIDevice currentDevice] macaddress];
            
        }
        
        NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
        
        
        
        NSString *stringToHash = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
        
        
        
        NSString *uniqueIdentifier = [XLEncrytHelper md5:stringToHash];
        
        
        
        [self saveUUID:uniqueIdentifier];
        
        uuid = uniqueIdentifier;
        
        //        CFRelease(puuid);
        //
        //        CFRelease(uuidString);
    }
    
    return uuid;
}

@end
