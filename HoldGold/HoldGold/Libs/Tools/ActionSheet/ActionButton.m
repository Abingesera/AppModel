//
//  ActionButton.m
//  分享样式
//  联系开发者:QQ154158462
//  Created by 陈冠鹏 on 15/6/4.
//  Copyright (c) 2015年 pzheng. All rights reserved.
//

#import "ActionButton.h"

@implementation ActionButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        [self setTitleColor:[@"#283D5D" hexStringToColor] forState:UIControlStateNormal];
    }
    return self;
}

//重写这个方法（调整标签标题的位置）
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height-17, contentRect.size.width, 17);
}
//调整图片位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width-35)*0.5, 0, 35, 35);
}

//-(void)layoutSubviews {
//    [super layoutSubviews];
//
//    // Center image
//    CGPoint center = self.imageView.center;
//    center.x = self.frame.size.width/2;
//    center.y = self.imageView.frame.size.height/2;
//    self.imageView.center = center;
//
//    //Center text
//    CGRect newFrame = [self titleLabel].frame;
//    newFrame.origin.x = 0;
//    newFrame.origin.y = self.imageView.frame.size.height+5;//+16
//    newFrame.size.width = self.frame.size.width;
//    newFrame.size.height = 20;
//    self.titleLabel.frame = newFrame;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//
//    if (self.type == 100) {
//        CGPoint center = self.imageView.center;
//        center.x = self.frame.size.width/2;
//        center.y = self.imageView.frame.size.height/2;
//        self.imageView.center = center;
//
//        //Center text
//        CGRect newFrame = [self titleLabel].frame;
//        newFrame.origin.x = 0;
//        newFrame.origin.y = self.imageView.frame.size.height+10;//+16
//        newFrame.size.width = self.frame.size.width;
//        newFrame.size.height = 20;
//        self.titleLabel.frame = newFrame;
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    }
//}

@end







