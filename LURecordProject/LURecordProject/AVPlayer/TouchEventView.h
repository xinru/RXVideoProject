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
//  TouchEventView.h
//  DookayProject
//
//  Created by dookay_73 on 2019/10/21.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TouchEventViewDelegate <NSObject>

- (void)touchEventViewBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchEventViewMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

- (void)touchEventViewEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end

@interface TouchEventView : UIView


@property (nonatomic, weak) id<TouchEventViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
