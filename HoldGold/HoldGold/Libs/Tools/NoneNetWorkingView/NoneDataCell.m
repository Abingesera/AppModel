//
//  NoneDataCell.m
//  RacingCar
//
//  Created by 掌金 on 2018/7/25.
//  Copyright © 2018年 掌金. All rights reserved.
//

#import "NoneDataCell.h"

@implementation NoneDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUpViews];
    }
    return self;
}
#pragma mark 创建界面
- (void)setUpViews{
    
    _coverImageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-180)/2,20, 180, 120)];
    _coverImageV.image = [UIImage imageNamed:@"RCLive_CoverImg"];
    _coverImageV.hidden = YES;
//    _coverImageV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_coverImageV];
    
    _hintLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _coverImageV.bottom + 4, SCREEN_WIDTH, 22)];
    _hintLab.font = [FontTool setRegularFontWithSizeNumber:FontSixSizeNumber];
    _hintLab.textColor = [@"#999999" hexStringToColor];
    _hintLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_hintLab];
}

- (void)initWithCoverImageStr:(NSString *)imageStr WithHintStr:(NSString *)hintStr WithCellHeight:(CGFloat)height{
    if (!kStringIsEmpty(imageStr)) {
      _coverImageV.image = [UIImage imageNamed:imageStr];
    }
    _coverImageV.frame = CGRectMake((SCREEN_WIDTH-260*ScaleW)/2,(height - 182*ScaleW)/2-60*ScaleW, 260*ScaleW, 182*ScaleW);
//    _coverImageV.backgroundColor = [UIColor redColor];
//    _hintLab.frame = CGRectMake(0, _coverImageV.bottom + 4, SCREEN_WIDTH, 22);
    _coverImageV.hidden = NO;
    
//    _hintLab.text = hintStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
