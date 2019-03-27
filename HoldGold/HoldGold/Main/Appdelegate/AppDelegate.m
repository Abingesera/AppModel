//
//  AppDelegate.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<GeTuiSdkDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate,LoadingPageDelegate>

@property (nonatomic,assign)BOOL isJPush;
@property (nonatomic,strong)NSDictionary *pushDict;//极光推送

@end

@implementation AppDelegate

-(NSDictionary *)pushDict {
    
    if (!_pushDict) {
        _pushDict = [[NSDictionary alloc]init];
    }
    
    return _pushDict;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //注册友盟
    [self registerUMeng];

    //注册个推
    [GeTuiSdk startSdkWithAppId:GeTui_AppID appKey:GeTui_AppKey appSecret:GeTui_AppSecret delegate:self];

    // 注册 APNs
    [self registerRemoteNotification];

    //初始化数据库
    [self creatDB];

    //Required ----注册极光推送apns
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setLogOFF];

    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPush_AppKey channel:@"App Store" apsForProduction:NO advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);//1517bfd3f7cce356a02
            [PublicManager sharedManager].registrationID = registrationID;//保存极光推送用户cid
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    //极光推送自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    self.isJPush = NO;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        self.isJPush = YES;
    });
    
    //创建网络监听管理器
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //设置监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                
            {
                [PublicTool toastRemindWithRemindStr:@"当前网络不可识别"];
            }
                
                self.netStatus = AFNetworkReachabilityStatusUnknown;
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
            {
                
                [PublicTool toastRemindWithRemindStr:@"网络异常"];
            }
                
                self.netStatus = AFNetworkReachabilityStatusNotReachable;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2G,3G,4G...的网络");
                if (self.netStatus == AFNetworkReachabilityStatusNotReachable || self.netStatus == AFNetworkReachabilityStatusUnknown) {
                    [self downInitAPP];
                }
                self.netStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi的网络");
                if (self.netStatus == AFNetworkReachabilityStatusNotReachable || self.netStatus == AFNetworkReachabilityStatusUnknown) {
                    [self downInitAPP];
                }
                self.netStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoadingController *loadingVC = [[LoadingController alloc]init];
    loadingVC.delegate = self;
    self.window.rootViewController = loadingVC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIDeviceOrientation orientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
        self.isLandscape = YES;
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.isLandscape = NO;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 后台进前台固定横屏模式
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_isLandscape) {
        UIDeviceOrientation orientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            return UIInterfaceOrientationMaskLandscape;
        }else { //横屏后旋转屏幕变为竖屏
            return UIInterfaceOrientationMaskPortrait;
        }
    }
    else
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}

#pragma mark - 远程通知注册成功委托
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    [PublicManager sharedManager].deviceToken = token;//保存devicetoken
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
    // Required - 极光推送注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
}


/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [PublicManager sharedManager].clientID = clientId;//保存用户cid
}

#pragma mark App收到远程推送
/*
 {
 "_ge_" = 1;
 "_gmid_" = "OSA-0707_33EqPlwinK6dzW5OWTOsL4:3ab0cb8d-a1-15d1ae14a7d-8828405079:309f3457b30ca85f93bf19c74c62a6de";
 "_gurl_" = "sdk.open.extension.getui.com:8123";
 aps =     {
 alert = "\U6ca1\U6709\U901a\U8fc7\U7533\U8bf7\U554a";
 badge = 0;
 category = ACTIONABLE;
 "content-available" = 1;
 "mutable-content" = 1;
 sound = default;
 };
 server = "{\"t\":\"200\",\"i\":\"124\"}";
 }
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    //静默推送收到消息后也需要将APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {//如果app在前台运行
        
    }else {//杀死状态下，直接跳转到跳转页面。
        NSDictionary *pushDic = [userInfo[@"server"] dictionaryWithJsonString:userInfo[@"server"]];
        [self pushSeverDisposeDict:pushDic];
    }
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

#pragma mark 收到透传消息
/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
    
    
    UIApplication *application = [UIApplication sharedApplication];
    
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {//如果app在前台运行
        NSDictionary *userInfo = [payloadMsg dictionaryWithJsonString:payloadMsg];//
        
        if (offLine) {//离线消息
            return;
        }
        
        UIApplication *application = [UIApplication sharedApplication];
        
        if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {//如果app在前台运行
            
            if ([userInfo isKindOfClass:[NSDictionary class]] && [userInfo allKeys].count>0) {
                self.pushDict = userInfo;
                [self showAlertViewUserInfo:userInfo];
            }
        }
    }
}


#pragma mark - JPUSHRegisterDelegate

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    if (self.isJPush) {
        NSDictionary * userInfo = [notification userInfo];
        NSString *content = [userInfo valueForKey:@"content"];
        UIApplication *application = [UIApplication sharedApplication];
        if (application.applicationState == UIApplicationStateActive) {//如果app在前台运行
            NSDictionary *pushDict = [content dictionaryWithJsonString:content];
            if ([pushDict isKindOfClass:[NSDictionary class]] && [pushDict allKeys].count>0) {
                self.pushDict = pushDict;
                [self showAlertViewUserInfo:pushDict];
            }
        }
    }
}


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    UIApplication *application = [UIApplication sharedApplication];
    if (application.applicationState == UIApplicationStateActive) {//如果app在前台运行 || application.applicationState == UIApplicationStateBackground
        if (!self.isJPush) {
            completionHandler(UNNotificationPresentationOptionAlert);
        }
    }else{
        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    NSDictionary *dict = [userInfo[@"server"] dictionaryWithJsonString:userInfo[@"server"]];
    [self pushSeverDisposeDict:dict];
}

#pragma mark - 打开系统推送后处理方法
-(void)pushSeverDisposeDict:(NSDictionary *)pushDic{
    
//    [XLArchiverHelper setObject:pushDic forKey:@"start_push"];
//    if (![_window.rootViewController isKindOfClass:[RCTabBarController class]]) {
//        return;
//    }
//    RCTabBarController *root = (RCTabBarController *)_window.rootViewController;
//    UINavigationController *nav = root.viewControllers[root.selectedIndex];
//    if ([pushDic[@"t"] integerValue] == 100){//直播详情
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        //        NSString *name = [[pushDic[@"i"] componentsSeparatedByString:@"&&"] objectAtIndex:2];
//        RCLiveModuleDetaileController *liveVC = [[RCLiveModuleDetaileController alloc]initWithVideoID:entityID streamID:@""];
//        [liveVC setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:liveVC animated:YES];
//    }else if ([pushDic[@"t"] integerValue] == 200){//订单详情(票务详情)
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        RCOrderDetailViewController *detailVC = [[RCOrderDetailViewController alloc]init];
//        detailVC.orderId = entityID;
//        [detailVC setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:detailVC animated:YES];
//    }else if ([pushDic[@"t"] integerValue] == 9999){//官方信息---不做处理
//
//    }else if ([pushDic[@"t"] integerValue] == 300) {//相册
//
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        RCPictureMainController *pictureMainVC = [[RCPictureMainController alloc]init];
//        [pictureMainVC setHidesBottomBarWhenPushed:YES];
//        pictureMainVC.substationID = [NSString stringWithFormat:@"%@",entityID];
//        [nav pushViewController:pictureMainVC animated:YES];
//
//    }else if ([pushDic[@"t"] integerValue] == 400) {//文章
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        RCNewsDetailController *detailVC = [[RCNewsDetailController alloc]initWithNewsID:[entityID integerValue]];
//        [detailVC setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:detailVC animated:YES];
//    }else if ([pushDic[@"t"] integerValue] == 500) {//视频
//
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        RCSmallVideoPlayAlertController *playAlertController = [RCSmallVideoPlayAlertController showPlayerAlertControllerWithUrl:nil title:nil backImageUrl:nil VideoType:VideoPlayTypeNormal];
//        playAlertController.videoId = entityID;
//        [playAlertController setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:playAlertController animated:YES];
//
//    }else if ([pushDic[@"t"] integerValue] == 600) {//商品
//
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        //进入 活动详情
//        RCTrackActivityDetailViewController *rcActivityDetailVC = [[RCTrackActivityDetailViewController alloc]init];
//        [rcActivityDetailVC addActivityDetailID:entityID];
//        [rcActivityDetailVC setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:rcActivityDetailVC animated:YES];
//
//    }else if ([pushDic[@"t"] integerValue] == 700) {//系统通知
//        NSString *entityID = [NSString stringWithFormat:@"%@",pushDic[@"i"]];
//        RCMsgDetailController *detailVC = [[RCMsgDetailController alloc]initWithSysMsgID:entityID];
//        [detailVC setHidesBottomBarWhenPushed:YES];
//        [nav pushViewController:detailVC animated:YES];
//
//        //更新本地缓存，判断系统消息小红点
//        [XLArchiverHelper setObject:entityID forKey:RCSysMsgLastID];
//        NSMutableArray *allIDs = [XLArchiverHelper getObject:RCSysMsgList_IDs];
//        if (allIDs) {
//            if (![allIDs containsObject:entityID]) {
//                [allIDs addObject:entityID];
//            }
//        }else {
//            allIDs = [[NSMutableArray alloc]init];
//            [allIDs addObject:entityID];
//        }
//        [XLArchiverHelper setObject:allIDs forKey:RCSysMsgList_IDs];
//
//        NSMutableArray *readIDs = [XLArchiverHelper getObject:RCSysMsgList_readIDs];
//        if (readIDs) {
//            if (![readIDs containsObject:entityID]) {
//                [readIDs addObject:entityID];
//            }
//        }else {
//            readIDs = [[NSMutableArray alloc]init];
//            [readIDs addObject:entityID];
//        }
//        [XLArchiverHelper setObject:readIDs forKey:RCSysMsgList_readIDs];
//    }
//
//
//    [XLArchiverHelper setObject:@"" forKey:@"start_push"];
}

#pragma mark -- 在线推送消息处理弹窗
-(void)showAlertViewUserInfo:(NSDictionary *)userInfo {
//    self.pushDict = userInfo;
//    NSString * message = userInfo[@"content"];
//    UIAlertController *alerC = [UIAlertController alertControllerWithTitle:@"推送消息" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alerC addAction:cancelAction];
//    if ([self.pushDict[@"features"] integerValue] !=  9999){//官方信息---不做处理
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            RCTabBarController *root = (RCTabBarController *)self.window.rootViewController;
//            UINavigationController *nav = root.viewControllers[root.selectedIndex];
//            if ([self.pushDict[@"features"] integerValue] == 100){//直播详情
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                //            NSString *name = [[self.pushDict[@"attach"] componentsSeparatedByString:@"&&"] objectAtIndex:2];
//                RCLiveModuleDetaileController *liveVC = [[RCLiveModuleDetaileController alloc]initWithVideoID:entityID streamID:@""];
//                [liveVC setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:liveVC animated:YES];
//            }else if ([self.pushDict[@"features"] integerValue] == 200){//订单详情
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                RCOrderDetailViewController *detailVC = [[RCOrderDetailViewController alloc]init];
//                detailVC.orderId = entityID;
//                [detailVC setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:detailVC animated:YES];
//            }else if([self.pushDict[@"features"] integerValue] == 300){//相册
//
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                RCPictureMainController *pictureMainVC = [[RCPictureMainController alloc]init];
//                [pictureMainVC setHidesBottomBarWhenPushed:YES];
//                pictureMainVC.substationID = [NSString stringWithFormat:@"%@",entityID];
//                [nav pushViewController:pictureMainVC animated:YES];
//
//            }else if ([self.pushDict[@"features"] integerValue] == 400) {//文章
//
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                RCNewsDetailController *detailVC = [[RCNewsDetailController alloc]initWithNewsID:[entityID integerValue]];
//                [detailVC setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:detailVC animated:YES];
//
//            }else if ([self.pushDict[@"features"] integerValue] == 500) {//视频
//
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                RCSmallVideoPlayAlertController *playAlertController = [RCSmallVideoPlayAlertController showPlayerAlertControllerWithUrl:nil title:nil backImageUrl:nil VideoType:VideoPlayTypeNormal];
//                playAlertController.videoId = entityID;
//                [playAlertController setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:playAlertController animated:YES];
//
//            }else if ([self.pushDict[@"features"] integerValue] == 600) {//商品
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                //进入 活动详情
//                RCTrackActivityDetailViewController *rcActivityDetailVC = [[RCTrackActivityDetailViewController alloc]init];
//                [rcActivityDetailVC addActivityDetailID:entityID];
//                [rcActivityDetailVC setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:rcActivityDetailVC animated:YES];
//
//
//            }else if ([self.pushDict[@"features"] integerValue] == 700){//系统通知
//                NSString *entityID = [NSString stringWithFormat:@"%@",self.pushDict[@"attach"]];
//                RCMsgDetailController *detailVC = [[RCMsgDetailController alloc]initWithSysMsgID:entityID];
//                [detailVC setHidesBottomBarWhenPushed:YES];
//                [nav pushViewController:detailVC animated:YES];
//
//                //更新本地缓存，判断系统消息小红点
//                [XLArchiverHelper setObject:entityID forKey:RCSysMsgLastID];
//                NSMutableArray *allIDs = [XLArchiverHelper getObject:RCSysMsgList_IDs];
//                if (allIDs) {
//                    if (![allIDs containsObject:entityID]) {
//                        [allIDs addObject:entityID];
//                    }
//                }else {
//                    allIDs = [[NSMutableArray alloc]init];
//                    [allIDs addObject:entityID];
//                }
//                [XLArchiverHelper setObject:allIDs forKey:RCSysMsgList_IDs];
//
//                NSMutableArray *readIDs = [XLArchiverHelper getObject:RCSysMsgList_readIDs];
//                if (readIDs) {
//                    if (![readIDs containsObject:entityID]) {
//                        [readIDs addObject:entityID];
//                    }
//                }else {
//                    readIDs = [[NSMutableArray alloc]init];
//                    [readIDs addObject:entityID];
//                }
//                [XLArchiverHelper setObject:readIDs forKey:RCSysMsgList_readIDs];
//            }
//        }];
//        [alerC addAction:okAction];
//    }
//    [_window.rootViewController presentViewController:alerC animated:YES completion:nil];
}


#pragma mark app初始化
- (void)downInitAPP{
    
    NSDictionary *infoDict = [XLArchiverHelper getObject:App_Info];//缓存app信息
    if (!kDictIsEmpty(infoDict)) {
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:[PublicTool deviceId] forKey:@"deviceID"];
    [dict setObject:CurrentAppVersion forKey:@"appVer"];
    [dict setObject:[UIDevice currentDevice].systemVersion forKey:@"phoneVer"];
    [dict setObject:[PublicTool iphoneType] forKey:@"phoneModel"];
    [dict setObject:GeTui_AppID forKey:@"appID"];
    [dict setObject:@"" forKey:@"userID"];
    [dict setObject:@"" forKey:@"cid"];
    [dict setObject:@"" forKey:@"deviceToken"];
    [dict setObject:@"iphone" forKey:@"deviceType"];
    [dict setObject:@"ios" forKey:@"phoneSystem"];
    
    [SystemApi initWithDict:dict succ:^(NSString *string) {
        NSLog(@"%@",string);
        
        [self switchRootViewController];
    } fail:^(NSString *string) {
        NSLog(@"%@",string);
        if ([string isEqualToString:@"400"]) {//账号被拉黑
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"您已违反平台规范被禁用" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"退出APP" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [UIView animateWithDuration:1.0f animations:^{
                    self.window.alpha = 0;
                    self.window.frame = CGRectMake(0, self.window.bounds.size.width, 0, 0);
                } completion:^(BOOL finished) {
                    exit(0);
                }];
            }];
            [actionSheet addAction:action1];
            [self.window.rootViewController presentViewController:actionSheet animated:YES completion:nil];
        }else {
           
            [self switchRootViewController];
        }
    }];
}


#pragma mark ZJLoadingDelegate Methods 切换页面
- (void)switchRootViewController {
    TabBarController *tabBarVC = [[TabBarController alloc]init];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
}

@end
