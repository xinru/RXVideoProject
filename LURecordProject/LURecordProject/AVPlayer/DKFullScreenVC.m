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
//  DKFullPlayerVC.m
//  DookayProject
//
//  Created by dookay_73 on 2018/10/9.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "DKFullScreenVC.h"
#import "AppDelegate.h"

@interface DKFullScreenVC ()

@property (nonatomic, strong) DKAVPlayer *avPlayer;

@end

@implementation DKFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    [MyTool switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    UIDeviceOrientation ori = [[UIDevice currentDevice] orientation];
    NSLog(@"device11111111111111__________ori:%ld",ori);
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeBarHidden)
                                                 name:@"CHANGESTATUSBARHIDDEN"
                                               object:nil];
 
}

- (void)changeBarHidden
{
    [self setNeedsStatusBarAppearanceUpdate];
}
- (void)viewWillAppear:(BOOL)animated
{
      [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    //切换到竖屏
    [MyTool switchNewOrientation:UIInterfaceOrientationPortrait];
}

//强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 横屏代码
- (BOOL)shouldAutorotate{
    return YES;
} //NS_AVAILABLE_IOS(6_0);当前viewcontroller是否支持转屏

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
} //当前viewcontroller支持哪些转屏方向

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

#pragma mark - system
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)dealloc
{
    [_avPlayer removeAVPlayer];
    NSLog(@"----");
}

- (BOOL)prefersStatusBarHidden
{
    return _statusBarHidden;
}


@end
