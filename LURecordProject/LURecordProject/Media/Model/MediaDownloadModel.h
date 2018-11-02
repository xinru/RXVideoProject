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
//  MediaDownloadModel.h
//  DookayProject
//
//  Created by dookay_73 on 2018/10/11.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaDownloadModel : NSObject

//NSDictionary *dic = @{@"url":model.url,
//@"videoName":model.title,
//@"isDownload":@(NO),
//@"videoBytes":@(0)
//};

@property (nonatomic, strong) NSString *url;//下载地址
@property (nonatomic, strong) NSString *videoName;//视频名称
@property (nonatomic, assign) BOOL isDownload;//是否下载完成
@property (nonatomic, assign) double videoBytes;//视频大小
@property (nonatomic, strong) NSString *filePath;//本地视频地址

@end
