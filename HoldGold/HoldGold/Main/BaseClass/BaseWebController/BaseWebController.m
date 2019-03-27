//
//  BaseWebController.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/19.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "BaseWebController.h"

@interface BaseWebController ()

@property(nonatomic, copy) NSString* webUrl;/**< 字符串的url地址*/
@property(nonatomic, copy) NSString* Title;//标题
@property(nonatomic, strong) NSString* contentHTML;//html内容

@property(nonatomic, assign) NSUInteger type;//类型

//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;
//关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeItem;

@end

@implementation BaseWebController

-(instancetype)initWithTitle:(NSString*)title  URL:(NSString*)url HTML:(NSString *)contentHTML AndWithType:(NSUInteger)type{
    
    if (self = [super init]) {
        
        _webUrl = url;
        _Title = title;
        _contentHTML =contentHTML;
        _type = type;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"Search_W bg Copy@2x"]];//导航栏下方线
    self.statusBarStyle = UIStatusBarStyleDefault;
    UIColor *MainNavBarColor = [@"#FFFFFF" hexStringToColor];//导航栏颜色
    [self.navigationController.navigationBar wr_setBackgroundColor:[MainNavBarColor colorWithAlphaComponent:1.0] isHidden:NO];
    //    if (_type == 100) { //轮播图进入
    //        [MobClick beginLogPageView:@"RC_HomeBannerWebVC"];
    //    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!kStringIsEmpty(_Title)) {
        [self setNavTitleViewWithTitleStr:_Title AndWithFont:nil AndWithColor:nil];
    }
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc]init];
    
    config.selectionGranularity = WKSelectionGranularityCharacter;
    self.myWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT-NAVIGATION_BAR_HEIGHT) configuration:config];
    self.myWebView.navigationDelegate = self;
    self.myWebView.UIDelegate = self;
    self.myWebView.allowsBackForwardNavigationGestures = YES;//支持侧滑返回
    [self.view addSubview:self.myWebView];
    
    if (isIOS11) {
        if (@available(iOS 11.0, *)) {
            self.myWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    
    //加载网页
    if (!kStringIsEmpty(_webUrl)) {
        [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    }
    
    //加载富文本
    if (!kStringIsEmpty(_contentHTML)) {
        [self.myWebView loadHTMLString:_contentHTML baseURL:nil];
    }
    
    //添加返回按钮
    [self addLeftButton];
}

#pragma mark - 添加返回按钮

- (void)addLeftButton
{
    self.navigationItem.leftBarButtonItem = self.backItem;
}

- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //这是一张“<”的图片，可以让美工给切一张
        UIImage *image = [UIImage imageNamed:@"Back-Black"];
        [btn setImage:image forState:UIControlStateNormal];
        //        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        btn.frame = CGRectMake(0, 0, 60, 40);
        _backItem.customView = btn;
    }
    return _backItem;
}

#pragma mark 添加关闭按钮
- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
        _closeItem.tintColor = [UIColor blackColor];
    }
    return _closeItem;
}

//点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if ([self.myWebView canGoBack]) {
        //如果有则返回
        [self.myWebView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    } else {
        [self closeNative];
    }
}

//关闭H5页面，直接回到原生页面
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}


// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    //    self.title = webView.title;
    
    
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    if (_type == 100) {
    //       [MobClick endLogPageView:@"RC_HomeBannerWebVC"];
    //    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
