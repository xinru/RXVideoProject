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

//头部
@property (nonatomic, strong) UIImageView *headView;
//返回按钮和标题
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;

//底部
@property (nonatomic, strong) UIImageView *bottomView;
//播放按钮
@property (nonatomic, strong) UIButton *playBtn;
//时长
@property (nonatomic, strong) UILabel *timeLabel;
////下一个视频
//@property (nonatomic, strong) UIButton *nextBtn;
////切换清晰度按钮
//@property (nonatomic, strong) UIButton *definitionBtn;
////倍速按钮
//@property (nonatomic, strong) UIButton *speedBtn;
////选集
//@property (nonatomic, strong) UIButton *anthonyBtn;

//倍速数组 1.0 1.25 1.5 2.0
@property (nonatomic, strong) NSArray *rateArray;
@property (nonatomic, assign) NSInteger rateIndex;

@end

@implementation DKAVPlayerToolBar
- (instancetype)init
{
    if ([super init]) {
        
        _rateArray = @[@"0.75x", @"1.0x", @"1.25x", @"1.5x", @"2.0x"];
        _rateIndex = 1;
        
        _headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_bg"]];
        _headView.userInteractionEnabled = YES;
        [self addSubview:_headView];
        [_headView addSubview:self.backBtn];
        [_headView addSubview:self.titleLabel];
        
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(50*ScaleX);
        }];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headView).offset(15*ScaleX);
            make.top.equalTo(_headView).offset(15*ScaleX);
            make.width.height.mas_equalTo(30*ScaleX);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backBtn.mas_right).offset(5*ScaleX);
            make.centerY.equalTo(self.backBtn);
        }];
        
        
        _bottomView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_bg"]];
        _bottomView.userInteractionEnabled = YES;
        [self addSubview:_bottomView];
//        _bottomView.backgroundColor = [UIColor orangeColor];
        [_bottomView addSubview:self.playBtn];
        [_bottomView addSubview:self.avSlider];
        [_bottomView addSubview:self.timeLabel];
//        [_bottomView addSubview:self.nextBtn];
//        [_bottomView addSubview:self.definitionBtn];
//        [_bottomView addSubview:self.speedBtn];
//        [_bottomView addSubview:self.anthonyBtn];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(60*ScaleX);
        }];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView).offset(15*ScaleX);
            make.width.height.mas_equalTo(30*ScaleX);
            make.bottom.equalTo(_bottomView).offset(-5*ScaleX);
        }];
//        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.playBtn.mas_right).offset(30*ScaleX);
//            make.centerY.equalTo(self.playBtn);
//        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBtn.mas_right).offset(15*ScaleX);
            make.centerY.equalTo(self.playBtn);
        }];
        [self.avSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bottomView).offset(15*ScaleX);
            make.right.equalTo(_bottomView).offset(-15*ScaleX);
            make.height.mas_equalTo(20*ScaleX);
            make.bottom.equalTo(self.playBtn.mas_top).offset(-0*ScaleX);
        }];
//        [self.anthonyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.avSlider.mas_right);
//            make.centerY.equalTo(self.playBtn);
//        }];
//        [self.speedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.anthonyBtn.mas_left).offset(-30*ScaleX);
//            make.centerY.equalTo(self.playBtn);
//        }];
//        [self.definitionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.speedBtn.mas_left).offset(-30*ScaleX);
//            make.centerY.equalTo(self.playBtn);
//        }];
        
    }
    return self;
}
- (void)toolBarAnimationWithHidden:(BOOL)isHidden
{
    if (isHidden) {
        [UIView animateWithDuration:0.6
                         animations:^{
                             _headView.y = -60*ScaleX;
                             _bottomView.y = self.height;
                             _bottomView.hidden = YES;
                             _headView.hidden = YES;
                         }];
    }else{
        [UIView animateWithDuration:0.6
                         animations:^{
                             _headView.y = 0;
                             _bottomView.y = self.height - _bottomView.height;
                             _headView.hidden = NO;
                             _bottomView.hidden = NO;
                         }];
    }
}
#pragma mark - setter

- (void)setTimeStr:(NSString *)timeStr
{
    self.timeLabel.text = timeStr;
}
- (void)setIsPlaying:(BOOL)isPlaying
{
    self.playBtn.selected = isPlaying;
}
- (void)setMediaName:(NSString *)mediaName
{
    self.titleLabel.text = mediaName;
}
#pragma mark - action
- (void)avSliderChangedAction
{
    if (self.clickedSliderBlock) {
        self.clickedSliderBlock(self.avSlider.value);
    }
    
}
- (void)avSliderValueChangingAction
{
    if (self.clickedSliderValueBlock) {
        self.clickedSliderValueBlock(self.avSlider.value);
    }
}
- (void)playerBtnAction:(UIButton *)btn
{
    if (self.clickedPlayBtnBlock) {
        self.clickedPlayBtnBlock(!btn.selected);
    }
    
}
- (void)clickedBackBtnAction
{
    if (self.clickedBackBlock) {
        self.clickedBackBlock();
    }
}
- (void)clickedNextVideoAction
{
    if (self.clickedNextVideoBlock) {
        self.clickedNextVideoBlock();
    }
}
- (void)clickedSpeedBtnAction
{
    if (_selectView) {
        [_selectView removeFromSuperview];
        _selectView = nil;
    }else{
        CGFloat edge = 0;
        if (IS_IPHONE_X) {
            edge = X_foot;
        }
        _selectView = [[DKSelectView alloc] init];
        _selectView.selectViewType = SelectViewTypeRate;
        _selectView.selectedIndex = _rateIndex;
        _selectView.dataArray = _rateArray;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(edge);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(150*ScaleX);
        }];
        WS(weakSelf);
        [_selectView setRefreshVideoRateBlock:^(NSString * _Nonnull rateStr, NSInteger index) {
            weakSelf.rateIndex = index;
//                [weakSelf.speedBtn setTitle:rateStr forState:UIControlStateNormal];
            
                CGFloat rate = 1.0;
                switch (index) {
                    case 0:
                        rate = 0.75;
                        break;
                    case 1:
                        rate = 1.0;
                        break;
                    case 2:
                        rate = 1.25;
                        break;
                    case 3:
                        rate = 1.5;
                        break;
                    case 4:
                        rate = 2.0;
                        break;
                    default:
                        break;
                }
                if (weakSelf.changeVideoRateBlock) {
                    weakSelf.changeVideoRateBlock(rate);
                }
        }];
    }
//    _rateIndex++;
//    if (_rateIndex >= _rateArray.count) {
//        _rateIndex = 0;
//    }
//    [_speedBtn setTitle:_rateArray[_rateIndex] forState:UIControlStateNormal];
//    
//    CGFloat rate = 1.0;
//    switch (_rateIndex) {
//        case 0:
//            rate = 1.0;
//            break;
//        case 1:
//            rate = 1.25;
//            break;
//        case 2:
//            rate = 1.5;
//            break;
//        case 3:
//            rate = 2.0;
//            break;
//        default:
//            break;
//    }
//    if (self.changeVideoRateBlock) {
//        self.changeVideoRateBlock(rate);
//    }
}
- (void)clickedVideoProfileAction:(UIButton *)btn
{
    if (_selectView) {
        [_selectView removeFromSuperview];
        _selectView = nil;
    }else{
        CGFloat edge = 0;
        if (IS_IPHONE_X) {
            edge = X_foot;
        }
        _selectView = [[DKSelectView alloc] init];
        _selectView.selectViewType = SelectViewTypeDefinition;
        _selectView.currentProfile = btn.titleLabel.text;
        [self addSubview:self.selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(edge);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(150*ScaleX);
        }];
        
        WS(weakSelf);
        [_selectView setRefreshVideoProfileBlock:^(NSString * _Nonnull videoProfile) {
            [btn setTitle:videoProfile forState:UIControlStateNormal];
            if (weakSelf.changeVideoProfileBlock) {
                weakSelf.changeVideoProfileBlock(videoProfile);
            }
        }];
    }
    
}

- (void)anthonyBtnAction
{
    if (_selectView) {
        [_selectView removeFromSuperview];
        _selectView = nil;
    }else{
        CGFloat edge = 0;
        if (IS_IPHONE_X) {
            edge = X_foot;
        }
        _selectView = [[DKSelectView alloc] init];
        _selectView.selectedIndex = _selectedIndex;
        _selectView.dataArray = _dataArray;
        [[UIApplication sharedApplication].keyWindow addSubview:self.selectView];
        [_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(edge);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(150*ScaleX);
        }];
        WS(weakSelf);
        [_selectView setRefreshVideoUrlBlock:^(NSInteger index) {
            if (weakSelf.refreshVideoUrlBlock) {
                weakSelf.refreshVideoUrlBlock(index);
            }
        }];
    }
}
#pragma mark - getter
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"video_back"]
                             selectedImage:[UIImage imageNamed:@"video_back"]];
        [_backBtn addTarget:self action:@selector(clickedBackBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _backBtn;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                       text:@"1.3 437947r03ur03"
                                  textColor:UIColorFromRGB(0xFFFFFF)];
    }
    return _titleLabel;
}
- (UISlider *)avSlider
{
    if (!_avSlider) {
        _avSlider = [[UISlider alloc] init];
        _avSlider.minimumValue = 0;
        _avSlider.maximumTrackTintColor = [UIColor whiteColor];
        _avSlider.tintColor = kYellowColor;
        [_avSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
        [_avSlider addTarget:self
                      action:@selector(avSliderChangedAction)
            forControlEvents:UIControlEventTouchUpInside|
         UIControlEventTouchCancel|
         UIControlEventTouchUpOutside];
        [_avSlider addTarget:self
                      action:@selector(avSliderValueChangingAction)
            forControlEvents:UIControlEventValueChanged];
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
//        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:10*ScaleX];
    }
    return _timeLabel;
}

//- (UIButton *)definitionBtn
//{
//    if (!_definitionBtn) {
//        _definitionBtn = [MyTool buttonWithTitle:@"标清"
//                                      titleColor:kWhiteColor
//                                       titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
//        [_definitionBtn addTarget:self action:@selector(clickedVideoProfileAction:) forControlEvents:UIControlEventTouchDown];
//    }
//    return _definitionBtn;
//}
//
//- (UIButton *)nextBtn
//{
//    if (!_nextBtn) {
//        _nextBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"next_video"]
//                             selectedImage:[UIImage imageNamed:@"next_video"]];
//        [_nextBtn addTarget:self
//                     action:@selector(clickedNextVideoAction)
//           forControlEvents:UIControlEventTouchDown];
//
//    }
//    return _nextBtn;
//}
//
//- (UIButton *)speedBtn
//{
//    if (!_speedBtn) {
//        _speedBtn = [MyTool buttonWithTitle:@"1.0x"
//                                 titleColor:kWhiteColor
//                                  titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
//        [_speedBtn addTarget:self
//                      action:@selector(clickedSpeedBtnAction)
//            forControlEvents:UIControlEventTouchDown];
//    }
//    return _speedBtn;
//}
//
//- (UIButton *)anthonyBtn
//{
//    if (!_anthonyBtn) {
//        _anthonyBtn = [MyTool buttonWithTitle:@"选集"
//                                   titleColor:kWhiteColor
//                                    titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
//        [_anthonyBtn addTarget:self
//                        action:@selector(anthonyBtnAction)
//              forControlEvents:UIControlEventTouchDown];
//    }
//    return _anthonyBtn;
//}




@end

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
- (void)avSliderChangedAction
{
    if (self.clickedValueSliderBlock) {
        self.clickedValueSliderBlock(self.avSlider.value);
    }
}
- (void)avSliderReloadAction
{
    if (self.clickedSliderBlock) {
        self.clickedSliderBlock(self.avSlider.value);
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
- (UISlider *)avSlider
{
    if (!_avSlider) {
        _avSlider = [[UISlider alloc] init];
        _avSlider.minimumValue = 0;
        _avSlider.maximumTrackTintColor = [UIColor whiteColor];
        _avSlider.tintColor = kYellowColor;
        [_avSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
//        [_avSlider addTarget:self
//                      action:@selector(avSliderChangedAction)
//            forControlEvents:UIControlEventTouchUpInside|
//         UIControlEventTouchCancel|
//         UIControlEventTouchUpOutside|UIControlEventValueChanged];
        [_avSlider addTarget:self
                      action:@selector(avSliderChangedAction)
            forControlEvents:
         UIControlEventValueChanged];
        [_avSlider addTarget:self
                      action:@selector(avSliderReloadAction)
            forControlEvents:
         UIControlEventTouchUpInside];
    }
    return _avSlider;
}

@end
