//
//  MBProgressHUD+Common.h
//  NewHoldGold
//
//  Created by zsgjs on 2017/12/4.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Common)

+ (void)showNormalMBPHudWithString:(NSString *)string;

+ (void)showNormalMBPHudWithString:(NSString *)string complectionBlock:(void(^)(void))complectionBlock;

@end
