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
//  DKSmallToolBar.h
//  DookayProject
//
//  Created by dookay_73 on 2019/9/27.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXSlider.h"

NS_ASSUME_NONNULL_BEGIN
//竖屏时候的控制器
@interface DKSmallToolBar : UIView

//play按钮 YES播放 NO暂停
@property (nonatomic, assign) BOOL isPlaying;
//播放时长/总时长
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSString *totalTimeStr;

//进度条
@property (nonatomic, strong) RXSlider *avSlider;


//播放暂停
@property (nonatomic, copy) void (^clickedPlayBtnBlock)(BOOL isPlay);
//点击 快进快退
@property (nonatomic, copy) void (^clickedSliderBlock)(float value);//走seek方法
@property (nonatomic, copy) void (^clickedValueSliderBlock)(float value);//不走seek方法，只刷新界面

//进入全屏
@property (nonatomic, copy) void (^clickedFullScreenBlock)(void);

@end

NS_ASSUME_NONNULL_END
