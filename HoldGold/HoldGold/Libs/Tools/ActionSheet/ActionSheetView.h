//
//  ActionSheetView.h
//  分享样式
//  联系开发者:QQ154158462
//  Created by 陈冠鹏 on 15/6/4.
//  Copyright (c) 2015年 pzheng. All rights reserved.
//

#import "VerButton.h"
#import "ActionButton.h"
#import <UIKit/UIKit.h>
#import "ShareDataObject.h"

typedef enum {
    ShowTypeIsShareStyle = 0,  //9宫格类型的  适合分享按钮
    ShowTypeIsActionSheetStyle,  //类似系统的actionsheet的类型
    ShowTypeIsShareRotationStyle, //横屏模式
    ShowTypeIsShareListPlayerStyle, //
} ShowType;

@interface ActionSheetView : UIView

@property (nonatomic,   copy) void(^cancelBlock)(void);

//回调
@property (nonatomic,copy) void(^callBackBlock)(NSError *error);

////点击按钮block回调
//@property (nonatomic,copy) UMSocialMessageObject*(^btnClick)(NSInteger);


/**
 *  初始化actionView
 *
 *  @param type       两种弹出类型(枚举)
 *
 *  @return wu
 */
- (id)initWithShareShowType:(ShowType)type;

- (id)initWithTagList;

/**
 分享的数据

 @param shareObject 数据 

 */
-(void)shareDataObject:(ShareDataObject *)shareObject;

@property (nonatomic, strong) UIWindow *window;

@end








