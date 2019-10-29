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
//  DKSelectView.h
//  DookayProject
//
//  Created by dookay_73 on 2019/4/3.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKVideoModel.h"

#define kVideoMainColor UIColorFromRGB(0x1890FF)

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SelectViewTypeAnthony,
    SelectViewTypeDefinition,
    SelectViewTypeRate,
} SelectViewType;

@interface DKSelectView : UIView

@property (nonatomic, assign) SelectViewType selectViewType;

@property (nonatomic, assign) NSInteger selectedIndex;
//当前的清晰度
@property (nonatomic, strong) NSString *currentProfile;

//选集数组
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void (^refreshVideoUrlBlock)(NSInteger index);
@property (nonatomic, copy) void (^refreshVideoProfileBlock)(NSString *videoProfile);
@property (nonatomic, copy) void (^refreshVideoRateBlock)(NSString *rateStr, NSInteger index);

@end

NS_ASSUME_NONNULL_END

//选集的cell
@interface AnthonyCell : UITableViewCell

@property (nonatomic, assign) BOOL isSelected;

- (void)reloadData:(DKVideoModel *)model  index:(NSInteger)index;

@end

//清晰度View
@interface VideoProfileView : UIView

@property (nonatomic, strong) NSString *currentProfile;
@property (nonatomic, copy) void (^refreshVideoProfileBlock)(NSString *videoProfile);

@end

//声音和亮度View
typedef enum : NSUInteger {
    IconTypeVoice,
    IconTypeSun,
    IconTypeValue,
} IconType;
@interface VideoSliderView : UIView

- (instancetype _Nullable )initWithType:(IconType)type;
@property (nonatomic, assign) IconType type;

@property (nonatomic, strong) NSString * _Nullable totalTime;
@property (nonatomic, assign) float value;

@end
