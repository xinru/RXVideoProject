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
//  RootNavBar.h
//  DookayProject
//
//  Created by dookay_73 on 2019/8/8.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//这里可以设置bar的类型，默认是白底黑字。以后可以依据实际项目中的设计，增加不同的类型
typedef enum : NSUInteger {
    NavBarTypeDefault,//白底黑字
    NavBarTypeBlack,//黑底白字
    NavBarTypeImage,//背景是张图片
    NavBarTypeBottomImage,//底部是张图片
} NavBarType;

@interface RootNavBar : UIImageView

@property (nonatomic, assign) NavBarType barType;

//标题
@property (nonatomic, strong) NSString *title;

//隐藏左侧返回按钮，主要是针对一级界面
@property (nonatomic, assign) BOOL isHiddenLeftBtn;

//左侧返回按钮
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, copy) void (^leftBtnBlock)(void);
@property (nonatomic, copy) void (^rightBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
