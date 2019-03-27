//
//  Enum.h
//  HoldGold
//
//  Created by 掌金 on 2019/3/18.
//  Copyright © 2019年 掌金. All rights reserved.
//

#ifndef Enum_h
#define Enum_h

/** 字体大小 */
typedef enum FontSizeNumber{
    FontOneSizeNumber =11, //一号字体 (最小字体, 依次增大) 11
    FontTwoSizeNumber, //二号字体 ...
    FontThreeSizeNumber,
    FontFourSizeNumber,
    FontFiveSizeNumber,
    FontSixSizeNumber,
    FontSevenSizeNumber,
    FontEightSizeNumber,
    FontNineSizeNumber,
    FontTenSizeNumber,
}FontSizeNumber;

//标识 下拉刷新 / 上拉加载, 每个界面可共用
typedef NS_ENUM(NSInteger, TableViewLoadType)
{
    TableViewUpLoadMore = 0,//上拉加载更多
    TableViewDownLoadLatest, //下拉获取最新
};

#endif /* Enum_h */
