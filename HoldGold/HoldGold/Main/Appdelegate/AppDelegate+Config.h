//
//  AppDelegate+Config.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Config)

//配置 友盟
- (void)registerUMeng;


//数据库 配置
-(void)creatDB;

@end

NS_ASSUME_NONNULL_END
