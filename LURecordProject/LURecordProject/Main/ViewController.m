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
//  ViewController.m
//  LURecordProject
//
//  Created by dookay_73 on 2018/10/30.
//  Copyright © 2018 LU. All rights reserved.
//

#import "ViewController.h"
#import "MediaDetailVC.h"
#import "Base/BaseNavViewController.h"
#import "MediaDownloadVC.h"
#import "DKAVPlayer.h"
#import "DKFullScreenVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [MyTool buttonWithTitle:@"观看视频"];
    [btn addTarget:self
            action:@selector(enterVideoVC)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
    }];
    
    UIButton *listBtn = [MyTool buttonWithTitle:@"本地视频"];
    [listBtn addTarget:self
            action:@selector(enterVideoListVC)
  forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:listBtn];
    
    [listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).offset(30);
    }];
    
    UIButton *fullBtn = [MyTool buttonWithTitle:@"全屏视频"];
    [fullBtn addTarget:self
                action:@selector(enterFullScreenVideoVC)
      forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:fullBtn];
    
    [fullBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(listBtn.mas_bottom).offset(30);
    }];
    
}

- (void)enterVideoVC
{
    MediaDetailVC *detailVC = [[MediaDetailVC alloc] init];
    BaseNavViewController *navVC = [[BaseNavViewController alloc] initWithRootViewController:detailVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)enterVideoListVC
{
    MediaDownloadVC *downloadVC = [[MediaDownloadVC alloc] init];
    BaseNavViewController *navVC = [[BaseNavViewController alloc] initWithRootViewController:downloadVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)enterFullScreenVideoVC
{
    DKAVPlayer *avPlayer = [[DKAVPlayer alloc] initWithFrame:CGRectMake(0, 0, mainHeight, mainWidth)
                                      andMediaURL:@"http://v.dansewudao.com/444fccb3590845a799459f6154d2833f/fe86a70dc4b8497f828eaa19058639ba-6e51c667edc099f5b9871e93d0370245-sd.mp4"];
    avPlayer.backgroundColor = UIColorFromRGB(0x1D1C1F);
    avPlayer.isFullScreen = YES;
    avPlayer.isFullVC = YES;
    DKFullScreenVC *fullPlayer = [[DKFullScreenVC alloc] init];
    [fullPlayer.view addSubview:avPlayer];
    WS(weakSelf);
    [avPlayer setClickedFullScreenBlock:^(BOOL isFullScreen) {
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    }];
    [self presentViewController:fullPlayer animated:NO completion:nil];
}

@end
