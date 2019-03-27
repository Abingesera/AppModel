//
//  ShareDataObject.h
//  RacingCar
//
//  Created by 掌金-pang on 2018/8/1.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ShareTypeImage = 0,  //分享图片
    ShareTypeArticle,  //分享文章
    ShareTypeVideo, //分享视频
    ShareTypeAPP,//分享APP
    ShareTypePHOTO,//分享相册
} ShareType;

@interface ShareDataObject : NSObject

@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,strong) NSString * image;
@property (nonatomic,assign) ShareType shareType;

@property (nonatomic,copy) NSString *shareId;

@property (nonatomic,copy) NSString *webpageUrl;
@property (nonatomic,copy) NSString *miniPath;

@end
