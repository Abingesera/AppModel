//
//  AppDelegate+Config.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "AppDelegate+Config.h"

@implementation AppDelegate (Config)

#pragma mark 配置友盟
- (void)registerUMeng{
    //初始化友盟统计
    [UMConfigure initWithAppkey:UMeng_AppKey channel:@"App Store"];
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
    [MobClick setCrashReportEnabled:YES];
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:NO];
    //    //设置友盟appkey
    //    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_AppKey];
    // U-Share 平台设置
    [self configUSharePlatforms];
}

#pragma mark 友盟分享设置
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXPay_AppID appSecret:WX_AppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:TencentShare_AppID/*设置QQ平台的appID*/  appSecret:TencentShare_AppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret https://api.weibo.com/oauth2/default.html*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WBShare_AppKey  appSecret:WBShare_AppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

#pragma mark 数据库配置

-(void)creatDB{
    [[PublicManager sharedManager] defaultDataBase];
    [[PublicManager sharedManager] creatDataBaseDefaultTable];
}

@end
