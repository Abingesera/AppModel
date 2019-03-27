//
//  PublicTool.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicTool : NSObject

#pragma mark 获取设备id
+ (NSString *)deviceId;

#pragma mark 获取手机型号
+ (NSString *)iphoneType;

#pragma mark 使用md5加密字符串
+ (NSString*)getmd5WithString:(NSString *)string;

#pragma mark 获取本机ip地址
+ (NSString *)getIPAddress;

#pragma mark toast提示信息
+ (void)toastRemindWithRemindStr:(NSString *)remindStr;

#pragma mark 判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile;

#pragma mark 利用正则表达式验证邮箱格式是否正确
+ (BOOL)isAvailableEmail:(NSString *)email;

#pragma mark 全屏截图
+ (UIImage *)shotScreen;

@end

NS_ASSUME_NONNULL_END
