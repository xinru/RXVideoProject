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
//  GlobalConfig.h
//  LURecordProject
//
//  Created by dookay_73 on 2018/10/30.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WS(weakSelf) __weak typeof(self) weakSelf = self;

#define mainWidth     [[UIScreen mainScreen] bounds].size.width
#define mainHeight       [[UIScreen mainScreen] bounds].size.height
#define ScaleX   mainWidth/375

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_X (IS_IPHONE && mainHeight == 812.0)
#define X_foot   39
#define X_head   44

/**定义颜色的宏*/
//颜色 16进制 例如: UIColorFromRGB(0x2b2b2b)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//带透明度的颜色
#define UIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

// console log
#ifdef DEBUG
#if TARGET_IPHONE_SIMULATOR
#define DKLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define DKLog(...) printf("%s 第%d行 \n %s\n\n",__func__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#endif
#else
#define DKLog(...)
#endif


#define kThemeBlueColor UIColorFromRGB(0x0E5BFF)

//下载列表
extern NSString *kDownloadVideoList;
