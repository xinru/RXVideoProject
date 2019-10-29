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
//  VideoListCell.h
//  DookayProject
//
//  Created by dookay_73 on 2019/9/20.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kVideoListCellID   @"kVideoListCellID"

@interface VideoListCell : UITableViewCell

- (void)reloadData:(DKVideoModel *)courseModel  index:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
