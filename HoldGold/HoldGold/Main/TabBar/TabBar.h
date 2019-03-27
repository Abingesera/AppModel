//
//  TabBar.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBar;
@protocol TabBarDelegate <NSObject>
@optional
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBardidPlusButton:(TabBar *)tabBar;
@end

@interface TabBar : UIView

@property (nonatomic,strong) NSMutableArray * tabBarButtons;
@property (weak, nonatomic) TabBarButton *selectedButton;

@property(nonatomic,assign) id<TabBarDelegate> delegate;

-(void)addTabBarButtonWithItem:(UITabBarItem *)item;

//显示小红点
- (void)showBadgeOnItemIndex:(int)index;
//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index;

@end

