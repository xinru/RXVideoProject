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
//  DKSmallToolBar.m
//  DookayProject
//
//  Created by dookay_73 on 2019/9/27.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "DKSmallToolBar.h"

@interface DKSmallToolBar()

//播放按钮
@property (nonatomic, strong) UIButton *playBtn;
//全屏按钮
@property (nonatomic, strong) UIButton *fullScreenBtn;
//总时长
@property (nonatomic, strong) UILabel *totalTimeLabel;
//播放时长
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation DKSmallToolBar

- (instancetype)init
{
    if ([super init]) {
        
        UIImageView *bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_bg"]];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _playBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"start_play"]
                             selectedImage:[UIImage imageNamed:@"pause_play"]];
        [_playBtn addTarget:self
                     action:@selector(playerBtnAction:)
           forControlEvents:UIControlEventTouchDown];
        [self addSubview:_playBtn];
        
        _timeLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:13*ScaleX]
                                      text:@"00:00:00"
                                 textColor:[UIColor whiteColor]];
        [self addSubview:_timeLabel];
        
        [self addSubview:self.avSlider];
        
        _totalTimeLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:13*ScaleX]
                                           text:@"00:00:00"
                                      textColor:[UIColor whiteColor]];
        [self addSubview:_totalTimeLabel];
        
        _fullScreenBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"fullScreen"]
                                   selectedImage:[UIImage imageNamed:@"fullScreen"]];
        [_fullScreenBtn addTarget:self
                           action:@selector(clickedFullScreenAction)
                 forControlEvents:UIControlEventTouchDown];
        [self addSubview:_fullScreenBtn];
        
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.bottom.top.equalTo(self);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_playBtn.mas_right).offset(20*ScaleX);
            make.centerY.equalTo(_playBtn);
            make.width.mas_equalTo(60*ScaleX);
        }];
        [_fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15*ScaleX);
            make.top.bottom.equalTo(self);
        }];
        [_totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_fullScreenBtn.mas_left).offset(-20*ScaleX);
            make.centerY.equalTo(_fullScreenBtn);
            make.width.mas_equalTo(60*ScaleX);
        }];
        [self.avSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_timeLabel.mas_right).offset(10*ScaleX);
            make.right.equalTo(_totalTimeLabel.mas_left).offset(-15*ScaleX);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
}
#pragma mark - setter

- (void)setTimeStr:(NSString *)timeStr
{
    self.timeLabel.text = timeStr;
}
- (void)setTotalTimeStr:(NSString *)totalTimeStr
{
    self.totalTimeLabel.text = totalTimeStr;
}
- (void)setIsPlaying:(BOOL)isPlaying
{
    self.playBtn.selected = isPlaying;
}

#pragma mark - action
//快进快退
- (void)avSliderChangingAction
{
    if (self.clickedValueSliderBlock) {
        self.clickedValueSliderBlock(self.avSlider.value);
    }
}
- (void)avSliderChangedAction
{
    [self avSliderReloadAction:self.avSlider.value];
}
- (void)avSliderReloadAction:(CGFloat)value
{
    if (self.clickedSliderBlock) {
        self.clickedSliderBlock(value);
    }
}
//暂停播放
- (void)playerBtnAction:(UIButton *)btn
{
    if (self.clickedPlayBtnBlock) {
        self.clickedPlayBtnBlock(!btn.selected);
    }
    
}
//全屏
- (void)clickedFullScreenAction
{
    if (self.clickedFullScreenBlock) {
        self.clickedFullScreenBlock();
    }
}
#pragma mark - getter
- (RXSlider *)avSlider
{
    if (!_avSlider) {
        _avSlider = [[RXSlider alloc] init];
        _avSlider.minimumValue = 0;
        _avSlider.maximumTrackTintColor = [UIColor whiteColor];
        _avSlider.tintColor = UIColorFromRGB(0x1890FF);
        [_avSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];

        WS(weakSelf);
        [_avSlider setSliderChangedBlock:^(CGFloat value) {
            [weakSelf avSliderReloadAction:value];
        }];
        [_avSlider addTarget:self
                      action:@selector(avSliderChangingAction)
            forControlEvents:
         UIControlEventValueChanged];
        [_avSlider addTarget:self
                      action:@selector(avSliderChangedAction)
            forControlEvents:
         UIControlEventTouchUpInside|
                  UIControlEventTouchUpOutside];
    }
    return _avSlider;
}

@end
