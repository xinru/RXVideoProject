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
//  DKDownloadTask.h
//  DookayProject
//
//  Created by dookay_73 on 2018/10/11.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MediaModel.h"

@interface DKDownloadTask : NSObject

+ (instancetype)taskShared;
//开始下载
- (void)startDownloadVideoWithModel:(NSString *)urlStr;
//删除下载
- (void)deleteDownloadVideoWithIndex:(NSInteger)index;
//暂停下载，当为-1时，是暂停所有下载
- (void)pauseDownloadVideoWithIndex:(NSInteger)index;
//继续下载
- (void)continueDownloadVideo;

//下载中刷新progressView
@property (nonatomic, copy) void (^refreshSliderValueBlock)(CGFloat value, CGFloat currentBytes, CGFloat totalBytes, NSString *videoUrl);

//下载成功刷新UI
@property (nonatomic, copy) void (^refreshDownloadSuccessCellBlock)(NSString *videoUrl);

@end
