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

@interface DKAVPlayerToolBar : UIView

//进度条
@property (nonatomic, strong) UISlider *avSlider;
//播放时长/总时长
@property (nonatomic, strong) NSString *timeStr;
//play按钮
@property (nonatomic, assign) BOOL isPlay;
//切换清晰度按钮
//@property (nonatomic, strong) UIButton *videoBtn;

//是否是全局
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, copy) void (^clickedPlayBtnBlock)(BOOL isPlay);
@property (nonatomic, copy) void (^clickedSliderBlock)(float value);
@property (nonatomic, copy) void (^clickedFullScreenBlock)(BOOL isFullScreen);
//@property (nonatomic, copy) void (^changeVideoProfileBlock)(NSString *videoName);

@end
