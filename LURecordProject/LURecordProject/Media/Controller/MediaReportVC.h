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
//  MediaReportVC.h
//  DookayProject
//
//  Created by dookay_73 on 2018/9/29.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ReportTypeMedia = 1,
    ReportTypeComment = 2,
} ReportType;

@interface MediaReportVC : BaseViewController

@property (nonatomic, assign) ReportType type;
@property (nonatomic, assign) NSInteger domainId;

@end
