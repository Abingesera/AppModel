//
//  ActionSheetView.m
//  分享样式
//  联系开发者:QQ154158462
//  Created by 陈冠鹏 on 15/6/4.
//  Copyright (c) 2015年 pzheng. All rights reserved.
//

#import "ActionSheetView.h"

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1]
#define ANIMATE_DURATION                        0.4f

#define ActionSheetW [[UIScreen mainScreen] bounds].size.width
#define ActionSheetH [[UIScreen mainScreen] bounds].size.height

@interface ActionSheetView ()
@property (nonatomic,assign) CGFloat LXActionSheetHeight;
@property (nonatomic,strong) NSArray *shareBtnTitleArray;
@property (nonatomic,strong) NSArray *shareBtnImgArray;

@property (nonatomic,strong) UIView *backGroundView;

@property (nonatomic,strong) UIButton *cancelBtn;

//头部提示文字Label
@property (nonatomic,strong) UILabel *proL;

@property (nonatomic,copy) NSString *protext;

@property (nonatomic,assign) ShowType showtype;

@property (nonatomic,strong) UMSocialMessageObject *messageObj;

@property (nonatomic,strong) ShareDataObject *shareObject;

@end

@implementation ActionSheetView

- (id)initWithShareShowType:(ShowType)type{
    self = [super init];
    if (self) {
        NSArray *titlearr = @[@"微信好友",@"朋友圈",@"QQ好友",@"新浪微博"];
        NSArray *imageArr = @[@"Wechat",@"WeGroup",@"QQ",@"Weibo"];
        self.shareBtnImgArray = imageArr;
        self.shareBtnTitleArray = titlearr;
        _showtype = type;
        
        self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (type == ShowTypeIsShareStyle) {
            [self loadUiConfig];
        }else if (type == ShowTypeIsShareRotationStyle){
            [self loadRotationStyle];
        }else if (type == ShowTypeIsShareListPlayerStyle){
            [self loadListRotationStyle];
        }
        else{
            [self loadActionSheetUi];
        }
    }
    return self;
}

- (void)loadActionSheetUi
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.cancelBtn];
    if (_protext.length) {
        [self addSubview:self.proL];
    }
    for (NSInteger i = 0; i<_shareBtnTitleArray.count; i++) {
        VerButton *button = [VerButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, CGRectGetHeight(_proL.frame)+50*i, CGRectGetWidth(_backGroundView.frame), 50);
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.backGroundView.frame = CGRectMake(0, ActionSheetH-(self.shareBtnTitleArray.count*50+50)-7-(self.protext.length==0?0:45), ActionSheetW , self.shareBtnTitleArray.count*50+50+7+(self.protext.length==0?0:45));
    }];
    
}

- (void)loadUiConfig
{
    [self addSubview:self.backGroundView];
    CGFloat btnW = (_backGroundView.width-12*ScaleW)/4;
    CGFloat btnH = 60.f;
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        ActionButton *button = [ActionButton buttonWithType:UIButtonTypeCustom];
        if (i < 4) {
            button.frame = CGRectMake(12*ScaleW+btnW*i, 40, btnW, btnH);
        }else {
            button.frame = CGRectMake(12*ScaleW+btnW*i, 208, btnW, btnH);
        }
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        if (SCREEN_WIDTH<375) {
            button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        }
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:button];
    }
    [self.backGroundView addSubview:self.cancelBtn];
    self.alpha = 0;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.alpha = 1.0;
        self.backGroundView.frame = CGRectMake(0, ActionSheetH-CGRectGetHeight(self.backGroundView.frame), ActionSheetW, CGRectGetHeight(self.backGroundView.frame));
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)loadRotationStyle{
    
    self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
    self.center = CGPointMake(self.centerX, self.centerY);
    [self addSubview:self.backGroundView];
    
    CGFloat btnW = 74.f;
    CGFloat btnH = 70.f;
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        ActionButton *button = [ActionButton buttonWithType:UIButtonTypeCustom];
        button.type = 100;
        button.frame = CGRectMake(17+btnW*i, 182, btnW, btnH);
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[@"#FFFFFF" hexStringToColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:button];
    }
    
    self.alpha = 0;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.alpha = 1.0;
        self.backGroundView.frame = CGRectMake(ActionSheetW-330-HOME_INDICATOR_HEIGHT, 0,330+HOME_INDICATOR_HEIGHT,ActionSheetH);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)loadListRotationStyle{
//    self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
//    self.center = CGPointMake(self.centerX, self.centerY);
    [self addSubview:self.backGroundView];
    self.backGroundView.frame = CGRectMake(0, ActionSheetH, 330+HOME_INDICATOR_HEIGHT,ActionSheetW);
    CGFloat btnW = 74.f;
    CGFloat btnH = 70.f;
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        ActionButton *button = [ActionButton buttonWithType:UIButtonTypeCustom];
        button.type = 100;
        button.frame = CGRectMake(17+btnW*i, 182, btnW, btnH);
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[@"#FFFFFF" hexStringToColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backGroundView addSubview:button];
    }
    
    self.alpha = 0;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        self.alpha = 1.0;
        self.backGroundView.frame = CGRectMake(0, ActionSheetH-330-HOME_INDICATOR_HEIGHT,ActionSheetW,330+HOME_INDICATOR_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

-(UIImage *)getImageFromURL:(NSString *)fileURL {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    SDImageCache *cache = [manager imageCache];
    UIImage *img = [cache imageFromCacheForKey:fileURL];
    if (!img){//从网络下载图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        img = [UIImage imageWithData:data];
    }
    return img;
}

-(NSData *)compressBySizeWithMaxLength:(NSUInteger)maxLength image:(UIImage *)resultImage{
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

- (void)BtnClick:(UIButton *)btn
{
    [self tappedCancel];
    NSInteger index = btn.tag-200;
    if (self.messageObj) {
        NSString *tips = @"";
        //平台名称
        UMSocialPlatformType platformName = UMSocialPlatformType_WechatSession;
        if (index==0) {//微信
            platformName = UMSocialPlatformType_WechatSession;
            NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];//缓存的app信息
            if ([appInfo[@"shareType"] integerValue] == 100) {//分享web页面
                
            }else {
            
            if (self.shareObject.shareType != ShareTypeImage && self.shareObject.shareType != ShareTypeAPP) {
                UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:self.shareObject.title descr:self.shareObject.content thumImage:[self getImageFromURL:self.shareObject.image]];//self.shareObject.image
                shareObject.webpageUrl = self.shareObject.webpageUrl;//@"兼容微信低版本网页地址";//兼容微信低版本网页地址
                shareObject.userName = @"gh_93029ac847ac";//小程序username，如
                shareObject.path = self.shareObject.miniPath;//小程序页面路径，如 pages/page10007/page10007
                shareObject.hdImageData = [self compressBySizeWithMaxLength:125*1024 image:[self getImageFromURL:self.shareObject.image]];//UIImageJPEGRepresentation([self getImageFromURL:self.shareObject.image], 1);
//                shareObject.miniProgramType = UShareWXMiniProgramTypeTest;//测试
                shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 正式
                self.messageObj.shareObject = shareObject;
            }
        }
            tips = @"您未安装微信";
        }else if (index==1){//朋友圈
            platformName = UMSocialPlatformType_WechatTimeLine;
             NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];//缓存的app信息
            if (self.shareObject.shareType == ShareTypeAPP) {
                //创建网页内容对象
                UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:@"推荐一个赛事APP：燃擎，极速体验" descr:@"" thumImage:[UIImage imageNamed:self.shareObject.image]];
                webObject.webpageUrl = kStringIsEmpty(appInfo[@"shareUrl"])?@"":appInfo[@"shareUrl"];
                //分享消息对象设置分享内容对象
                self.messageObj.shareObject = webObject;
            }
            tips = @"您未安装微信";
        }else if (index==2){//QQ
            platformName = UMSocialPlatformType_QQ;
            tips = @"您未安装QQ";
        }else if (index==3){//新浪微博
            platformName = UMSocialPlatformType_Sina;
            NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];//缓存的app信息
            if (self.shareObject.shareType == ShareTypeAPP) {
                //创建网页内容对象
                UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:@"推荐一个赛事APP：燃擎，极速体验" descr:@"" thumImage:[UIImage imageNamed:self.shareObject.image]];
                webObject.webpageUrl = kStringIsEmpty(appInfo[@"shareUrl"])?@"":appInfo[@"shareUrl"];
                //分享消息对象设置分享内容对象
                self.messageObj.shareObject = webObject;
            }

            tips = @"您未安装新浪微博";
        }

        BOOL result = [[UMSocialManager defaultManager] isInstall:platformName];//判断是
        if (!result) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
            if (self.showtype == ShowTypeIsShareListPlayerStyle) {
                HUD.transform = CGAffineTransformMakeRotation(M_PI/2);
            }
//            [[UIApplication sharedApplication].keyWindow addSubview:HUD];
//            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//顶层窗口
//            [window addSubview:HUD];
            
            UIWindow *window = nil; //[[UIApplication sharedApplication].windows lastObject];//顶层窗口
            NSArray *windows = [UIApplication sharedApplication].windows;
            for (NSInteger i = windows.count-1; i >= 0; i--) {
                id object = windows[i];
                if ([object isKindOfClass:[UIWindow class]]) {
                    window = (UIWindow *)object;
                }
            }
            if (!window) {
                window = [UIApplication sharedApplication].delegate.window;
            }
            if (self.window) {
                window = self.window;
            }
            [window addSubview:HUD];
            
//            HUD.label.text = tips;
//            HUD.mode = MBProgressHUDModeText;
//            [HUD showAnimated:YES whileExecutingBlock:^{
//                sleep(1);
//            } completionBlock:^{
//                [HUD removeFromSuperview];
//            }];
            
            [PublicTool toastRemindWithRemindStr:tips];
            
            return;
        }
        [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformName messageObject:self.messageObj currentViewController:[UIViewController new] completion:^(id data, NSError *error) {
            
            if (error) {
                NSLog(@"************Share fail with error %@*********",error);
                NSLog(@"%ld",(long)[error code]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showNormalMBPHudWithString:@"分享失败"];
                    if (self.callBackBlock) {
                        self.callBackBlock(error);
                    }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showNormalMBPHudWithString:@"分享成功"];
                    if (self.callBackBlock) {
                        self.callBackBlock(error);
                    }
                });
//                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = data;
//                    //分享结果消息
//                    NSLog(@"response message is %@",resp.message);
//                }else{
//                    NSLog(@"response data is %@",data);
//                }

            }
        }];
        
    }
}

- (void)tappedCancel
{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.showtype == ShowTypeIsShareRotationStyle) {
            self.backGroundView.frame = CGRectMake(ActionSheetW, 0, 330+HOME_INDICATOR_HEIGHT,ActionSheetH);
        }else{
            [self.backGroundView setFrame:CGRectMake(0, ActionSheetH, ActionSheetW, CGRectGetHeight(self.backGroundView.frame))];
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    }];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark -------- getter
- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        if (_showtype == ShowTypeIsShareStyle) {
            _backGroundView.frame = CGRectMake(0, ActionSheetH, ActionSheetW, 190+HOME_INDICATOR_HEIGHT);
            _backGroundView.backgroundColor = [@"#FFFEFF" hexStringToColor];

            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _backGroundView.height-51-HOME_INDICATOR_HEIGHT, ActionSheetW, 0.5f)];
            lineView.backgroundColor = [@"#E9E9E9" hexStringToColor];
            [_backGroundView addSubview:lineView];
        }else if (_showtype == ShowTypeIsShareRotationStyle){
            _backGroundView.frame = CGRectMake(ActionSheetW, 0, 330+HOME_INDICATOR_HEIGHT,ActionSheetH);
            _backGroundView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.85-0.3];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((_backGroundView.width-60)/2, 124, 60, 24)];
            lab.text = @"分享到";
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [@"#ffffff" hexStringToColor];
            lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            [_backGroundView addSubview:lab];
        }else if (_showtype == ShowTypeIsShareListPlayerStyle){
            
            _backGroundView.frame = CGRectMake(0, ActionSheetH, 330+HOME_INDICATOR_HEIGHT,ActionSheetW);
            _backGroundView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.85-0.3];
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((_backGroundView.width-60)/2, 124, 60, 24)];
            lab.text = @"分享到";
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [@"#ffffff" hexStringToColor];
            lab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
            [_backGroundView addSubview:lab];
            
            CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI/2);
            _backGroundView.transform = transform;
            
        }else{
            _backGroundView.frame = CGRectMake(0, ActionSheetH, ActionSheetW, _shareBtnTitleArray.count*50+50+7+(_protext.length==0?0:45));
            _backGroundView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        }
     
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noTap)];
        [_backGroundView addGestureRecognizer:tapGesture];
    }
    return _backGroundView;
}

-(void)noTap{
    
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-50-HOME_INDICATOR_HEIGHT, CGRectGetWidth(_backGroundView.frame), 50);
        _cancelBtn.titleLabel.font = [FontTool setRegularFontWithSizeNumber:FontSixSizeNumber];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[@"#758393" hexStringToColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


-(void)shareDataObject:(ShareDataObject *)shareObject {

    self.shareObject = shareObject;
    [self componentsTitleAndContent];
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSDictionary *appInfo = [XLArchiverHelper getObject:App_Info];//缓存的app信息
    if (shareObject.shareType == ShareTypeImage) {
        //创建图片内容对象
        UMShareImageObject *imageObject = [[UMShareImageObject alloc] init];
        [imageObject setShareImage:[self getImageFromURL:shareObject.image]];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = imageObject;
    }else if(shareObject.shareType == ShareTypeArticle){
        //创建网页内容对象
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:self.shareObject.title descr:self.shareObject.content thumImage:[self getImageFromURL:shareObject.image]];
        webObject.webpageUrl = @"";
        if ([appInfo allKeys]>0) {
            webObject.webpageUrl = [NSString stringWithFormat:@"%@type=ARTICLE&id=%@",appInfo[@"share"],shareObject.shareId];
            self.shareObject.webpageUrl = webObject.webpageUrl;
        }
        //分享消息对象设置分享内容对象
        messageObject.shareObject = webObject;
    }else if (shareObject.shareType == ShareTypeVideo){
        //创建网页内容对象
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:self.shareObject.title descr:self.shareObject.content thumImage:[self getImageFromURL:shareObject.image]];
        webObject.webpageUrl = @"";
        if ([appInfo allKeys]>0) {
            webObject.webpageUrl = [NSString stringWithFormat:@"%@type=VIDEO&id=%@",appInfo[@"share"],shareObject.shareId];
            self.shareObject.webpageUrl = webObject.webpageUrl;
        }
        //分享消息对象设置分享内容对象
        messageObject.shareObject = webObject;
    }else if (shareObject.shareType == ShareTypeAPP) {
        //创建网页内容对象
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:self.shareObject.title descr:self.shareObject.content thumImage:[UIImage imageNamed:shareObject.image]];
        webObject.webpageUrl = kStringIsEmpty(appInfo[@"shareUrl"])?@"":appInfo[@"shareUrl"];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = webObject;

    }else if (shareObject.shareType == ShareTypePHOTO){
        //创建网页内容对象
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:self.shareObject.title descr:self.shareObject.content thumImage:[self getImageFromURL:shareObject.image]];
        webObject.webpageUrl = @"";
        if ([appInfo allKeys]>0) {
            webObject.webpageUrl = [NSString stringWithFormat:@"%@type=PHOTO&id=%@",appInfo[@"share"],shareObject.shareId];
            self.shareObject.webpageUrl = webObject.webpageUrl;
        }
        //分享消息对象设置分享内容对象
        messageObject.shareObject = webObject;
    }
    
    self.messageObj = messageObject;
    
    UIWindow *window = nil; //[[UIApplication sharedApplication].windows lastObject];//顶层窗口
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (NSInteger i = windows.count-1; i >= 0; i--) {
        id object = windows[i];
        if ([object isKindOfClass:[UIWindow class]]) {
            window = (UIWindow *)object;
        }
    }
    if (!window) {
        window = [UIApplication sharedApplication].delegate.window;
    }
    if (self.window) {
        window = self.window;
    }
    [window addSubview:self];
    
    
//    [[UIApplication sharedApplication].keyWindow addSubview:self];

}
#pragma mark 去除标题 内容中的非法字符
- (void)componentsTitleAndContent{
    
    //替换字符串中的非法字符。
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"~!@#$%^&*+?/="];
    self.shareObject.title = [[self.shareObject.title componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
    self.shareObject.content = [[self.shareObject.content componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
}

- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

@end

