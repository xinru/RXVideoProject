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
//  DKVideoModel.h
//  DookayProject
//
//  Created by dookay_73 on 2019/8/28.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKVideoModel : NSObject

//视频地址
@property (nonatomic, strong) NSString *mediaUrlStr;
//视频名称
@property (nonatomic, strong) NSString *mediaName;
//视频图片
@property (nonatomic, strong) NSString *mediaImage;

//不同清晰度的视频集
//@property (nonatomic, strong) TransData *videoProfileUrlsDic;
//总时长 s
@property (nonatomic, assign) NSInteger totalSeconds;
//已经播放的时间
@property (nonatomic, assign) NSInteger currentSeconds;

@end

NS_ASSUME_NONNULL_END
