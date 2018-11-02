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
//  MediaDownloadCell.h
//  DookayProject
//
//  Created by dookay_73 on 2018/10/10.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaDownloadModel.h"

@interface MediaDownloadCell : UITableViewCell

@property (nonatomic, strong) NSString *videoName;
@property (nonatomic, strong) MediaDownloadModel *model;

@property (nonatomic, assign) BOOL isDelete;

- (void)refreshDownloadTaskInfoWithValue:(CGFloat)value andBytesStr:(NSString *)bytesStr  andTotalBytes:(NSString *)totalBytes;

- (void)refreshDownloadUI:(BOOL)isSuccess;

@property (nonatomic, copy) void (^deleteCellBlock)(MediaDownloadCell *cell);

@end
