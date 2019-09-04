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
//  DKAVPlayer.m
//  RXAVPlayerMedia
//
//  Created by dookay_73 on 2018/9/25.
//  Copyright © 2018年 RX. All rights reserved.
//

#import "DKAVPlayer.h"
#import "DKFullScreenVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "DKSelectView.h"
#import "UIAlertController+DY.h"

@interface DKAVPlayer()

//视频截图
@property (nonatomic, strong) UIImageView *mediaImageView;
//视频加载失败显示图
@property (nonatomic, strong) UIImageView *failPlayView;

//播放器
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

//是否全屏
@property (nonatomic, assign) BOOL isFullScreen;

//锁屏按钮
@property (nonatomic, strong) UIButton *lockAndUnlockBtn;

/*
 播放器控制条:
     全屏 DKAVPlayerToolBar
     竖屏 DKSmallToolBar
 */
@property (nonatomic, strong) DKAVPlayerToolBar *toolBar;
@property (nonatomic, strong) DKSmallToolBar *smallToolBar;

//**********************参数************************

//视频地址
@property (nonatomic, strong) NSString *mediaUrlStr;
//视频名称
@property (nonatomic, strong) NSString *mediaName;
//不同清晰度的视频集
//@property (nonatomic, strong) TransData *videoProfileUrlsDic;
//播放地址
@property (nonatomic, strong) NSURL *mediaUrl;

//是否准备好可以播放
@property (nonatomic, assign) BOOL isReadToPlay;


//总时长字符串 s 00:00:00
@property (nonatomic, strong) NSString *totalMediaSeconds;
//总时长 s
@property (nonatomic, assign) NSInteger totalSeconds;

//是否是已下载视频播放
@property (nonatomic, assign) BOOL isLocateVideo;

//播放速度
@property (nonatomic, assign) float videoRate;

@property (nonatomic, assign) NSInteger timeNum;

@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, strong) NSTimer *toolBarTimer;

//亮度、音量
@property (nonatomic, assign) BOOL isStart;//滑动一次确定zao方向
@property (assign, nonatomic) Direction direction;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) CGFloat startVB;
@property (nonatomic, strong) UISlider *volumeViewSlider;
@property (nonatomic, strong) VideoSliderView *sliderView;
@property (nonatomic, assign) CGFloat seekValue;

//切换清晰度时候的提示语
@property (nonatomic, strong) UILabel *tipLabel;

//是否隐藏收藏
@property (nonatomic, assign) BOOL HiddenToolBar;

//w非WiFI状态下是否播放视频
@property (nonatomic, assign) BOOL isWifiPlay;

@end

@implementation DKAVPlayer

- (void)dealloc
{
    [_toolBarTimer invalidate];
    _toolBarTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame isFullScreen:(BOOL)isFullScreen
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];

        //忽略静音按钮
        AVAudioSession *session =[AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        _isReadToPlay = NO;
        _isFullScreen = isFullScreen;
        _isLocateVideo = NO;
        _videoRate = 1.0;//默认正常速度播放
        _totalSeconds = 0;
//        _isWifiPlay = _CustomerInfo.isWifi;
        //播放器
        _player = [[AVPlayer alloc] init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.frame = self.bounds;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:_playerLayer];
        _playerLayer.backgroundColor = [UIColor clearColor].CGColor;
        
//        UI
        [self createSubViews];
        [self getSystemVolumSlider];
        
        self.userInteractionEnabled = YES;
        WS(weakSelf);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if (weakSelf.lockAndUnlockBtn.selected == NO) {
                if (!weakSelf.isPlaying) {
                    [weakSelf startPlay];
                }else{
                    [weakSelf pausePlay];
                }
            }
            
        }];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if (weakSelf.lockAndUnlockBtn.selected) {
                weakSelf.lockAndUnlockBtn.hidden = NO;
                weakSelf.toolBar.hidden = YES;
            }else{
                if (weakSelf.HiddenToolBar) {
                    [weakSelf showToolBar];
                }else{
                    [weakSelf hideToolBar];
                    
                }
            }
        }];
        [self addGestureRecognizer:tapGest];
        
//        测试视频地址
//        DKVideoModel *model = [[DKVideoModel alloc] init];
//        model.mediaUrlStr = @"http://v.dansewudao.com/444fccb3590845a799459f6154d2833f/fe86a70dc4b8497f828eaa19058639ba-6e51c667edc099f5b9871e93d0370245-sd.mp4";
//        model.totalSeconds = 7166;
//        _model = model;
    }
    return self;
}
- (void)createSubViews
{
    //视频截图/未播放时的默认图
    [self addSubview:self.mediaImageView];
    [self.mediaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(100*ScaleX);
    }];

    //    视频加载失败图
    [self addSubview:self.failPlayView];
    
    //    控制条
    CGFloat leftX = 20*ScaleX;
    if (IS_IPHONE_X) {
        leftX += X_head;
    }
    if (_isFullScreen) {
        [self addSubview:self.toolBar];
        //        锁屏
        [self addSubview:self.lockAndUnlockBtn];
        
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.lockAndUnlockBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self).offset(leftX);
            make.centerY.equalTo(self);
        }];
        
    }else{
        [self addSubview:self.smallToolBar];
        [self.smallToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(40*ScaleX);
        }];
    }
    
    //        切换清晰度的提示语
    _tipLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:13*ScaleX]
                                 text:@""
                            textColor:[UIColor whiteColor]];
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(60*ScaleX);
    }];
    
    _tipLabel.hidden = YES;
}
//处理本地及网络视频文件URL
- (NSURL *)getMediaURL:(NSString *)urlStr
{
    if (urlStr == nil) {
        return nil;
    }

    NSURL *mediaUrl = [NSURL URLWithString:urlStr];
    
    return mediaUrl;
}

//创建AVPlayer播放器
- (void)buildAVPlayerWithMediaURL:(NSURL *)urlStr
{
    if (urlStr == nil) {
        return;
    }
    _playerItem = [AVPlayerItem playerItemWithURL:urlStr];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];

    [self addNotifications];
}
#pragma mark - //全屏处理

//定时器功能，实现全屏播放时，5s以后隐藏导航栏
- (void)buildToolBarTimer
{
    _timeNum = 0;
    if (_toolBarTimer == nil) {
        WS(weakSelf);
        _toolBarTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
            weakSelf.timeNum ++;
            if (weakSelf.timeNum > 5) {
                [weakSelf hideToolBar];
                [_toolBarTimer invalidate];
                _toolBarTimer = nil;
            }
        } repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_toolBarTimer forMode:NSRunLoopCommonModes];
    }
    
}
#pragma mark - 获取视频相关信息方法
//获取视频某一帧的图像
- (UIImage *)getCoverMediaImage
{
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:_mediaUrl options:nil];
    
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    imageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [imageGenerator copyCGImageAtTime:CMTimeMake(5*24, 24) actualTime:NULL error:&thumbnailImageGenerationError];
    
    UIImage *thumbImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef]:nil;
    
    return thumbImage;
}
//    计算视频长度
- (void)getVideoTotalTime:(NSString *)urlString
{
    NSURL *urlStr = [self getMediaURL:urlString];
    //    计算视频长度
    if (_totalSeconds <= 0) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:urlStr
                                                   options:dic];
        NSInteger totalSecond = urlAsset.duration.value / urlAsset.duration.timescale;
        _totalSeconds = totalSecond;
    }
    
    _model.totalSeconds = _totalSeconds;
    _totalMediaSeconds = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", _totalSeconds/60/60, _totalSeconds/60%60, _totalSeconds%60];
    if (_isFullScreen) {
        self.toolBar.avSlider.maximumValue = _totalSeconds;
        self.toolBar.timeStr = [NSString stringWithFormat:@"00:00:00/%@", _totalMediaSeconds];
        self.toolBar.avSlider.value = 0;
    }else{
        self.smallToolBar.avSlider.maximumValue = _totalSeconds;
        self.smallToolBar.totalTimeStr = _totalMediaSeconds;
        self.smallToolBar.avSlider.value = 0;
    }
}
#pragma mark - setter
- (void)setModel:(DKVideoModel *)model
{
    _model = model;
    if (model.mediaUrlStr.length == 0) {
//        self.mediaImageView.yy_imageURL = [NSURL URLWithString:model.mediaImage];
        self.mediaImageView.hidden = NO;
        return;
    }
    _totalSeconds = model.totalSeconds;
    _currentValue = model.currentSeconds;
//解密处理是因为视频地址做了加密处理
//    NSString * url = [mediaUrlStr copy];
//    mediaUrlStr = [url LTAES128Decrypt];
    _mediaUrlStr = model.mediaUrlStr;
    _mediaUrl = [self getMediaURL:_mediaUrlStr];
    
    _mediaName = model.mediaName;
    self.toolBar.mediaName = _mediaName;
    
    
    [self getVideoTotalTime:_mediaUrlStr];
    
    [self buildAVPlayerWithMediaURL:_mediaUrl];

    
}


#pragma mark - 添加通知、kvo
- (void)addNotifications
{
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [_player addObserver:self
              forKeyPath:@"status" options:NSKeyValueObservingOptionNew
                 context:nil];
    
//    //监控网络加载情况属性
//    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//    //监听播放的区域缓存是否为空
//    [playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
//    //缓存可以播放的时候调用
//    [playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];

    
    // 前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];

}
#pragma mark - 视频播放处理
//开始播放
- (void)startPlay
{
//    if (!_isLocateVideo) {
//        _mediaUrl = [self getMediaURL:_mediaName];
//        if (_isLocateVideo) {
//            [self buildAVPlayerWithMediaURL:_mediaUrl];
//        }
//    }
    
    _isPlaying = NO;
    if (_isReadToPlay) {
        CGFloat value = _smallToolBar.avSlider.value;
        if (_isFullScreen) {
            value = _toolBar.avSlider.value;
            _isPlaying = YES;
        }
        if (_currentValue > 0 && _currentValue > value) {
            [self seekToTimePlay:_currentValue isPlaying:_isPlaying];
        }else{
            
            if (_isWifiPlay) {
            self.mediaImageView.hidden = YES;
            //        播放完成后，重新播放处理
            if (_currentValue >= _totalSeconds) {
                [self seekToTimePlay:0.0 isPlaying:_isPlaying];
            }
            [self buildPlayerTimer];
            
                
            [_player play];
            
            _isPlaying = YES;
            
            self.player.rate = _videoRate;

        }else{
//            UIAlertController *alter = [UIAlertController alertMessage:@"当前为非WIFI状态，是否继续播放"
//                                                           leftHandler:^(UIAlertAction *action) {
//                                                               _isWifiPlay = NO;
//                                                           }
//                                                          rightHandler:^(UIAlertAction *action) {
//                                                              _isWifiPlay =  YES;
//                                                              _CustomerInfo.isWifi = YES;
//                                                              [self startPlay];
//                                                          }
//                                                             leftTitle:@"取消"
//                                                            rightTitle:@"继续播放"];
//
//            [[[VCManager shareVCManager] getTopViewController] presentViewController:alter animated:YES completion:nil];
        }
        
        }
    }else{
        if (_isFullScreen == NO) {
            [MBProgressHUD showInfoMessage:@"视频正在加载中"];
        }
    }
    if (_isFullScreen) {
        self.toolBar.isPlaying = _isPlaying;
    }else{
        self.smallToolBar.isPlaying = _isPlaying;
    }
}

//暂停播放
- (void)pausePlay
{
    _isPlaying = NO;
    [self cancelTimer];
    [_player pause];
 
    if (_isFullScreen) {
        self.toolBar.isPlaying = _isPlaying;
    }else{
        self.smallToolBar.isPlaying = _isPlaying;
    }
    
}
- (void)buildPlayerTimer
{
    WS(weakself);
    if (self.playTimer == nil) {
        self.playTimer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                      target:weakself
                                                        selector:@selector(refreshSliderTime)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.playTimer forMode:NSRunLoopCommonModes];
    }
    
    [self.playTimer fire];
}
- (void)cancelTimer
{
    [self.playTimer invalidate];
    self.playTimer = nil;
}
//快进快退
- (void)seekToTimePlay:(float)value isPlaying:(BOOL)isPlaying
{
    if (value <= _totalSeconds) {
        CMTime startTime = CMTimeMakeWithSeconds(value, _playerItem.currentTime.timescale);
        [_player seekToTime:startTime completionHandler:^(BOOL finished) {
            if (finished) {
                _tipLabel.hidden = YES;
                [self refreshSliderTime];
                if (isPlaying) {
                    [self startPlay];
                }
            }
        }];
        
    }else{
        [self pausePlay];
    }
}
//播放时进度条移动
- (void)refreshSliderTime
{
    //获取当前视频的播放时长，根据当前的压缩比转换后， 以mm:ss 格式显示在label中
    float time = self.player.currentTime.value/self.player.currentTime.timescale;
    _currentValue = time;
    
    
    self.toolBar.avSlider.value = time;
    self.toolBar.timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d/%@", (int)time/60/60, (int)time/60%60, (int)time%60, self.totalMediaSeconds];

    self.smallToolBar.avSlider.value = time;
    self.smallToolBar.timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)time/60/60, (int)time/60%60, (int)time%60];


     //当视频结束时，停止定时器并将标志位置为 NO，以便点击play按钮时，可以直接播放视频，但是要注意在slide的事件下处理定时器
//    self.playerItem.duration.value/self.playerItem.duration.timescale
    if (_currentValue == _totalSeconds) {
        [self pausePlay];
        [self.toolBar setIsPlaying:NO];
        self.smallToolBar.isPlaying = NO;
    }
}

#pragma mark - 移除视频播放
- (void)removeAVPlayer
{
    [self pausePlay];
    [self.playerItem cancelPendingSeeks];
    [self.playerLayer removeFromSuperlayer];
    self.playerLayer = nil;
    self.player = nil;
}

#pragma mark - action
//锁屏
- (void)clickedLockAndUnlockBtnAction
{
    self.lockAndUnlockBtn.selected = !_lockAndUnlockBtn.selected;
    if (_lockAndUnlockBtn.selected == YES) {
        self.toolBar.hidden = YES;
    }else{
        self.toolBar.hidden = NO;
    }
}
//更换视频地址
- (void)refreshVideoUrlWithIndex:(NSInteger)index
{
//    self.sectionIndex = index;
//    SectionBrif *model = [self.sectionList objectAtIndex:index];
//    if (model.isTry || _isBuy) {
//        if (self.refreshVideoUrlBlcok) {
//            self.refreshVideoUrlBlcok(model.sectionId);
//        }
//    }else{
//        [MBProgressHUD showWarnMessage:@"您还没有购买将要播放的视频"];
//    }
    
}
#pragma mark - kvo 通知方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerStatusFailed:
            {
//                NSLog(@"url有误");
//                [MBProgressHUD showWarnMessage:@"url有误"];
                _isReadToPlay = NO;
                self.failPlayView.hidden = NO;
            }
                break;
            case AVPlayerStatusReadyToPlay:
            {
                NSLog(@"准备好播放了");
                _isReadToPlay = YES;
                self.failPlayView.hidden = YES;
                if (_isFullScreen) {
                    [self startPlay];
                }
                
            }
                break;
            case AVPlayerStatusUnknown:
            {
                NSLog(@"视频资源出现未知错误");
//                [MBProgressHUD showWarnMessage:@"视频资源出现未知错误"];
                _isReadToPlay = NO;
                self.failPlayView.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
    
//    else if([keyPath isEqualToString:@"loadedTimeRanges"]){
//        NSArray *array = playerItem.loadedTimeRanges;
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
//        float startSeconds = CMTimeGetSeconds(timeRange.start);
//        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
//        if (self.currentTime < (startSeconds + durationSeconds + 8)) {
//            self.viewLogin.hidden  = YES;
//            if ([self.btnPause.titleLabel.text isEqualToString:@"暂停"]) {
//                [_player play];
//            }
//        }else{
//            self.viewLogin.hidden = NO;
//        }
//        self.slider.bufferValue = totalBuffer/self.totalTime;
//        NSLog(@"缓冲：%.2f",totalBuffer);
//    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
//        NSLog(@"playbackBufferEmpty");
//        [self.viewLogin setHidden:YES];
//    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
//        [self.viewLogin setHidden:NO];
//        NSLog(@"playbackLikelyToKeepUp");
//    }

    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

- (void)enterForegroundNotification
{
    if (_isPlaying) {
        [self startPlay];
    }
}

- (void)enterBackgroundNotification
{
    if (_isPlaying) {
        [self pausePlay];
        _isPlaying = YES;
    }
}
- (void)hideToolBar
{
//    NSLog(@"11111111");
    self.HiddenToolBar = YES;
    if (_isFullScreen) {
        [_toolBarTimer invalidate];
        _toolBarTimer = nil;
        self.lockAndUnlockBtn.hidden = YES;
        [self.toolBar toolBarAnimationWithHidden:YES];
//        隐藏status bar
//        _fullPlayerVC.statusBarHidden = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGESTATUSBARHIDDEN" object:nil];
    }else{
        self.smallToolBar.hidden = YES;
    }
    
}
- (void)showToolBar
{
//    NSLog(@"000000000");
    self.HiddenToolBar = NO;
    if (_isFullScreen) {
        self.lockAndUnlockBtn.hidden = NO;
        [self.toolBar toolBarAnimationWithHidden:NO];
        [self buildToolBarTimer];
        //        显示status bar
//        _fullPlayerVC.statusBarHidden = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGESTATUSBARHIDDEN" object:nil];

    }else{
        self.smallToolBar.hidden = NO;
    }
    
}

#pragma mark - touch event

#pragma mark - 手势改变音量、亮度、快进快退

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isFullScreen) {
        return;
    }
    _isStart = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //记录首次触摸坐标
//    NSLog(@"开始==========%@",NSStringFromCGPoint(point));
    
    self.startPoint = point;
    
    //检测用户是触摸屏幕的左边还是右边，以此判断用户是要调节音量还是亮度，左边是亮度，右边是音量
    if (self.startPoint.x <= self.frame.size.width / 2.0) {
        //亮度
        self.startVB = [UIScreen mainScreen].brightness;
//        NSLog(@"亮度==++++++++++==%f", self.startVB);
    } else {
        //音量
        self.startVB = self.volumeViewSlider.value;
    }
    
    [_toolBar.selectView removeFromSuperview];
    _toolBar.selectView = nil;

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isFullScreen || _lockAndUnlockBtn.selected) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    //得出手指在Button上移动的距离
    CGPoint panPoint = CGPointMake(point.x - self.startPoint.x, point.y - self.startPoint.y);
    
//    NSLog(@"移动差==========%@",NSStringFromCGPoint(panPoint));
  
    //分析出用户滑动的方向
    if (!_isStart) {
        if (panPoint.x >= 30 || panPoint.x <= -30) {
            //进度
            self.direction = DirectionLeftOrRight;
            _isStart = YES;
        } else if (panPoint.y >= 30 || panPoint.y <= -30) {
            //音量和亮度
            self.direction = DirectionUpOrDown;
            _isStart = YES;
        } else {
            self.direction = DirectionNone;
        }
    }
    
    
    if (self.direction == DirectionNone) {
        return;
    } else if (self.direction == DirectionUpOrDown) {
        //音量和亮度
        if (self.startPoint.x <= self.frame.size.width / 2.0) {
            //调节亮度
            float value;
            if (panPoint.y < 0) {
                //增加亮度
                value = self.startVB + (-panPoint.y / 25.0 / 10);
                if (value > 1) {
                    value = 1;
                }
            } else {
                //减少亮度
                value = self.startVB - (panPoint.y / 25.0 / 10);
                if (value < 0) {
                    value = 0;
                }
                
            }
            [UIScreen mainScreen].brightness = value;
            
            self.sliderView.type = IconTypeSun;
            self.sliderView.value = value;
        } else {
            //音量
            float value;
            if (panPoint.y < 0) {
                //增大音量
                value = self.startVB + (-panPoint.y / 25.0 / 10);
                if (value > 1) {
                    value = 1;
                }
                
            } else {
                //减少音量
                value = self.startVB - (panPoint.y / 25.0 / 10);
                if (value < 0) {
                    value = 0;
                }
            }
            
            [self.volumeViewSlider setValue:self.startVB - (panPoint.y / 25.0 / 10) animated:NO];
            
            self.sliderView.type = IconTypeVoice;
            self.sliderView.value = value;
        }
    } else if (self.direction == DirectionLeftOrRight ) {
        //进度
        CGFloat rate = 0;
        if (panPoint.x > 30 ) {
            rate = panPoint.x/mainWidth * self.totalSeconds;  //前进
            self.seekValue = self.currentValue + rate;
            if (self.seekValue > self.totalSeconds) {
                self.seekValue = self.totalSeconds;
            }
        } else if (panPoint.x < -30) {
            rate = (-panPoint.x)/mainWidth * self.totalSeconds; // 后退
            self.seekValue = self.currentValue - rate;
            if (self.seekValue < 0) {
                self.seekValue = 0;
            }
        }
        self.sliderView.type = IconTypeValue;
        self.sliderView.totalTime = self.totalMediaSeconds;
        self.sliderView.value = self.seekValue;
        
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_isFullScreen || _lockAndUnlockBtn.selected) {
        return;
    }
    if (self.direction == DirectionLeftOrRight) {
        
        [self seekToTimePlay:self.seekValue isPlaying:_isPlaying];
//        [self showToolBar];
        //        [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.total * self.currentRate, 1) completionHandler:^(BOOL finished) {
        //            //在这里处理进度设置成功后的事情
        //        }];
    }
    //     音量和亮度
    [_sliderView removeFromSuperview];
    _sliderView = nil;
    
}

- (void)getSystemVolumSlider
{
    self.volumeViewSlider = nil;
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView* newView in volumeView.subviews) {
        if ([newView.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider*)newView;
            break;
        }
    }
    self.volumeViewSlider.frame = CGRectMake(-100, -100, 10, 10);
    [self.volumeViewSlider setHidden:NO];
    [self addSubview:self.volumeViewSlider];
}

#pragma mark - getter
- (VideoSliderView *)sliderView
{
    if (!_sliderView) {
        _sliderView = [[VideoSliderView alloc] initWithType:IconTypeVoice];
        [self addSubview:_sliderView];
        [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(120*ScaleX);
            make.height.mas_equalTo(20*ScaleX);
        }];
    }
    return _sliderView;
}
#pragma mark - getter

- (UIImageView *)mediaImageView
{
    if (!_mediaImageView) {
        _mediaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_nomal"]];
//        _mediaImageView.image = [self getCoverMediaImage];
        _mediaImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mediaImageView.hidden = YES;
    }
    return _mediaImageView;
}
- (UIImageView *)failPlayView
{
    if (!_failPlayView) {
        _failPlayView = [[UIImageView alloc] initWithFrame:self.bounds];
        _failPlayView.image = [UIImage imageNamed:@"fail_play"];
        _failPlayView.contentMode = UIViewContentModeScaleAspectFill;
        _failPlayView.hidden = YES;
    }
    return _failPlayView;
}

- (UIButton *)lockAndUnlockBtn
{
    if (!_lockAndUnlockBtn) {
        _lockAndUnlockBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"video_unLock"]
                                      selectedImage:[UIImage imageNamed:@"video_lock"]];
        [_lockAndUnlockBtn addTarget:self
                              action:@selector(clickedLockAndUnlockBtnAction)
                    forControlEvents:UIControlEventTouchDown];
    }
    return _lockAndUnlockBtn;
}
- (DKAVPlayerToolBar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[DKAVPlayerToolBar alloc] init];
        
        WS(weakSelf);
//         快进快退，滑动的时候暂停播放只更改进度条边上的时间显示，当手指移开的时候已最后一的value值做快进快退操作，避免视频出现闪现的bug（因为快进快退是延迟的）
        [_toolBar setClickedSliderBlock:^(float value) {
            [weakSelf seekToTimePlay:value isPlaying:weakSelf.isPlaying];
            if (weakSelf.isFullScreen) {
                [weakSelf.sliderView removeFromSuperview];
                weakSelf.sliderView = nil;
            }
        }];
        [_toolBar setClickedSliderValueBlock:^(float value) {
            weakSelf.sliderView.type = IconTypeValue;
            weakSelf.sliderView.totalTime = weakSelf.totalMediaSeconds;
            weakSelf.sliderView.value = value;
        }];
        //播放/暂停
        [_toolBar setClickedPlayBtnBlock:^(BOOL isPlay) {
            if (isPlay) {
                [weakSelf startPlay];
            }else{
                [weakSelf pausePlay];
            }
        }];
//        点击返回，退出全屏
        [_toolBar setClickedBackBlock:^{
            if (weakSelf.dismissFullScreenBlcok) {
                weakSelf.dismissFullScreenBlcok();
            }
        }];
//        倍速播放
        [_toolBar setChangeVideoRateBlock:^(float rate) {
            weakSelf.videoRate = rate;
            weakSelf.player.rate = rate;
        }];
//      切换清晰度
        [_toolBar setChangeVideoProfileBlock:^(NSString *videoName) {
            weakSelf.tipLabel.hidden = NO;
            weakSelf.tipLabel.text = [NSString stringWithFormat:@"正在为您切换%@清晰度，请稍后...", videoName];
            [MyTool setTextColor:weakSelf.tipLabel
                   andFontNumber:weakSelf.tipLabel.font
                     andRangeStr:videoName
                        andColor:kYellowColor];
//            if ([videoName isEqualToString:@"标清"]) {
//                weakSelf.mediaUrlStr = weakSelf.videoProfileUrlsDic.s480;
//            }else if ([videoName isEqualToString:@"高清"]) {
//                weakSelf.mediaUrlStr = weakSelf.videoProfileUrlsDic.s720;
//            }else{
//                weakSelf.mediaUrlStr = weakSelf.videoProfileUrlsDic.s1080;
//            }
            [weakSelf seekToTimePlay:weakSelf.currentValue isPlaying:_isPlaying];
        }];
        
//        播放下一级
        [_toolBar setClickedNextVideoBlock:^{
//            weakSelf.sectionIndex ++;
//            if (weakSelf.sectionIndex > weakSelf.sectionList.count-1) {
//                [MBProgressHUD showWarnMessage:@"没有下一个了~"];
//            }else{
//                [weakSelf refreshVideoUrlWithIndex:weakSelf.sectionIndex];
//            }
        }];
        _toolBar.refreshVideoUrlBlock = ^(NSInteger index) {
            [weakSelf refreshVideoUrlWithIndex:index];
        };
    }
    return _toolBar;
}

- (DKSmallToolBar *)smallToolBar
{
    if (!_smallToolBar) {
        _smallToolBar = [[DKSmallToolBar alloc] init];
        
        WS(weakSelf);
        //        快进快退
        [_smallToolBar setClickedSliderBlock:^(float value) {
            [weakSelf seekToTimePlay:value isPlaying:weakSelf.isPlaying];
        }];
        [_smallToolBar setClickedValueSliderBlock:^(float value) {
            [weakSelf.player pause];
            weakSelf.smallToolBar.timeStr = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)value/60/60, (int)value/60, (int)value%60];
        }];
        //播放/暂停
        [_smallToolBar setClickedPlayBtnBlock:^(BOOL isPlay) {
            if (isPlay) {
                [weakSelf startPlay];
            }else{
                [weakSelf pausePlay];
            }
        }];
//        全屏
        [_smallToolBar setClickedFullScreenBlock:^{
            [weakSelf pausePlay];
            DKFullScreenVC *fullPlayerVC = [[DKFullScreenVC alloc] init];
            weakSelf.model.currentSeconds = weakSelf.currentValue;
            fullPlayerVC.model = weakSelf.model;
            fullPlayerVC.quitFullScreenBlock = ^(CGFloat value) {
                [weakSelf seekToTimePlay:value isPlaying:YES];
            };
            UIViewController *vc = [[VCManager shareVCManager] getTopViewController];
            [vc presentViewController:fullPlayerVC animated:NO completion:nil];
    
        }];
    }
    return _smallToolBar;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
