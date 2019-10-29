//
//  BaseViewController.h
//  DookayProject
//
//  Created by momo on 2017/10/23.
//  Copyright © 2017年 DookayProject. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavBar.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) RootNavBar *bar;

/**
 顶部 bar 类型
 */
@property (nonatomic, assign) NavBarType barType;

/**
 顶部 bar 的左右按钮 默认左侧返回  右侧隐藏
 */
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *navRightBtn;


@property (nonatomic, readonly, assign) CGFloat bottomOffset; // 距离底部的偏移，iphoex为-39,其他为0

@property (nonatomic,strong) NSMutableArray *textArr;

//设置导航栏左按钮
-(void)setLeftButtonWithTitle:(NSString *)title
                        Image:(NSString *)image
                SelectedImage:(NSString *)selectedImage
                       Action:(void(^)(void))btnClickBlock;
//设置导航栏右按钮
-(void)setRightButtonWithTitle:(NSString *)title
                         Image:(NSString *)image
                 SelectedImage:(NSString *)selectedImage
                        Action:(void(^)(void))btnClickBlock;

//左侧按钮的点击事件，可重写
- (void)clickAction_leftItemClick;

- (void)hiddenBavBar;

/**
 * 功能：设置修改StatusBar
 * 参数：（1）StatusBar样式：statusBarStyle
 *      （2）是否隐藏StatusBar：statusBarHidden
 *      （3）是否动画过渡：animated
 */
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated;

/**
 设置状态栏的背景颜色
 
 @param color 状态栏的背景颜色
 */
- (void)setStatusBarBackgroundColor:(UIColor *)color;


- (BOOL)checkAllText;

@end
