//
//  LoadingController.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "BaseViewController.h"

@protocol LoadingPageDelegate <NSObject>

- (void)switchRootViewController;

@end

@interface LoadingController : BaseViewController

@property (nonatomic,assign)id <LoadingPageDelegate>delegate;

@end

