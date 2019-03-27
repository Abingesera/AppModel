//
//  TabBarController.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()<TabBarDelegate>
@property (nonatomic, weak) TabBar *customTabBar;
@end

@implementation TabBarController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //删除系统自动生成的UITabBarButton
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        // 初始化tabbar
        [self setupTabbar];
        //初始化子控制器
        [self initSubVC];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    TabBar * customTabBar = [[TabBar alloc] init];
    customTabBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, TAB_BAR_HEIGHT);
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    _customTabBar = customTabBar;
    
    [[UITabBar appearance] setBackgroundColor:[@"#FFFFFF" hexStringToColor]];
    
    
    //    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
    //    backView.backgroundColor = [UIColor redColor];
    //    // 去除顶部横线
    [self.tabBar setClipsToBounds:YES];
    //    [self.tabBar insertSubview:backView atIndex:0];
    //    self.tabBar.opaque = YES;
}


/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(TabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    if (from == 1 && to != 1) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:ZJCleanTradeCircleDataSourceNotification object:nil];
    }
    switch (to) {
        case 0:

            break;
        case 1:

            break;
        case 2:

            break;
        case 3:

            break;
            
        default:
            break;
    }
}


-(void)setSelectTabbarIndex:(NSInteger)selectTabbarIndex{
    _selectTabbarIndex = selectTabbarIndex;
    [self tabBar:_customTabBar didSelectedButtonFrom:(int)self.selectedIndex to:(int)selectTabbarIndex];
    self.selectedIndex = selectTabbarIndex;
    //2.选中按钮
    _customTabBar.selectedButton.selected=NO;
    UIButton *button = _customTabBar.tabBarButtons[selectTabbarIndex];
    button.selected=YES;
    _customTabBar.selectedButton = (TabBarButton *)button;
}


-(void)initSubVC
{
    //首页
    HomePageController *pageVC = [[HomePageController alloc]init];
    
    [self setupChildVC:pageVC Title:@"首页" imageName:@"Home_NPic" selectedImageName:@"Home_PressPic"];
    

    MarketController *liveModuleMainVC = [[MarketController alloc]init];
    
    [self setupChildVC:liveModuleMainVC Title:@"直播" imageName:@"Live_NPic" selectedImageName:@"Live_PressPic"];
    

    TradeController *eventVC = [[TradeController alloc]init];
    
    [self setupChildVC:eventVC Title:@"赛事" imageName:@"Competition_NPic" selectedImageName:@"Competition_PressPic"];
    
    //我的
    MineController *personVC = [[MineController alloc]init];
    [self setupChildVC:personVC Title:@"我的" imageName:@"My_NPic" selectedImageName:@"My_PressPic"];
    
}

//初始化所有子控制器
-(void)setupChildVC:(UIViewController *)childVC Title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //1.设置标题
    //    childVC.title=title;
    childVC.tabBarItem.title = title;
    //2.设置图片
    childVC.tabBarItem.image=[UIImage imageNamed:imageName];
    //3.设置选中图片
    childVC.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    
    //不在渲染图片
    childVC.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //4.添加导航控制器
    UINavigationController * Nav=[[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:Nav];
    //5.添加tabbar内部的按钮
    [_customTabBar addTabBarButtonWithItem:childVC.tabBarItem];
}

#pragma mark 解决多次跳转tabbar重影问题
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView * view in self.tabBar.subviews)
    {
        
        if (![view isKindOfClass:[TabBar class]]) {
            
            [view removeFromSuperview];
        }
    }
}

//显示小红点
- (void)tabBarshowBadgeOnItemIndex:(int)index {
    
    [_customTabBar showBadgeOnItemIndex:index];
    
}
//隐藏小红点
- (void)tabBarhideBadgeOnItemIndex:(int)index {
    [_customTabBar hideBadgeOnItemIndex:index];
}

#pragma mark - 屏幕旋转
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}


@end
