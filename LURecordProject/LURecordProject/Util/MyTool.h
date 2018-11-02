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
//  MyTool.h
//  LURecordProject
//
//  Created by dookay_73 on 2018/10/30.
//  Copyright © 2018 LU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTool : NSObject
#pragma mark - Font
// 设置字体
// 平方 细体
+ (UIFont *)lightFontWithSize:(CGFloat)size;
// 平方 粗体
+ (UIFont *)mediumFontWithSize:(CGFloat)size;
// 平方 常规
+ (UIFont *)regularFontWithSize:(CGFloat)size;

+ (UIFont *)semiboldFontWithSize:(CGFloat)size;

+ (UIFont *)dinMediumFontWithSize:(CGFloat)size;

+ (UIFont *)dinRegularFontWithSize:(CGFloat)size;

#pragma mark - UI
// create label
+ (UILabel *)labelWithText:(NSString *)text;
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font;
+ (UILabel *)labelWithFont:(UIFont *)font
                      text:(NSString *)text
                 textColor:(UIColor*)textColor;

// create button
+ (UIButton *)buttonWithTitle:(NSString *)title;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont;
+ (UIButton *)buttonWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
+ (UIButton *)buttonWithImage:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;
+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
