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
#import "DKAVPlayerToolBar.h"
#import "DKVideoModel.h"

@interface DKAVPlayer : UIView

- (instancetype)initWithFrame:(CGRect)frame isFullScreen:(BOOL)isFullScreen;

//改为模型传输
@property (nonatomic, strong) DKVideoModel *model;


//3Dbody项目中实现的功能，主要是为了实现更改集数，类似电视剧播放，可以选集
////当前播放的第几章
//@property (nonatomic, assign) NSInteger sectionIndex;
////总课程列表
//@property (nonatomic, strong) NSArray *sectionList;
////是否已经购买
//@property (nonatomic, assign) BOOL isBuy;


//当前播放的value，断点播放
@property (nonatomic, assign) CGFloat currentValue;

//是否在播放
@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) AVPlayer *player;

//退出全屏
@property (nonatomic, copy) void (^dismissFullScreenBlcok)(void);

@property (nonatomic, copy) void (^refreshVideoUrlBlcok)(NSInteger sectionId);

//快进快退
- (void)seekToTimePlay:(float)value isPlaying:(BOOL)isPlaying;

- (void)removeAVPlayer;

@end
