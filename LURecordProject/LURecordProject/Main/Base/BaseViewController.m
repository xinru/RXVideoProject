//
//  BaseViewController.m
//  DookayProject
//
//  Created by momo on 2017/10/23.
//  Copyright © 2017年 DookayProject. All rights reserved.
//

#import "BaseViewController.h"
#import <objc/runtime.h>
// view
#import "AppDelegate.h"
#import <IQKeyboardManager.h>

static char *btnClickAction;

@interface BaseViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@property (nonatomic, assign) BOOL statusBarHidden;



@end

@implementation BaseViewController
#pragma mark - ♻️life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = UIColorFromRGB(0xFFFFFF);
    // 初始化导航栏
    [self p_setNavBar];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    
//    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:UIColorFromRGB(0x1D1C1F)]];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

- (void)dealloc{
    DKLog(@"dealloc %@",self.class);
}

#pragma mark - 🔄overwrite
//是否隐藏状态栏
//- (BOOL)prefersStatusBarHidden {
//    return self.statusBarHidden;
//}
//
////状态栏的样式
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    if (self.statusBarStyle) {
//        return self.statusBarStyle;
//    } else {
//        return UIStatusBarStyleDefault;
//    }
//}

#pragma mark - public method
-(void)setNavigationBarColor:(UIColor *)color{
    self.navigationController.navigationBar.barTintColor = color;
}

-(void)setNavigationBarImage:(UIImage *)image{
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 隐藏导航栏上的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}

-(void)setNavigationBarTitleAttributes:(NSDictionary *)attributes{
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

-(void)setLeftButtonWithTitle:(NSString *)title
                        Image:(NSString *)image
                SelectedImage:(NSString *)selectedImage
                       Action:(void (^)(void))btnClickBlock{
    self.navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.navLeftBtn setBackgroundColor:[UIColor clearColor]];
    
    objc_setAssociatedObject(self.navLeftBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navLeftBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navLeftBtn setTitleColor:UIColorFromRGB(0xAAAAAA) forState:UIControlStateNormal];
    self.navLeftBtn.titleLabel.font = [MyTool regularFontWithSize:14*ScaleX];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];

    if ([image isEqualToString:@"nav_back"]) {
        self.tempbtn = [[UIButton alloc]init];
        _tempbtn.frame = CGRectMake(15*ScaleX, 25*ScaleX, 44*ScaleX, 44*ScaleX);
        _tempbtn.backgroundColor = [UIColor clearColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_tempbtn];
        [_tempbtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_tempbtn removeFromSuperview];
        _tempbtn = nil;

    }

}

-(void)setRightButtonWithTitle:(NSString *)title
                         Image:(NSString *)image
                 SelectedImage:(NSString *)selectedImage
                        Action:(void (^)(void))btnClickBlock{
    self.navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    objc_setAssociatedObject(self.navRightBtn, &btnClickAction, btnClickBlock, OBJC_ASSOCIATION_COPY);
    [self setCustomButton:self.navRightBtn Title:title Image:image SelectedImage:selectedImage];
    [self.navRightBtn setTitleColor:UIColorFromRGB(0xAAAAAA) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
}

#pragma mark - private method
-(void)p_setNavBar{//0x1D1C1F
//    [self setNavigationBarColor:[UIColor colorWithRed:27.0/255.0 green:26.0/255.0 blue:30.0/255.0 alpha:1.0]];
    [self setNavigationBarTitleAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                            NSFontAttributeName:[MyTool mediumFontWithSize:18*ScaleX]}];
    //统一设置导航栏
    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;//不透明设置解决界面下移问题
//    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x1D1C21);
    //[UIColor colorWithRed:29.0/255.0 green:28.0/255.0 blue:40.0/255.0 alpha:1.0]
    //统一设置返回按钮
    //    if (self.navigationController.childViewControllers.count > 1) {
    __weak typeof(self) weakSelf = self;

    [self setLeftButtonWithTitle:nil Image:@"nav_back" SelectedImage:@"" Action:^{
        [weakSelf clickAction_leftItemClick];
    }];

    //    }
    
    /////////////
    //再定义一个imageview来等同于这个黑线
//    UIImageView *navBarHairlineImageView;
//    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
//    navBarHairlineImageView.hidden = YES;
    
//    self.separateLine.frame = CGRectMake(0,
//                                         44,
//                                         mainWidth,
//                                         0.5);
//    [self.navigationController.navigationBar addSubview:self.separateLine];
}
-(void)goBack
{
     [self clickAction_leftItemClick];
    [_tempbtn removeFromSuperview];
}
// 通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

-(void)setCustomButton:(UIButton *)button
                 Title:(NSString *)title
                 Image:(NSString *)image
         SelectedImage:(NSString *)selectedImage{
    if (image) {
        [button setImage:[[UIImage imageNamed:image]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:[[UIImage imageNamed:selectedImage]
                          imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                forState:UIControlStateHighlighted];
    }
    
    if (title) {
        button.titleLabel.font = [MyTool mediumFontWithSize:14];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button setTitleColor:UIColorFromRGB(0xAAAAAA) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xAAAAAA) forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    [button addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 🎬event response
- (void)clickAction_leftItemClick{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)actionBtnClick:(UIButton *)btn {
    void (^btnClickBlock) (void) = objc_getAssociatedObject(btn, &btnClickAction);
    btnClickBlock();
}

#pragma mark - touchesBegan -
//统一处理键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window endEditing:YES];
}

#pragma mark - 统一处理状态栏 -
- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle = statusBarStyle;
    self.statusBarHidden = statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - ☸getter and setter
- (UIView *)separateLine{
    if (!_separateLine) {
        _separateLine = [[UILabel alloc] init];
        _separateLine.backgroundColor = UIColorFromRGB(0x333236);
    }
    
    return _separateLine;
}

- (CGFloat)bottomOffset{
    if (IS_IPHONE_X) {
        return -1 * X_foot;
    }
    return 0;
}


-(NSMutableArray *)textArr{
    if (_textArr == nil) {
        _textArr = [[NSMutableArray alloc] init];
    }
    return _textArr;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
    
@end

