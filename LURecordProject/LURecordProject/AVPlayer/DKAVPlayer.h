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

- (instancetype)initWithFrame:(CGRect)frame
                    superView:(UIView *)superView;

//播放状态isPlay YES 加载成功后直接播放  NO手动播放
- (void)prepareForPlayWithModel:(DKVideoModel *)model isPlay:(BOOL)isPlay;

//以下两个参数主要是为了实现选集功能，更改集数，可不传
//当前播放的第几章
@property (nonatomic, assign) NSInteger sectionIndex;
//总列表
@property (nonatomic, strong) NSArray *sectionList;


//更换视频地址，用于外部刷新
@property (nonatomic, copy) void (^refreshVideoUrlBlcok)(NSInteger sectionIndex);

//退出全屏 当前播放的value，断点保存
@property (nonatomic, copy) void (^dismissFullScreenBlcok)(NSInteger currentValue);

//是否在播放
@property (nonatomic, assign) BOOL isPlaying;

//移除播放器
- (void)removeAVPlayer;

@end
