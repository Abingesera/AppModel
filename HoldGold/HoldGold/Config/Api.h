//
//  Api.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#ifndef Api_h
#define Api_h

#pragma mark 应用整体环境配置  //1 为正式环境   0 为测试环境

#if 1

#define Root_Url             @"https://qzjapi.zsgjs.com/ZJApi/" //正式环境

//加解密key,token
#define Root_Key            @"ZiAQG5OC"//key
#define Root_Token          @"7z0d2rqsqNav4EAY"//token

//友盟
#define UMeng_AppKey           @"54126d78fd98c50a4f000783"//正式

//微信支付
#define WXPay_AppID         @"wx47dfa927afee418d"
#define WX_AppSecret      @"022bedc4609814c5adb36130757d4981"

//友盟分享
/*微信*/
#define WXShare_AppID    @"wx47dfa927afee418d"  //微信支付的
#define WXShare_AppSecret   @"022bedc4609814c5adb36130757d4981"
/*QQ*/
#define TencentShare_AppID  @"1101052389"
#define TencentShare_AppSecret @"YA6JPkaZL3h2AJ5l"
/*sina*/
#define WBShare_AppKey   @"2493576479"
#define WBShare_AppSecret  @"64a4c35dcad2c2f6b35d7016cff50302"

////个推SDK 正式
#define GeTui_AppID         @"X013So0SfM6LUq2UkTkNV6"
#define GeTui_AppKey        @"gwXP9lffn1ACvlAHYcA0Y1"
#define GeTui_AppSecret     @"VKi951wBW09ohyI7lyfvr1"

//极光推送
#define JPush_AppKey  @"d8363d6f16a9cd4b92a6e163"

#else



#endif

#endif /* Api_h */
