//
//  BaseViewController.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController

@property (nonatomic,assign)BOOL statusBarHidden;

@property (nonatomic,assign)UIStatusBarStyle statusBarStyle;
@property (nonatomic,copy)NSString *navBackBtnImg;
@property (nonatomic,strong) NoneNetWorkingView *noneNetWView;//无网络View

//设置导航栏标题
- (void)setNavTitleViewWithTitleStr:(NSString *)titleStr AndWithFont:(UIFont *)font AndWithColor:(UIColor *)color;

/**
 返回到指定控制器
 
 @param controllerNames 控制器名字字符串数组
 @param animated 返回动画
 */
-(void)backToControllerName:(NSArray <NSString *>*)controllerNames animated:(BOOL)animated;

/*
 显示无数据的页面
 */
- (void)showNoDataView;

/*
 移除无数据的页面
 */
- (void)removeNoDataView;

/*
 需要登录
 */
- (void)gotoLoginFrom:(NSString *)where;

@end

