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
//  DKPlayerControlView.h
//  RXAVPlayerMedia
//
//  Created by dookay_73 on 2018/9/25.
//  Copyright © 2018年 RX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKSelectView.h"

//全屏时候的ToolBar
@interface DKAVPlayerToolBar : UIView

//进度条
@property (nonatomic, strong) UISlider *avSlider;
//播放时长/总时长
@property (nonatomic, strong) NSString *timeStr;
//play按钮
@property (nonatomic, assign) BOOL isPlaying;
//视频名称
@property (nonatomic, strong) NSString *mediaName;

//选集数组
@property (nonatomic, assign) NSInteger  selectedIndex;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) DKSelectView *selectView;

//播放暂停
@property (nonatomic, copy) void (^clickedPlayBtnBlock)(BOOL isPlay);
//快进快退
@property (nonatomic, copy) void (^clickedSliderBlock)(float value);
//快进快退中弹窗提示
@property (nonatomic, copy) void (^clickedSliderValueBlock)(float value);
//返回退出全屏
@property (nonatomic, copy) void (^clickedBackBlock)(void);
//切换清晰度
@property (nonatomic, copy) void (^changeVideoProfileBlock)(NSString *videoName);
//倍速播放
@property (nonatomic, copy) void (^changeVideoRateBlock)(float rate);
//下一级
@property (nonatomic, copy) void (^clickedNextVideoBlock)(void);
//更新URL
@property (nonatomic, copy) void (^refreshVideoUrlBlock)(NSInteger index);

- (void)toolBarAnimationWithHidden:(BOOL)isHidden;

@end

//竖屏时候的控制器
@interface DKSmallToolBar : UIView

//play按钮 YES播放 NO暂停
@property (nonatomic, assign) BOOL isPlaying;
//播放时长/总时长
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSString *totalTimeStr;

//进度条
@property (nonatomic, strong) UISlider *avSlider;


//播放暂停
@property (nonatomic, copy) void (^clickedPlayBtnBlock)(BOOL isPlay);
//快进快退
@property (nonatomic, copy) void (^clickedSliderBlock)(float value);//走seek方法
@property (nonatomic, copy) void (^clickedValueSliderBlock)(float value);//不走seek方法，只刷新界面

//进入全屏
@property (nonatomic, copy) void (^clickedFullScreenBlock)(void);

@end
