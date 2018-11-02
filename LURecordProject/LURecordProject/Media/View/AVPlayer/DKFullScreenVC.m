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


@interface DKFullScreenVC ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeNum;

@end

@implementation DKFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(avplayerToolBarShow)
                                                 name:@"AVPLAYERTOOLBARSHOW"
                                               object:nil];
    
    [self buildTimer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}
- (void)avplayerToolBarShow
{
    [self buildTimer];
}

- (void)buildTimer
{
    _timeNum = 0;
    if (_timer == nil) {
        WS(weakSelf);
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 repeats:YES
                                                   block:^(NSTimer * _Nonnull timer) {
                                                       weakSelf.timeNum ++;
                                                       if (weakSelf.timeNum > 5) {
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"AVPLAYERTOOLBARHIDDEN" object:nil];
                                                           [weakSelf.timer invalidate];
                                                           weakSelf.timer = nil;
                                                       }
                                                   }];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc
{
    NSLog(@"----");
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
