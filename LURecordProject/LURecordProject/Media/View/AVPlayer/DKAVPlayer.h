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
//  DKAVPlayer.h
//  RXAVPlayerMedia
//
//  Created by dookay_73 on 2018/9/25.
//  Copyright © 2018年 RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DKAVPlayer : UIView

- (instancetype)initWithFrame:(CGRect)frame
                  andMediaURL:(NSString *)urlStr;

//视频地址
@property (nonatomic, strong) NSString *mediaUrlStr;
//视频名称
@property (nonatomic, strong) NSString *mediaName;

//不同清晰度的视频集
@property (nonatomic, strong) NSDictionary *videoProfileUrlsDic;
@property (nonatomic, strong) NSTimer *timer;

//全屏处理
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, copy) void (^clickedFullScreenBlock)(BOOL isFullScreen);

//YES代表是直接进入全屏界面，NO代表是toolBar在做全屏播放处理
@property (nonatomic, assign) BOOL isFullVC;

//开始播放
- (void)startPlay;

//暂停播放
- (void)pausePlay;

//移除播放器
- (void)removeAVPlayer;

//切换清晰度-切换不同的视频地址
//@property (nonatomic, copy) void (^changeVideoProfileBlock)(NSString *videoName);

@end
