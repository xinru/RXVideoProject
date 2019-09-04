//
//  VCManager.m
//  MasterDuoBao
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import "VCManager.h"

@implementation VCManager

static VCManager *vcManager;
+ (VCManager *)shareVCManager
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        vcManager = [[self alloc] init];
    });

    return vcManager;
}

- (UIViewController*)getTopViewController
{
    return [self topViewControllerOfViewController:[self getRootViewController]];
}

- (UIViewController*)getRootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (UIViewController*)topViewControllerOfViewController:(UIViewController*)rootVC
{
    if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        return [self topViewControllerOfViewController:[(UINavigationController*)rootVC visibleViewController]];
    }
    else if (rootVC.presentedViewController)
    {
        return [self topViewControllerOfViewController:rootVC.presentedViewController];
    }
    else if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        return [self topViewControllerOfViewController:[(UITabBarController*)rootVC selectedViewController]];
    }
    else
    {
        return rootVC;
    }
}

@end
