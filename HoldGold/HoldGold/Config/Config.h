//
//  Config.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define kAppDelegate                ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kAppWindow                  ([UIApplication sharedApplication].delegate.window)

#pragma mark 判断字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || str == NULL || [str length] < 1 ? YES : NO )

#pragma mark 判断数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#pragma mark 判断字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define isPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// 状态栏高度
#define STATUS_BAR_HEIGHT (isPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (isPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (isPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (isPhoneX ? 34.f : 0.f)

#pragma mark 获取屏幕宽度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#pragma mark 获取屏幕高度
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark 获取APP版本号
#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#pragma mark 获取手机系统
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

#pragma mark 手机系统判定
#define isIOS7 CurrentSystemVersion>=7
#define isIOS8 CurrentSystemVersion>=8
#define isIOS9 CurrentSystemVersion>=9
#define isIOS10 CurrentSystemVersion>=10
#define isIOS11 CurrentSystemVersion>=11

#pragma mark 判断是否是iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#pragma mark 判断手机尺寸
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREENH_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREENH_HEIGHT))
#define IPHONE_35_inch (isPhone && SCREEN_MAX_LENGTH < 568.0) //320*480
#define IPHONE_40_inch (isPhone && SCREEN_MAX_LENGTH == 568.0)//320*568
#define IPHONE_47_inch (isPhone && SCREEN_MAX_LENGTH == 667.0)//375*667
#define IPHONE_55_inch (isPhone && SCREEN_MAX_LENGTH == 736.0)//414*736
#define IPHONE_X_inch (isPhone && SCREEN_MAX_LENGTH == 812.0)//375*812  X,XS
#define IPHONE_XR_inch (isPhone && SCREEN_MAX_LENGTH == 896.0)//414*896  5.94英寸XR，6.2英寸XSMax

#define ScaleW (SCREEN_WIDTH/375)
#define ScaleH (SCREENH_HEIGHT/667)

#pragma mark 颜色设置
#define RGBAColor(r, g, b, a)   [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

#endif /* Config_h */
