//
//  MyUUIDManager.h
//  GetUUid
//
//  Created by 掌金 on 16/4/21.
//  Copyright © 2016年 zhangjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUUIDManager: NSObject

+(void)saveUUID:(NSString *)uuid;

+(NSString *)getUUID;

@end
