//
//  NoneNetWorkingView.h
//  NewHoldGold
//
//  Created by 掌金 on 2018/2/9.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import "BaseView.h"

@protocol NoneNetWorkingViewDelegate <NSObject>

- (void)refreshSelfControllerViewData;//刷新当前界面

@end


@interface NoneNetWorkingView : BaseView

@property (nonatomic,weak) id <NoneNetWorkingViewDelegate>delegate;

@property (nonatomic,strong)UIButton *refreshButton;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIImageView *backImgView;

@end
