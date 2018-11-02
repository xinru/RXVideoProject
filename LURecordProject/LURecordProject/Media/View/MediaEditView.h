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
//  MediaEditView.h
//  LURecordProject
//
//  Created by dookay_73 on 2018/11/1.
//  Copyright © 2018 LU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MediaEditView : UIView

- (void)showEditView;

@property (nonatomic, copy) void (^getVideoNameBlock)(NSString *name);

@end

