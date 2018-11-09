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
#import "DKAVPlayerToolBar.h"
#import "DKFullScreenVC.h"

@interface DKAVPlayer()

//视频截图
@property (nonatomic, strong) UIImageView *mediaImageView;

//视频加载失败显示图
@property (nonatomic, strong) UIImageView *failPlayView;

//播放器
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

//播放器控制条
@property (nonatomic, strong) DKAVPlayerToolBar *toolBar;

@property (nonatomic, strong) UIView *fullScreenTopView;
//返回按钮和标题
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UIView *videoProfileView;
@property (nonatomic, strong) NSMutableArray *videoProfileArray;

//锁屏按钮
@property (nonatomic, strong) UIButton *lockAndUnlockBtn;

//切换清晰度按钮
@property (nonatomic, strong) UIButton *videoBtn;

//播放地址
@property (nonatomic, strong) NSURL *mediaUrl;

//是否准备好可以播放
@property (nonatomic, assign) BOOL isReadToPlay;
//是否在播放
@property (nonatomic, assign) BOOL isPlay;

//总时长 s 00:00
@property (nonatomic, strong) NSString *totalMediaSeconds;

//当前播放的value
@property (nonatomic, assign) CGFloat currentValue;
//是否是已下载视频播放
@property (nonatomic, assign) BOOL isLocateVideo;

@end

@implementation DKAVPlayer

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame andMediaURL:(NSString *)urlStr
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
//        urlStr = @"http://v.dansewudao.com/444fccb3590845a799459f6154d2833f/fe86a70dc4b8497f828eaa19058639ba-6e51c667edc099f5b9871e93d0370245-sd.mp4";
        
        _isReadToPlay = NO;
        _isFullScreen = NO;
        _isLocateVideo = NO;
        //播放器
        if (urlStr.length > 0) {
            _mediaUrlStr = urlStr;
            _mediaUrl = [self getMediaURL:_mediaUrlStr];
            self.playerItem = [AVPlayerItem playerItemWithURL:_mediaUrl];
        }
        _player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
        
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.frame = self.bounds;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.layer addSublayer:_playerLayer];
        _playerLayer.backgroundColor = [UIColor clearColor].CGColor;
  
        //视频截图
        //    [self addSubview:self.mediaImageView];
        
        //    视频加载失败图
        [self addSubview:self.failPlayView];
        
        //    控制条
        [self addSubview:self.toolBar];
        //头部View
        [self addSubview:self.fullScreenTopView];
        [self.fullScreenTopView addSubview:self.backBtn];
        [self.fullScreenTopView addSubview:self.titleLabel];
        [self.fullScreenTopView addSubview:self.downloadBtn];
        [self.fullScreenTopView addSubview:self.shareBtn];
        [self addSubview:self.lockAndUnlockBtn];
   
        [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(30*ScaleX);
        }];
        
        [self.fullScreenTopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(60*ScaleX);
        }];
        
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.fullScreenTopView).offset(-20*ScaleX);
            make.centerY.equalTo(self.backBtn);
            make.width.height.mas_equalTo(20*ScaleX);
        }];
        [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.shareBtn.mas_left).offset(-20*ScaleX);
            make.centerY.equalTo(self.backBtn);
            make.width.height.mas_equalTo(20*ScaleX);
        }];
        
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.fullScreenTopView).offset(10*ScaleX);
            make.width.mas_equalTo(30*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backBtn.mas_right);
//            make.right.equalTo(self.zanBtn.mas_left).offset(-10*ScaleX);
            make.centerY.equalTo(self.backBtn);
        }];

        [self.lockAndUnlockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20*ScaleX);
            make.centerY.equalTo(self);
        }];
        
        [self addSubview:self.videoProfileView];
        [self.videoProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(160*ScaleX);
        }];
        
        [self addSubview:self.videoBtn];
        [self.videoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15*ScaleX);
            make.height.mas_equalTo(20*ScaleX);
            make.centerY.equalTo(self);
        }];
        
        _mediaUrl = [self getMediaURL:urlStr];
        [self buildAVPlayerWithMediaURL:_mediaUrl];
        
    }
    return self;
}

//处理本地及网络视频文件URL
- (NSURL *)getMediaURL:(NSString *)urlStr
{
    if (urlStr == nil) {
        return nil;
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kDownloadVideoList];

    for (NSDictionary *dic in array) {
        if ([urlStr rangeOfString:dic[@"url"]].location != NSNotFound) {
            NSString *filePath = dic[@"filePath"];
            if (filePath.length > 0) {
                _isLocateVideo = YES;
                _videoBtn.hidden = YES;
                return [NSURL fileURLWithPath:dic[@"filePath"]];
            }
            
        }
    }
    NSURL *mediaUrl;
    if (![urlStr hasPrefix:@"http"]) {
//        本地视频
        urlStr = [[NSBundle mainBundle] pathForResource:urlStr ofType:@""];
        mediaUrl = [NSURL fileURLWithPath:urlStr];
    }else{
        mediaUrl = [NSURL URLWithString:urlStr];
    }
    
    return mediaUrl;
}

//更新playerItem
- (void)buildAVPlayerWithMediaURL:(NSURL *)urlStr
{
    if (urlStr == nil) {
        return;
    }
    _playerItem = [AVPlayerItem playerItemWithURL:urlStr];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    [self getVideoTotalTime:urlStr];

    [self addNotifications];
}
#pragma mark - //全屏处理
- (void)layoutSubviews
{
    _playerLayer.frame = self.bounds;
    self.titleLabel.frame = CGRectMake(DEF_RIGHT(self.backBtn), 30*ScaleX, self.width-30*ScaleX, 40*ScaleX);
    self.titleLabel.centerY = self.backBtn.centerY;
    
    if (_isFullScreen) {
        if (!_isLocateVideo) {
            self.videoBtn.hidden = NO;
        }
        self.fullScreenTopView.hidden = NO;
        self.lockAndUnlockBtn.hidden = NO;
        
        CGFloat leftX = 20*ScaleX;
        if (IS_IPHONE_X) {
            leftX += X_head;
        }
        [self.toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(leftX);
            make.right.equalTo(self).offset(-20*ScaleX);
            make.bottom.equalTo(self).offset(-10*ScaleX);
        }];
        [self.lockAndUnlockBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(leftX);
        }];
    }else{
        self.videoBtn.hidden = YES;
        self.fullScreenTopView.hidden = YES;
        self.lockAndUnlockBtn.hidden = YES;
        
        [self.toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [self.lockAndUnlockBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20*ScaleX);
        }];
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
- (void)getVideoTotalTime:(NSURL *)urlStr
{
    //    计算视频长度
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:urlStr
                                               options:dic];
    NSInteger totalSecond = urlAsset.duration.value / urlAsset.duration.timescale;
    _totalMediaSeconds = [NSString stringWithFormat:@"%02ld:%02ld", totalSecond/60, totalSecond%60];
    self.toolBar.avSlider.maximumValue = totalSecond;
    self.toolBar.timeStr = [NSString stringWithFormat:@"00:00/%@", _totalMediaSeconds];
}
#pragma mark - setter
- (void)setMediaUrlStr:(NSString *)mediaUrlStr
{
    _mediaUrlStr = mediaUrlStr;
    _mediaUrl = [self getMediaURL:mediaUrlStr];
    [self buildAVPlayerWithMediaURL:_mediaUrl];
}
- (void)setMediaName:(NSString *)mediaName
{
    _mediaName = mediaName;
    self.titleLabel.text = mediaName;
}
- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    self.toolBar.isFullScreen = isFullScreen;
}
#pragma mark - 添加通知、kvo
- (void)addNotifications
{
    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [_player addObserver:self
              forKeyPath:@"status" options:NSKeyValueObservingOptionNew
                 context:nil];
    
    // 前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    // 后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
//    一定时间后隐藏控制栏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideAVPlayerToolBar) name:@"AVPLAYERTOOLBARHIDDEN" object:nil];
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
    
    _isPlay = NO;
    if (_isReadToPlay) {
        
        self.mediaImageView.hidden = YES;
        
        [self buildTimer];
        
        [_player play];
        
        _isPlay = YES;
        
    }else{
        [MBProgressHUD showWarnMessage:@"视频正在加载中"];
    }
    
    self.toolBar.isPlay = _isPlay;
}

//暂停播放
- (void)pausePlay
{
    _isPlay = NO;
    [self cancelTimer];
    [_player pause];
    self.toolBar.isPlay = _isPlay;
}
- (void)buildTimer
{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                      target:self selector:@selector(refreshSliderTime)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    [self.timer fire];
}
- (void)cancelTimer
{
    [self.timer invalidate];
    self.timer = nil;
}
//快进快退
- (void)seekToTimePlay:(float)value
{
    if (value <=_toolBar.avSlider.maximumValue) {
        CMTime startTime = CMTimeMakeWithSeconds(value, _playerItem.currentTime.timescale);
        [_player seekToTime:startTime completionHandler:^(BOOL finished) {
            if (finished) {
                if (self.isPlay) {
                    [self startPlay];
                }else{
                    [self refreshSliderTime];
                }
            }
        }];
        
    }else{
        [self pausePlay];
    }
}
//进度条移动
- (void)refreshSliderTime
{
    //获取当前视频的播放时长，根据当前的压缩比转换后， 以mm:ss 格式显示在label中
    float time = self.player.currentTime.value/self.player.currentTime.timescale;
    _currentValue = time;
    self.toolBar.avSlider.value = time;
    self.toolBar.timeStr = [NSString stringWithFormat:@"%02d:%02d/%@", (int)time/60, (int)time%60, self.totalMediaSeconds];
     //当视频结束时，停止定时器并将标志位置为 NO，以便点击play按钮时，可以直接播放视频，但是要注意在slide的事件下处理定时器
//    self.playerItem.duration.value/self.playerItem.duration.timescale
    if (self.toolBar.avSlider.value == self.toolBar.avSlider.maximumValue) {
        [self pausePlay];
        [self.toolBar setIsPlay:NO];
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
- (void)clickedBackBtnAction
{
    if (self.isFullVC) {
        [self pausePlay];
    }
    self.clickedFullScreenBlock(NO);
}
- (void)clickedLockAndUnlockBtnAction
{
    self.lockAndUnlockBtn.selected = !_lockAndUnlockBtn.selected;
    if (_lockAndUnlockBtn.selected == YES) {
        self.fullScreenTopView.hidden = YES;
        self.videoBtn.hidden = YES;
        self.toolBar.hidden = YES;
    }else{
        self.fullScreenTopView.hidden = NO;
        if (!_isLocateVideo) {
            self.videoBtn.hidden = NO;
        }
        self.toolBar.hidden = NO;
    }
}

- (void)clickedVideoProfileAction:(UIButton *)button
{
    _videoProfileView.hidden = NO;
    _fullScreenTopView.hidden = YES;
    _videoBtn.hidden = YES;
    _toolBar.hidden = YES;
    _lockAndUnlockBtn.hidden = YES;
    
    for (UIButton *btn in _videoProfileArray) {
        if ([btn.titleLabel.text rangeOfString:button.titleLabel.text].location != NSNotFound) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
}
- (void)changeVideoProfileAction:(UIButton *)btn
{
//    [self pausePlay];
    NSString *videoName = btn.titleLabel.text;
    [_videoBtn setTitle:videoName forState:UIControlStateNormal];
    _videoProfileView.hidden = YES;
    
    videoName = [videoName stringByReplacingOccurrencesOfString:@"P" withString:@""];
    videoName = [NSString stringWithFormat:@"s%@", videoName];
    self.mediaUrlStr = [NSString stringWithFormat:@"%@",  _videoProfileUrlsDic[videoName]];
    [self seekToTimePlay:_currentValue];

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
                if (self.isFullVC) {
                    [self startPlay];
                }
            }
                break;
            case AVPlayerStatusUnknown:
            {
//                NSLog(@"视频资源出现未知错误");
//                [MBProgressHUD showWarnMessage:@"视频资源出现未知错误"];
                _isReadToPlay = NO;
                self.failPlayView.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
    
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

- (void)enterForegroundNotification
{
    [self startPlay];
}

- (void)enterBackgroundNotification
{
    [self pausePlay];
}
- (void)hideAVPlayerToolBar
{
    if (_isFullScreen) {
        self.fullScreenTopView.hidden = YES;
        self.videoBtn.hidden = YES;
        self.lockAndUnlockBtn.hidden = YES;
        self.toolBar.hidden = YES;
    }
}

#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_isFullScreen) {
        if (self.lockAndUnlockBtn.selected) {
            self.fullScreenTopView.hidden = YES;
            self.videoBtn.hidden = YES;
            self.lockAndUnlockBtn.hidden = NO;
            self.toolBar.hidden = YES;
        }else{
            self.fullScreenTopView.hidden = NO;
            if (!_isLocateVideo) {
                self.videoBtn.hidden = NO;
            }
            
            self.lockAndUnlockBtn.hidden = NO;
            self.toolBar.hidden = NO;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AVPLAYERTOOLBARSHOW" object:nil];
    }
}
#pragma mark - getter

- (UIImageView *)mediaImageView
{
    if (!_mediaImageView) {
        _mediaImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mediaImageView.image = [self getCoverMediaImage];
    }
    return _mediaImageView;
}
- (UIView *)fullScreenTopView
{
    if (!_fullScreenTopView) {
        _fullScreenTopView = [[UIView alloc] init];
        _fullScreenTopView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    }
    return _fullScreenTopView;
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
- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"nav_back"]
                             selectedImage:[UIImage imageNamed:@"nav_back"]];
        [_backBtn addTarget:self action:@selector(clickedBackBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _backBtn;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                       text:@""
                                  textColor:UIColorFromRGB(0xFFFFFF)];
    }
    return _titleLabel;
}

- (UIButton *)downloadBtn
{
    if (!_downloadBtn) {
        _downloadBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"video_download_white"]
                                 selectedImage:[UIImage imageNamed:@"video_download"]];
    }
    return _downloadBtn;
}
- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"video_share_white"]
                              selectedImage:[UIImage imageNamed:@"video_share"]];
    }
    return _shareBtn;
}

- (UIButton *)lockAndUnlockBtn
{
    if (!_lockAndUnlockBtn) {
        _lockAndUnlockBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"unlock"]
                                      selectedImage:[UIImage imageNamed:@"lock"]];
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
//        快进快退
        [_toolBar setClickedSliderBlock:^(float value) {
            [weakSelf seekToTimePlay:value];
        }];
        //播放/暂停
        [_toolBar setClickedPlayBtnBlock:^(BOOL isPlay) {
            if (isPlay) {
                [weakSelf startPlay];
            }else{
                [weakSelf pausePlay];
            }
        }];
        
//        全屏
        [_toolBar setClickedFullScreenBlock:^(BOOL isFullScreen) {
            weakSelf.clickedFullScreenBlock(isFullScreen);
        }];
        
    }
    return _toolBar;
}

- (UIView *)videoProfileView
{
    if (!_videoProfileView) {
        _videoProfileView = [[UIView alloc] init];
        _videoProfileView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        _videoProfileView.hidden = YES;
        
        UILabel *label = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                          text:@"视频质量"
                                     textColor:UIColorFromRGB(0xFFFFFF)];
        label.textAlignment = NSTextAlignmentCenter;
        [_videoProfileView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_videoProfileView);
            make.top.equalTo(self->_videoProfileView).offset(88*ScaleX);
        }];
        NSArray *array = @[@"1080P", @"720P", @"480P"];
        _videoProfileArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [MyTool buttonWithTitle:array[i]
                                         titleColor:UIColorFromRGB(0xFFFFFF) titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
            [btn setTitleColor:UIColorFromRGB(0x0E5BFF) forState:UIControlStateSelected];
            [_videoProfileView addSubview:btn];
            
            btn.frame = CGRectMake(0, 148*ScaleX + i*60*ScaleX, 160*ScaleX, 40*ScaleX);
            [btn addTarget:self action:@selector(changeVideoProfileAction:) forControlEvents:UIControlEventTouchDown];
            [_videoProfileArray addObject:btn];
        }
    }
    return _videoProfileView;
}

- (UIButton *)videoBtn
{
    if (!_videoBtn) {
        _videoBtn = [MyTool buttonWithTitle:@"720P"
                                 titleColor:UIColorFromRGB(0xFFFFFF)];
        _videoBtn.titleLabel.font = [MyTool mediumFontWithSize:14*ScaleX];
        _videoBtn.hidden = YES;
        [_videoBtn addTarget:self action:@selector(clickedVideoProfileAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _videoBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
