//
//  DBProtocol.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DBProtocol <NSObject>

@optional
//插入或者更新 单条数据
- (void)insertOrReplaceInDataBase;

//插入 / 更新 多条数据
+ (void)insertOrReplaceInDataBaseWithObjects:(NSArray *)objects;


//删除 单条数据
- (void)deletedObjectInDataBase;


@required
//数据库中的 表 表名
+ (NSString *)tableName;

@end
