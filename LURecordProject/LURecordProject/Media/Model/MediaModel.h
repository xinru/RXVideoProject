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
//  MediaModel.h
//  DookayProject
//
//  Created by dookay_73 on 2018/9/28.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaModel : NSObject

@property (nonatomic, strong) NSString *title;//视频标题
//@property (nonatomic, strong) NSString *url;//视频路径
@property (nonatomic, strong) NSString *downloadUrl;//下载视频路径s720
//@property (nonatomic, strong) NSString *area;//地区
//@property (nonatomic, strong) NSString *avatar;//用户头像
//@property (nonatomic, strong) NSString *nickName;//用户昵称
//@property (nonatomic, strong) NSString *country;//国家
//@property (nonatomic, strong) NSString *date;//发布时间
//@property (nonatomic, strong) NSString *duration;//视频时长
//@property (nonatomic, strong) NSString *thumb;//视频封面    
//@property (nonatomic, strong) NSArray *images;//图片路径集合
//@property (nonatomic, strong) NSString *introduction;//简介
//@property (nonatomic, assign) NSInteger userId;//用户id
//@property (nonatomic, assign) BOOL isCollection;//是否收藏
//@property (nonatomic, assign) BOOL isFollow;//是否关注视频作者
//@property (nonatomic, assign) BOOL isLike;//是否点赞
//@property (nonatomic, strong) NSString *qiniuData;//    七牛转码数据
//@property (nonatomic, assign) NSInteger allowDownload;//是否允许下载 1是2否
//@property (nonatomic, assign) NSInteger videoId;//视频id

@property (nonatomic, assign) int viewCount;//浏览数

@property (nonatomic, assign) CGFloat cellHeight;

@end
