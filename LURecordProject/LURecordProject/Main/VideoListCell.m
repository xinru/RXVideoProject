//
/*****************************************
 *                                       *
 *  @dookay.com Internet make it happen  *
 *  ----------- -----------------------  *
 *  dddd  ddddd Internet make it happen  *
 *  o   o     o Internet make it happen  *
 *  k    k    k Internet make it happen  *
 *  a   a     a Internet make it happen  *
 *  yyyy  yyyyy Internet make it happen  *
 *  ----------- -----------------------  *
 *  Say hello to the future.		     *
 *  hello，未来。                   	     *
 *  未来をその手に。                        *
 *                                       *
 *****************************************/
//
//  VideoListCell.m
//  DookayProject
//
//  Created by dookay_73 on 2019/9/20.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "VideoListCell.h"


@interface VideoListCell()

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@property (nonatomic, strong) UIImageView *lockImgV;

@end
@implementation VideoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        _lockImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock_icon"]];
//        [self addSubview:_lockImgV];
//
//        _imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//        [self addSubview:_imgV];
        
        _titleLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:16*ScaleX]
                                       text:@"两面性"
                                  textColor:UIColorFromRGB(0x333333)];
        [self addSubview:_titleLabel];
        
        _timeLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:14*ScaleX]
                                       text:@"时间长度：06:30"
                                  textColor:UIColorFromRGBA(0x000000, 0.45)];
        [self addSubview:_timeLabel];
        
        
                                                          
        _numLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:16*ScaleX]
                                     text:@"1"
                                textColor:UIColorFromRGBA(0x000000, 0.45)];
        [self addSubview:_numLabel];
        
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.centerY.equalTo(self);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_numLabel.mas_right).offset(15*ScaleX);
            make.top.equalTo(self).offset(8*ScaleX);
        }];
//        _titleLabel.backgroundColor = [UIColor orangeColor];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.right.equalTo(_titleLabel.mas_right);
            make.bottom.equalTo(self).offset(-10*ScaleX);
        }];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15*ScaleX);
            make.centerY.equalTo(self);
        }];
        [_lockImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_imgV.mas_left).offset(-10*ScaleX);
            make.centerY.equalTo(self);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorFromRGB(0xEEEEEE);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.right.equalTo(self).offset(-15*ScaleX);
            make.bottom.equalTo(self).offset(-1*ScaleX);
            make.height.mas_equalTo(1*ScaleX);
        }];
    }
    return self;
}

- (void)reloadData:(DKVideoModel *)courseModel index:(NSInteger)index
{
    _numLabel.text = [NSString stringWithFormat:@"%ld", index];
    _titleLabel.text = courseModel.mediaName;
    _timeLabel.text = [NSString stringWithFormat:@"时间长度：%ld", (long)courseModel.totalSeconds];
}

@end
