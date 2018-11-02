//
//  BaseNavViewController.m
//  DookayProject
//
//  Created by momo on 2017/10/23.
//  Copyright © 2017年 DookayProject. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()
<UIGestureRecognizerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate =  self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark -- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1 ) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 🔄overwrite
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

@end
