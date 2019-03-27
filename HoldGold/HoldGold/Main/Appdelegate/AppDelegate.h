//
//  AppDelegate.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL isLandscape;//是否横屏
@property (nonatomic,assign)AFNetworkReachabilityStatus netStatus;//网络状态
@end

