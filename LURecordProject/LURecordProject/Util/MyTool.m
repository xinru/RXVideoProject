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
//  MyTool.m
//  LURecordProject
//
//  Created by dookay_73 on 2018/10/30.
//  Copyright © 2018 LU. All rights reserved.
//

#import "MyTool.h"

@implementation MyTool
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}
#pragma mark - Font
+ (UIFont *)lightFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (!font) {
        font = [UIFont italicSystemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)regularFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont*)semiboldFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)dinMediumFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINPro-Medium" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}


+ (UIFont *)dinRegularFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"DINPro-Regular" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)mediumFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:size];
    if (!font) {
        font = [UIFont boldSystemFontOfSize:size];
    }
    return font;
}

#pragma mark - UI
// create Label
+ (UILabel *)labelWithText:(NSString *)text{
    return [self labelWithText:text
                          font:[MyTool regularFontWithSize:14 * ScaleX]];
}

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font{
    return [self labelWithFont:font
                          text:text
                     textColor:UIColorFromRGB(0x333333)];
}

+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor*)textColor{
    UILabel *label = [[UILabel alloc] init];
    if (font) {
        label.font = font;
    }
    if (text) {
        label.text = text;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    
    return label;
}
//设置不同字体颜色
+(void)setTextColor:(UILabel *)label andFontNumber:(UIFont *)font andRangeStr:(NSString *)rangeStr andColor:(UIColor *)vaColor
{
    if (label.text.length > 0 && rangeStr.length > 0) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
        NSRange range = [label.text rangeOfString:rangeStr];
        //设置字号
        [str addAttribute:NSFontAttributeName value:font range:range];
        //设置文字颜色
        [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
        label.attributedText = str;
    }
    
}
+ (UIButton *)buttonWithTitle:(NSString *)title{
    return [self buttonWithTitle:title titleColor:UIColorFromRGB(0x333333)];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    return [self buttonWithTitle:title titleColor:titleColor titleFont:[MyTool regularFontWithSize:14 * ScaleX]];
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    return  [self buttonWithTitle:title titleColor:titleColor titleFont:titleFont image:nil selectedImage:nil];
}

+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    return [self buttonWithTitle:title titleColor:UIColorFromRGB(0x333333) titleFont:[MyTool regularFontWithSize:14 * ScaleX] image:image selectedImage:selectedImage];
}

+ (UIButton *)buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage{
    return [self buttonWithTitle:nil image:image selectedImage:selectedImage];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}


@end
