//
//  VCManager.h
//  MasterDuoBao
//
//  Created by  on 16/3/24.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCManager : NSObject
/**
 *  创建单例
 *
 *  @return VCManager
 */
+ (VCManager *)shareVCManager;

/**
 *  获取当前显示视图控制器
 *
 *  @return 当前顶层显示视图控制器
 */
- (UIViewController*)getTopViewController;

@end
