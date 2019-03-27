//
//  UIView+Size.m
//  NewHoldGold
//
//  Created by 梁鑫磊 on 13-12-27.
//  Copyright (c) 2013年 zsgjs. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder) {
        [self resignFirstResponder];
        return YES;
    }
    for (UIView *subView in self.subviews) {
        if ([subView findAndResignFirstResponder])
            return YES;
    }
    return NO;
}

#pragma mark -- 自定义视图显示1s消失

//提示框
- (void)alertViewWillDisappearAutoWithRect:(CGRect )rect string:(NSString *)str{
    //消失保存成功图片
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [@"#ffffff" hexStringToColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.5;
    label.text = str;
    label.layer.cornerRadius = 5;
    [label.layer setMasksToBounds:YES];
    [self addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}

#pragma mark -- 渐变透明度
- (void) insertTransparentGradient {
    //设置渐变的颜色
    UIColor *colorOne = [UIColor colorWithRed:(255.0/255.0)  green:(255.0/255.0)  blue:(255.0/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(255.0/255.0)  green:(255.0/255.0)  blue:(255.0/255.0)  alpha:1.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = self.bounds;
    //默认纵向渐变，设置横向渐变
    headerLayer.startPoint = CGPointMake(0, .5);
    headerLayer.endPoint = CGPointMake(1, .5);
    
    [self.layer insertSublayer:headerLayer atIndex:0];
}

#pragma mark -- 获取设备的IP地址
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
//提示框
- (void)alertViewWillDisappearAutoWithRect:(CGRect )rect string:(NSString *)str withTime:(NSInteger)time{
    //消失保存成功图片
   __block UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [@"#ffffff" hexStringToColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.8;
    label.text = str;
    label.layer.cornerRadius = 5;
    [label.layer setMasksToBounds:YES];
    [self addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
        label = nil;
    });
}
#pragma mark -- 全凭等待
//- (UIView *)waitingViewInAllScreenWith:(NSString *)titile {
//    XLNJLodingAnimationAndMessageView *view = [[XLNJLodingAnimationAndMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    view.hidden = NO;
//    view.backgroundColor = [UIColor blackColor];
//    view.messageLabel.text = titile;
//    view.messageLabel.textColor = [@"#CCCCCC" hexStringToColor];
//    view.alpha = 0.8;
//    [self addSubview:view];
//    return view;
//}
#pragma mark -- 去除float后无用的零
-(NSString *)changeFloat:(NSString *)stringFloat
{
        NSString * testNumber = stringFloat;
        NSString * s = nil;
        NSInteger offset = testNumber.length - 1;
        while (offset)
        {
            s = [testNumber substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"] || [s isEqualToString:@"."])
            {
                offset--;
            }
            else
            {
                break;
            }
        }
        NSString * outNumber = [testNumber substringToIndex:offset+1];
    return outNumber;
}


//获取Controller
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
