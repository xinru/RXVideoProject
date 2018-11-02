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
    
}

- (void)enterVideoVC
{
    MediaDetailVC *detailVC = [[MediaDetailVC alloc] init];
    BaseNavViewController *navVC = [[BaseNavViewController alloc] initWithRootViewController:detailVC];
    [self presentViewController:navVC animated:YES completion:nil];
}

@end
