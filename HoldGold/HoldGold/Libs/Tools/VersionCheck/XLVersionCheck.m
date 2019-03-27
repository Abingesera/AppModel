//
//  XLVersionCheck.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-27.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import "XLVersionCheck.h"

@implementation XLVersionCheck


+ (instancetype)shared {
    static XLVersionCheck *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[XLVersionCheck alloc] init];
    });
    
    return _shared;
}

- (void)startCheckOperate{
    NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];
    
    if (kDictIsEmpty(appInfo)) {
        return;
    }
    
    NSDictionary *dict = appInfo[@"version"];
    
    if ([self versionCompare:CurrentAppVersion serverVersion:[NSString stringWithFormat:@"%@",dict[@"version"]]]) {
        NSString *upclue = dict[@"upclue"];
        if ([dict[@"force"] integerValue] == 1) {//强制更新
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"新版本必须更新!" message:kStringIsEmpty(upclue)?@"1:BUG修复":upclue preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];
                NSString *URLString = [appInfo[@"version"] objectForKey:@"download"];
                
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLString]])
                    
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
                }
                
            }];
            [actionSheet addAction:action1];
            
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
          [appdelegate.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];
            
        }else{
            
            NSString *no_version = [[NSUserDefaults standardUserDefaults] objectForKey:VersionUpdateReminde];
            
            if (![dict[@"version"] isEqualToString:no_version]) {
     
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"有新版本了" message:kStringIsEmpty(upclue)?@"1:BUG修复":upclue preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];
                    NSString *URLString = [appInfo[@"version"] objectForKey:@"download"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
                }];
                
                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不再提醒" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",dict[@"version"]] forKey:VersionUpdateReminde];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }];
                [actionSheet addAction:action1];
                [actionSheet addAction:action2];
                AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                [appdelegate.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];
            }
            
            
        }
        
    }
}

- (BOOL)versionCompare:(NSString *)appVersion serverVersion:(NSString *)sv{
    NSArray *av_arr = [appVersion componentsSeparatedByString:@"."];
    
    NSArray *sv_arr =  [sv componentsSeparatedByString:@"."];
    
    
    if (av_arr.count != 3 || sv_arr.count != 3) {
        return NO;
    }
    
    if ([av_arr[0] intValue]<[sv_arr[0] intValue]) {
        return YES;
    }else if ([av_arr[1] intValue]<[sv_arr[1] intValue] && [av_arr[0] intValue] == [sv_arr[0] intValue]) {
        return YES;
    }else if ([av_arr[2] intValue]<[sv_arr[2] intValue] && [av_arr[1] intValue] == [sv_arr[1] intValue] && [av_arr[0] intValue] == [sv_arr[0] intValue]){
        return YES;
    }
    
    return NO;
    
}

@end
