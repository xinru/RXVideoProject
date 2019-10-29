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
//  TouchEventView.m
//  DookayProject
//
//  Created by dookay_73 on 2019/10/21.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "TouchEventView.h"


@implementation TouchEventView

#pragma mark - touch event

#pragma mark - 手势改变音量、亮度、快进快退

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(touchEventViewBegan:withEvent:)]) {
        [self.delegate touchEventViewBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(touchEventViewMoved:withEvent:)]) {
        [self.delegate touchEventViewMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if ([self.delegate respondsToSelector:@selector(touchEventViewEnded:withEvent:)]) {
        [self.delegate touchEventViewEnded:touches withEvent:event];
    }
    
}

@end
