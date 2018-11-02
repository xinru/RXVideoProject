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
//  DKPlayerControlView.m
//  RXAVPlayerMedia
//
//  Created by dookay_73 on 2018/9/25.
//  Copyright © 2018年 RX. All rights reserved.
//

#import "DKAVPlayerToolBar.h"
@interface DKAVPlayerToolBar()

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) UIButton *fullScreenBtn;

@property (nonatomic, strong) UILabel *timeLabel;



@end

@implementation DKAVPlayerToolBar
- (instancetype)init
{
    if ([super init]) {
        
        UIView *alphaView = [[UIView alloc] init];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0.5;
        [self addSubview:alphaView];
        [alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self addSubview:self.playBtn];
        [self addSubview:self.avSlider];
        [self addSubview:self.timeLabel];
        [self addSubview:self.fullScreenBtn];
//        [self addSubview:self.videoBtn];
        
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.width.height.mas_equalTo(20*ScaleX);
            make.centerY.equalTo(self);
        }];
        
//        [self.videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self).offset(-15*ScaleX);
//            make.height.mas_equalTo(20*ScaleX);
//            make.centerY.equalTo(self);
//        }];
        
        [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15*ScaleX);
            make.width.height.mas_equalTo(20*ScaleX);
            make.centerY.equalTo(self);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.fullScreenBtn.mas_left).offset(-15*ScaleX);
            make.centerY.equalTo(self.fullScreenBtn);
        }];
        
        [self.avSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(15*ScaleX);
            make.right.equalTo(self.timeLabel.mas_left).offset(-15*ScaleX);
            make.height.mas_equalTo(20*ScaleX);
            make.centerY.equalTo(self.playBtn);
        }];
        
    }
    return self;
}

#pragma mark - setter

- (void)setTimeStr:(NSString *)timeStr
{
    self.timeLabel.text = timeStr;
}
- (void)setIsPlay:(BOOL)isPlay
{
    self.playBtn.selected = isPlay;
}
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    self.fullScreenBtn.selected = isFullScreen;
}
#pragma mark - action
- (void)avSliderChangedAction
{
    self.clickedSliderBlock(self.avSlider.value);
}
- (void)playerBtnAction:(UIButton *)btn
{
//    btn.selected = !btn.selected;
    
    self.clickedPlayBtnBlock(!btn.selected);
}
- (void)fullScreenBtnAction
{
    self.fullScreenBtn.selected = !self.fullScreenBtn.selected;
    self.clickedFullScreenBlock(self.fullScreenBtn.selected);
}
//- (void)clickedVideoProfileAction:(UIButton *)btn
//{
//    self.changeVideoProfileBlock(btn.titleLabel.text);
//}
#pragma mark - getter

- (UISlider *)avSlider
{
    if (!_avSlider) {
        _avSlider = [[UISlider alloc] init];
        _avSlider.minimumValue = 0;
        _avSlider.maximumTrackTintColor = [UIColor whiteColor];
        _avSlider.tintColor = UIColorFromRGB(0x0E5BFF);
        [_avSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
        [_avSlider addTarget:self
                      action:@selector(avSliderChangedAction)
            forControlEvents:UIControlEventTouchUpInside|
         UIControlEventTouchCancel|
         UIControlEventTouchUpOutside];
    }
    return _avSlider;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [[UIButton alloc] init];
        [_playBtn setImage:[UIImage imageNamed:@"start_play"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"pause_play"] forState:UIControlStateSelected];
        [_playBtn addTarget:self
                     action:@selector(playerBtnAction:)
           forControlEvents:UIControlEventTouchDown];
    }
    return _playBtn;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UIButton *)fullScreenBtn
{
    if (!_fullScreenBtn) {
        _fullScreenBtn = [[UIButton alloc] init];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"fullScreen"] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:@"smallScreen"] forState:UIControlStateSelected];
        [_fullScreenBtn addTarget:self
                           action:@selector(fullScreenBtnAction)
                 forControlEvents:UIControlEventTouchDown];
    }
    return _fullScreenBtn;
}

//- (UIButton *)videoBtn
//{
//    if (!_videoBtn) {
//        _videoBtn = [MyTool buttonWithTitle:@"720P"
//                                 titleColor:UIColorFromRGB(0xFFFFFF)];
//        _videoBtn.titleLabel.font = [MyTool mediumFontWithSize:14*ScaleX];
//        _videoBtn.hidden = YES;
//        [_videoBtn addTarget:self action:@selector(clickedVideoProfileAction:) forControlEvents:UIControlEventTouchDown];
//    }
//    return _videoBtn;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
