//
//  TabBarController.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController : UITabBarController
@property (nonatomic,assign) NSInteger selectTabbarIndex;

//显示小红点
- (void)tabBarshowBadgeOnItemIndex:(int)index;
//隐藏小红点
- (void)tabBarhideBadgeOnItemIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
