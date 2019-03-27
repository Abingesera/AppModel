//
//  MBProgressHUD+Common.m
//  NewHoldGold
//
//  Created by zsgjs on 2017/12/4.
//  Copyright © 2017年 掌金. All rights reserved.
//

#import "MBProgressHUD+Common.h"

@implementation MBProgressHUD (Common)

+(void)showNormalMBPHudWithString:(NSString *)string{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
//    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//顶层窗口
    [window addSubview:HUD];
    HUD.minShowTime = 1.0;
    HUD.labelText = string;
    HUD.labelFont = [FontTool setRegularFontWithSizeNumber:FontFourSizeNumber];
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

+ (void)showNormalMBPHudWithString:(NSString *)string complectionBlock:(void(^)(void))complectionBlock{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
//    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//顶层窗口
    [window addSubview:HUD];
    HUD.minShowTime = 1.0;
    HUD.labelText = string;
    HUD.labelFont = [FontTool setRegularFontWithSizeNumber:FontFourSizeNumber];
    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        complectionBlock();
        [HUD removeFromSuperview];
    }];
}

@end
