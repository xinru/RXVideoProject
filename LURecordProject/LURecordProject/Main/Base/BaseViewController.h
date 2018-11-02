//
//  BaseViewController.h
//  DookayProject
//
//  Created by momo on 2017/10/23.
//  Copyright © 2017年 DookayProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 默认为空，需要gif动画的子类添加
 */
@property(nonatomic,strong) NSMutableArray *refreshImages;
/**
 默认为空，需要gif动画的子类添加
 */
@property(nonatomic,strong) NSMutableArray *normalImages;
@property (nonatomic, strong) UIView *separateLine;
@property (nonatomic,strong) UIButton *navLeftBtn;
@property (nonatomic,strong) UIButton *navRightBtn;

@property (nonatomic, readonly, assign) CGFloat bottomOffset; // 距离底部的偏移，iphoex为-39,其他为0
@property (nonatomic,strong) NSMutableArray *textArr;
@property (nonatomic, strong) UIButton *tempbtn;

//设置导航栏颜色
-(void)setNavigationBarColor:(UIColor *)color;
//设置导航栏图片
-(void)setNavigationBarImage:(UIImage *)image;
//设置导航栏富文本
-(void)setNavigationBarTitleAttributes:(NSDictionary *)attributes;
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

- (void)clickAction_leftItemClick;


- (void)actionBtnClick:(UIButton *)btn;
@end
