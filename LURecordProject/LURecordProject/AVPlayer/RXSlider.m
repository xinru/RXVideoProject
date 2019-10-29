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
//  RXSlider.m
//  DookayProject
//
//  Created by dookay_73 on 2019/10/22.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "RXSlider.h"

@interface RXSlider()

//亮度、音量
@property (nonatomic, assign) BOOL isStart;//滑动一次确定方向
@property (assign, nonatomic) CGPoint startPoint;
@property (nonatomic, assign) CGFloat seekValue;

@end
@implementation RXSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            CGPoint touchPoint = [sender locationInView:self];
              CGFloat value = (self.maximumValue - self.minimumValue) * (touchPoint.x / self.frame.size.width );
              [self setValue:value animated:YES];
            
            if (_sliderChangedBlock) {
                _sliderChangedBlock(value);
            }

        }];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

@end
