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
//  DKFullPlayerVC.h
//  DookayProject
//
//  Created by dookay_73 on 2018/10/9.
//  Copyright © 2018年 Dookay. All rights reserved.
//

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionLeftOrRight,
    DirectionUpOrDown,
    DirectionNone
};

#import <UIKit/UIKit.h>
#import "DKAVPlayer.h"

@interface DKFullScreenVC : UIViewController

@property (nonatomic, assign) BOOL statusBarHidden;

@property (nonatomic, strong) DKVideoModel *model;

@property (nonatomic, copy) void (^quitFullScreenBlock)(CGFloat value);

@end
