//
//  UINavigationController+Autorotate.m
//  RacingCar
//
//  Created by 掌金-pang on 2018/7/18.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import "UINavigationController+Autorotate.h"

@implementation UINavigationController (Autorotate)

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
