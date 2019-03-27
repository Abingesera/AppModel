//
//  TabBarButton.m
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#import "TabBarButton.h"
const double FZHTabBarImageRatio = 0.56;
@implementation TabBarButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //1.图片居中
        self.imageView.contentMode=UIViewContentModeCenter;
        //2.文字居中
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[FontTool createFontWithFontName:PingFangSCRegular SizeFont:10];
        self.backgroundColor = [@"#FFFFFF" hexStringToColor];
        [self setTitleColor:[@"#1C1C25" hexStringToColor] forState:UIControlStateSelected];
        [self setTitleColor:[@"#999999" hexStringToColor] forState:UIControlStateNormal];
    }
    return self;
}

//去掉父类在高亮时所作的操作
-(void)setHighlighted:(BOOL)highlighted{
    
}

#pragma mark - 覆盖父类的2个方法
#pragma mark - 设置按钮标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 33, contentRect.size.width, 14);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    //    return CGRectMake((SCREEN_WIDTH/4-24)/2, 4, 24, 24);
    return CGRectMake((contentRect.size.width-24)/2, 7, 24, 24);
}

-(void)setItem:(UITabBarItem *)item
{
    
    _item=item;
    
    //1.利用kvo监听item属性值的改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew  context:nil];
    [item addObserver:self forKeyPath:@"image" options:0  context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0  context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0  context:nil];
    
    //2.属性赋值
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}
/**
 *  KVO监听必须在监听器释放的时候，移除监听操作
 *  通知也得在释放的时候移除监听
 */
-(void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
}
/**
 *  监听item的属性值改变
 *
 *  @param keyPath 哪个属性改变了
 *  @param object  哪个对象的属性改变了
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //设置文字（两种状态）
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
}

@end
