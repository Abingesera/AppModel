//
//  BaseViewController.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<NoneNetWorkingViewDelegate>
@property (nonatomic,strong)UILabel *titleStrLab;//标题
@property (nonatomic,strong)UIButton *navBackBtn;//返回按钮
@end

@implementation BaseViewController

- (UILabel *)titleStrLab{
    
    if (!_titleStrLab) {
        _titleStrLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        _titleStrLab.font = [FontTool setMediumFontWithSizeNumber:FontSixSizeNumber];
        _titleStrLab.textAlignment = NSTextAlignmentCenter;
        _titleStrLab.textColor = [@"#000000" hexStringToColor];
        
    }
    return _titleStrLab;
}

- (UIButton *)navBackBtn{
    if (!_navBackBtn) {
        _navBackBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 32, 24)];
        _navBackBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,8);
        [_navBackBtn addTarget:self action:@selector(backItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _navBackBtn;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置应用的背景色
    self.view.backgroundColor = [UIColor lightGrayColor];
    // 不允许 viewController 自动调整，我们自己布局；如果设置为YES，视图会自动下移 64 像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"Search_W bg Copy@2x"]];//导航栏下方线
    self.statusBarStyle = UIStatusBarStyleDefault;
    UIColor *MainNavBarColor = [@"#FFFFFF" hexStringToColor];//导航栏颜色
    [self.navigationController.navigationBar wr_setBackgroundColor:[MainNavBarColor colorWithAlphaComponent:1.0] isHidden:YES];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]; //改变系统导航返回按钮颜色
    
     [self createNoneNetWotkingV];
    
}

#pragma mark 创建无网视图
- (void)createNoneNetWotkingV{
    _noneNetWView = [[NoneNetWorkingView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, self.view.height)];
    _noneNetWView.hidden = YES;
    _noneNetWView.delegate = self;
    [self.view addSubview:_noneNetWView];
}

/*
 显示无数据的页面
 */
- (void)showNoDataView {
    
    _noneNetWView.hidden = NO;
    [self.view bringSubviewToFront:_noneNetWView];
    
}

/*
 移除无数据的页面
 */
- (void)removeNoDataView {
    _noneNetWView.hidden = YES;
    [self.view sendSubviewToBack:_noneNetWView];
    
}

#pragma mark - 状态栏样式
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
    
}

//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
}

#pragma mark - 状态栏显示／隐藏
-(void)setStatusBarHidden:(BOOL)statusBarHidden{
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

//状态栏显示／隐藏
-(BOOL)prefersStatusBarHidden{
    return self.statusBarHidden;
}

#pragma mark - 导航栏标题
- (void)setNavTitleViewWithTitleStr:(NSString *)titleStr AndWithFont:(UIFont *)font AndWithColor:(UIColor *)color{
    
    self.titleStrLab.text = titleStr;
    if (font) {
        self.titleStrLab.font = font;
    }
    if (color) {
        self.titleStrLab.textColor = color;
    }
    self.navigationItem.titleView = self.titleStrLab;
    
    
}
#pragma mark - 导航栏返回按钮
- (void)setNavBackBtnImg:(NSString *)navBackBtnImg{
    
    [self.navBackBtn setImage:[UIImage imageNamed:navBackBtnImg] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:self.navBackBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
#pragma makr 点击返回按钮
- (void)backItemClick:(UIButton *)sender{
    
    BOOL shouldPop = YES;
    
    if([self respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [self navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } else {
        //        for(UIView *subview in [self.navigationController.navigationBar subviews]) {
        //            if(0. < subview.alpha && subview.alpha < 1.) {
        //                [UIView animateWithDuration:.25 animations:^{
        //                    subview.alpha = 1.;
        //                }];
        //            }
        //        }
    }
    
}


#pragma mark 返回到指定控制器
-(void)backToControllerName:(NSArray <NSString *>*)controllerNames animated:(BOOL)animated{
    if (self.navigationController) {
        NSArray *controllers = self.navigationController.viewControllers;
        for (NSString *nameVc in controllerNames) {
            for (UIViewController *viewC in controllers) {
                NSString *str = NSStringFromClass([viewC class]);
                if ([nameVc isEqualToString:str]) {
                    [self.navigationController popToViewController:viewC animated:animated];
                    return;
                }
            }
        }
        [self.navigationController popViewControllerAnimated:animated];
        //        NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        //            NSString *nameVC = NSStringFromClass([evaluatedObject class]);
        //            return [controllerNames containsObject:nameVC];//[evaluatedObject isKindOfClass:NSClassFromString(objStr)];
        //        }]];
        //        if (result.count > 0) {
        //            [self.navigationController popToViewController:result[0] animated:animated];
        //        }else{
        //            [self.navigationController popViewControllerAnimated:animated];
        //        }
    }
}

#pragma mark NoneNetWorkingViewDelegate 无网络 点击按钮刷新界面
- (void)refreshSelfControllerViewData{
    
    [self removeNoDataView];
    
}

#pragma mark 需要登录
- (void)gotoLoginFrom:(NSString *)where {
    
    
}

#pragma mark - 转屏控制
- (BOOL)shouldAutorotate{
    //是否允许转屏
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //viewController所支持的全部旋转方向
    return UIInterfaceOrientationMaskPortrait;
}

// Returns interface orientation masks. （返回最优先显示的屏幕方向）
// 同时支持Portrait和Landscape方向，但想优先显示Landscape方向，那软件启动的时候就会先显示Landscape，在手机切换旋转方向的时候仍然可以在Portrait和Landscape之间切换；
// 返回现在正在显示的用户界面方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //viewController初始显示的方向
    return UIInterfaceOrientationPortrait;//UIDeviceOrientationLandscapeRight
}

@end
