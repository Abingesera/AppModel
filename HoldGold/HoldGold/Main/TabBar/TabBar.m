//
//  TabBar.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons== nil) {
        _tabBarButtons=[NSMutableArray array];
    }
    return _tabBarButtons;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)plusButtonClick
{
    if ([self.delegate respondsToSelector:@selector(tabBardidPlusButton:)]) {
        [self.delegate tabBardidPlusButton:self];
    }
}
-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    //1.创建按钮
    TabBarButton * button=[[TabBarButton alloc]init];
    [self.tabBarButtons addObject:button];
    //2.设置数据
    button.item=item;
    
    button.backgroundColor = [@"#FFFFFF" hexStringToColor];
    
    //3.添加按钮
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
    //4.默认选中
    if (self.tabBarButtons.count==1) {
        
        [self buttonClick:button];
    }
    
}
-(void)buttonClick:(TabBarButton *)button
{
    //1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    //2.控制器选中按钮
    self.selectedButton.selected=NO;
    button.selected=YES;
    self.selectedButton=button;
}
//布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. 4个按钮
    CGFloat buttonW=self.frame.size.width/self.subviews.count;
    CGFloat buttonH=self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (int index=0; index<self.tabBarButtons.count; index++) {
        
        //1.取出按钮
        TabBarButton * button=self.tabBarButtons[index];
        //2.设置按钮的frame
        CGFloat buttonX=index * buttonW;
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //3.绑定tag
        button.tag=index;
        
        if (index == 2) {
            
            //新建小红点
            UIImageView *badgeView = [[UIImageView alloc]init];
            badgeView.tag = 888;
            
            //            badgeView.backgroundColor = [@"#FF553C" hexStringToColor];
            //            CGRect tabFrame = button.frame;
            
            //确定小红点的位置
            //            float percentX = tabFrame.size.width*7/12 + 4;
            //            float percentY = tabFrame.size.height/7;
            badgeView.frame = CGRectMake(button.width - 25*ScaleW, 10, 6, 6);
            badgeView.layer.masksToBounds = YES;
            //            badgeView.layer.cornerRadius = 3;
            badgeView.image = [UIImage imageNamed:@"normal_Tab"];
            //            badgeView.layer.borderWidth = 0.5;
            //            badgeView.layer.borderColor = [[UIColor blackColor] CGColor];
            [button addSubview:badgeView];
            badgeView.hidden = YES;
        }else if (index == 1) {
            
            //新建小红点
            UIImageView *badgeView = [[UIImageView alloc]init];
            badgeView.tag = 8888;
            badgeView.frame = CGRectMake(button.width - 30*ScaleW, 10, 8, 8);
            badgeView.layer.masksToBounds = YES;
            //            badgeView.backgroundColor = [UIColor redColor];
            //            badgeView.image = [UIImage imageNamed:@"2"];
            badgeView.image = [UIImage imageNamed:@"point"];
            [button addSubview:badgeView];
            badgeView.hidden = YES;
        }
    }
}

//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    
    for (int i=0; i<self.tabBarButtons.count; i++) {
        
        if (i == index) {
            //1.取出按钮
            TabBarButton * button=self.tabBarButtons[index];
            
            
            //按照tag值进行移除
            for (UIView *subView in button.subviews) {
                
                if (subView.tag == 888 && subView.hidden) {
                    
                    subView.hidden = NO;
                    
                }
                if (subView.tag == 8888 && subView.hidden) {
                    
                    subView.hidden = NO;
                    
                }
            }
            
        }
        
        
    }
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    
    //移除小红点
    for (int i=0; i<self.tabBarButtons.count; i++) {
        
        if (i == index) {
            //1.取出按钮
            TabBarButton * button=self.tabBarButtons[index];
            
            //按照tag值进行移除
            for (UIView *subView in button.subviews) {
                
                if (subView.tag == 888 && !subView.hidden) {
                    
                    subView.hidden = YES;
                    
                }
                if (subView.tag == 8888 && !subView.hidden) {
                    
                    subView.hidden = YES;
                    
                }
            }
            
        }
        
    }
    
}

@end
