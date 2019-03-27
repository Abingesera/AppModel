//
//  NoneDataCell.h
//  RacingCar
//
//  Created by 掌金 on 2018/7/25.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneDataCell : UITableViewCell

@property (nonatomic,strong) UIImageView *coverImageV;
@property (nonatomic,strong) UILabel *hintLab;
//图片 跟说明语
- (void)initWithCoverImageStr:(NSString *)imageStr WithHintStr:(NSString *)hintStr WithCellHeight:(CGFloat)height;

@end
