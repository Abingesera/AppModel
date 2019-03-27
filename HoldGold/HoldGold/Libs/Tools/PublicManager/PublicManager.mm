//
//  PublicManager.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "PublicManager.h"
#import <WCDB/WCDB.h>

@interface PublicManager ()

@property (nonatomic, strong) NSLock *lock;

@end

@implementation PublicManager

SingletonM(Manager)

-(instancetype)init{
    self = [super init];
    if (self) {
        _lock = [[NSLock alloc] init];
    }
    return self;
}

-(WCTDatabase *)defaultDataBase{
    [self.lock lock];
    if (!_defaultDataBase) {
        _defaultDataBase = [[WCTDatabase alloc] initWithPath:[self getDataBasePath]];
    }
    [self.lock unlock];
    return _defaultDataBase;
}

- (void)creatDataBaseDefaultTable{
    
//    BOOL result = [self.defaultDataBase createTableAndIndexesOfName:[RCOutsLiveMessage tableName] withClass:RCOutsLiveMessage.class];
//    if (result) {
//        NSLog(@"创建表 RCOutsLiveMessage 成功");
//    }else{
//        NSLog(@"创建表 RCOutsLiveMessage 失败");
//    }
}

- (NSString *)getDataBasePath {
    NSString *databasePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database/HoldGoldDataBase"];
    databasePath = [databasePath stringByAppendingPathComponent:@"user.db"];
    return databasePath;
}
@end
