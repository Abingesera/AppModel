//
//  PublicManager.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCTDatabase;


@interface PublicManager : NSObject

SingletonH(Manager)


@property (nonatomic,copy)NSString *registrationID;//极光推送用户cid

@property (nonatomic,copy)NSString *clientID;//个推返回的cid

@property (nonatomic,copy)NSString *deviceToken;


//默认数据库
@property (nonatomic,strong) WCTDatabase *defaultDataBase;

//建表
- (void)creatDataBaseDefaultTable;

@end

