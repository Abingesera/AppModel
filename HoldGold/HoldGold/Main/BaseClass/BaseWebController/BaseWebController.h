//
//  BaseWebController.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/19.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebController : BaseViewController<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong)WKWebView *myWebView;

/*  初始化webview
 *
 *  @param title webview的名字
 *  @param url   webview的请求地址
 *  @param HTML  webview加载富文本
 *  @param type  webview的类型
 *  @return id
 */
-(instancetype)initWithTitle:(NSString*)title  URL:(NSString*)url HTML:(NSString *)contentHTML AndWithType:(NSUInteger)type;

@end

