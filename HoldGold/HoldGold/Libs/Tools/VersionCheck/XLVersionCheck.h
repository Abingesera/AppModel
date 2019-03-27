//
//  XLVersionCheck.h
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-27.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLVersionCheck : NSObject

+ (XLVersionCheck *)shared;

- (void)startCheckOperate;
@end
