//
//  NoneNetWorkingView.m
//  NewHoldGold
//
//  Created by 掌金 on 2018/2/9.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import "NoneNetWorkingView.h"

@implementation NoneNetWorkingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI {
//    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    _backImgView = [[UIImageView alloc]init];
    _backImgView.frame = CGRectMake((SCREEN_WIDTH - 260*ScaleW)/2, (self.height - 242*ScaleW)/2-60*ScaleW, 260*ScaleW, 242*ScaleW);
    _backImgView.image = [UIImage imageNamed:@"Img_404_no signal"];
//    _backImgView.backgroundColor = [UIColor grayColor];
    _backImgView.userInteractionEnabled = YES;
    [self addSubview:_backImgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRefreshData:)];
    [_backImgView addGestureRecognizer:tap];
    
//    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _backImgView.bottom + 4, SCREEN_WIDTH, 22)];
//    _titleLab.text = @"网络开小差~";
//    _titleLab.font = [RCFont setRegularFontWithSizeNumber:RCFontSixSizeNumber];
//    _titleLab.textColor = [@"#999999" hexStringToColor];
//    _titleLab.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_titleLab];
//
//    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _refreshButton.frame = CGRectMake((SCREEN_WIDTH - 148)/2, _titleLab.bottom + 44, 148, 44);
//    [_refreshButton setTitle:@"点击刷新" forState:UIControlStateNormal];
//
//    [_refreshButton setTitleColor:RGBA(1.0, 1.0, 1.0, 1.0) forState:UIControlStateNormal];
//    //    _createBtn.layer.masksToBounds = YES;
//    _refreshButton.layer.cornerRadius = 22;
//    _refreshButton.layer.shadowOffset = CGSizeMake(0, 6);
//    _refreshButton.layer.shadowOpacity = .2f;
//    _refreshButton.layer.shadowColor = [[@"FF635E" hexStringToColor] CGColor];
//    [_refreshButton addTarget:self action:@selector(refreshDataAgain:) forControlEvents:UIControlEventTouchUpInside];
//
//    _refreshButton.titleLabel.font = [RCFont setRegularFontWithSizeNumber:RCFontSixSizeNumber];
//
//    [self addSubview: _refreshButton];
    
//    //设置渐变
//    UIColor *colorOne = RGBA(1.0, 0.38, 0.37, 1.0);
//    UIColor *colorTwo = RGBA(1.0, 0.48, 0.30, 1.0);
//    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    //设置开始和结束位置(设置渐变的方向)
//    gradient.startPoint = CGPointMake(0, 0);
//    gradient.endPoint = CGPointMake(1, 0);
//    gradient.colors = colors;
//    gradient.cornerRadius = 22;
//    gradient.frame = CGRectMake(0, 0, _refreshButton.width, _refreshButton.height);
//    [ _refreshButton.layer insertSublayer:gradient atIndex:0];
}

#pragma mark 点击刷新
//- (void)refreshDataAgain:(UIButton *)sender{
////    self.hidden = YES;
//    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshSelfControllerViewData)]) {
//        [self.delegate refreshSelfControllerViewData];
//    }
//}


- (void)clickRefreshData:(UITapGestureRecognizer *)tap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshSelfControllerViewData)]) {
        [self.delegate refreshSelfControllerViewData];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
