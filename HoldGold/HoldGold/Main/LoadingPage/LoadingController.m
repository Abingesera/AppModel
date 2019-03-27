//
//  LoadingController.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "LoadingController.h"

@interface LoadingController ()

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation LoadingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView setImage:[UIImage imageNamed:[self getLaunchImageName]]];
    [self.view addSubview:self.imageView];
    //初始化
    [self downInitAPP];
}


//获取启动图imageName
- (NSString *)getLaunchImageName
{
    CGSize viewSize = self.view.bounds.size;
    // 竖屏
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}


#pragma mark app初始化
- (void)downInitAPP {
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
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(switchRootViewController)]) {
            [self.delegate switchRootViewController];
        }
    } fail:^(NSString *string) {
        NSLog(@"%@",string);
        if ([string isEqualToString:@"400"]) {//账号被拉黑
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"您已违反平台规范被禁用" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"退出APP" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self exitApplication];
            }];
            [actionSheet addAction:action1];
            [self presentViewController:actionSheet animated:YES completion:nil];
        }else {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(switchRootViewController)]) {
                [self.delegate switchRootViewController];
            }
        }
    }];
    
}

#pragma mark 强制退出App
- (void)exitApplication {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    //exit(0);
    
}
@end
