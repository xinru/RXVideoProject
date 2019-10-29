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

#import "VCManager.h"

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
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化导航栏
    [self p_setNavBar];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    
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
- (BOOL)prefersStatusBarHidden {
    return self.statusBarHidden;
}

//状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.statusBarStyle) {
        return self.statusBarStyle;
    } else {
        return UIStatusBarStyleDefault;
    }
}
#pragma mark - public method
-(void)setLeftButtonWithTitle:(NSString *)title
                        Image:(NSString *)image
                SelectedImage:(NSString *)selectedImage
                       Action:(void (^)(void))btnClickBlock
{
    [_bar.leftBtn setTitle:title forState:UIControlStateNormal];
    [_bar.leftBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_bar.leftBtn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];

    _bar.leftBtnBlock = btnClickBlock;
}

-(void)setRightButtonWithTitle:(NSString *)title
                         Image:(NSString *)image
                 SelectedImage:(NSString *)selectedImage
                        Action:(void (^)(void))btnClickBlock
{
    [_bar.rightBtn setTitle:title forState:UIControlStateNormal];
    [_bar.rightBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [_bar.rightBtn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];

    _bar.rightBtnBlock = btnClickBlock;
    
}
- (void)setBarType:(NavBarType)barType
{
    _bar.barType = barType;
}
- (void)hiddenBavBar
{
    _bar.hidden = YES;
    _bar.height = 0;
}
#pragma mark - private method
-(void)p_setNavBar
{
    self.navigationController.navigationBarHidden = YES;
//    初始化
    CGFloat height = 64;
    if (IS_IPHONE_X) {
        height = X_head+44;
    }
    _bar = [[RootNavBar alloc] initWithFrame:CGRectMake(0, 0, mainWidth, height)];
    [self.view addSubview:_bar];
//    title
    _bar.title = self.title;
//    左侧返回事件
    WS(weakSelf);
    _bar.leftBtnBlock = ^{
        [weakSelf clickAction_leftItemClick];
    };
    
    _navLeftBtn = _bar.leftBtn;
    _navRightBtn = _bar.rightBtn;
    
}


#pragma mark - 🎬event response
- (void)clickAction_leftItemClick{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - touchesBegan 
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

@end

