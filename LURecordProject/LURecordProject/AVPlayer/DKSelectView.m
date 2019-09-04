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
//  DKSelectView.m
//  DookayProject
//
//  Created by dookay_73 on 2019/4/3.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "DKSelectView.h"

#define kAnthonyCellID  @"AnthonyCell"

@interface DKSelectView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) VideoProfileView *profileView;

@end

@implementation DKSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.9);
        
//        选集UI
        _tableView = [[UITableView alloc] initWithFrame:self.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.rowHeight = 45*ScaleX;
        
        [_tableView registerClass:[AnthonyCell class]
           forCellReuseIdentifier:kAnthonyCellID];
        
        [self addSubview:self.tableView];
        
//        清晰度UI
        _profileView = [[VideoProfileView alloc] init];
        [self addSubview:_profileView];
    
        WS(weakSelf);
        [_profileView setRefreshVideoProfileBlock:^(NSString *videoProfile) {
            if (weakSelf.refreshVideoProfileBlock) {
                weakSelf.refreshVideoProfileBlock(videoProfile);
            }
            [weakSelf removeFromSuperview];
        }];
        
        _profileView.hidden = YES;

    }
    return self;
}
- (void)layoutSubviews
{
    _tableView.frame = self.bounds;
    _profileView.frame = self.bounds;
}

#pragma mark - setter
- (void)setSelectViewType:(SelectViewType)selectViewType
{
    _selectViewType = selectViewType;
    if (selectViewType == SelectViewTypeDefinition) {
        _tableView.hidden = YES;
        _profileView.hidden = NO;
    }else{
        _tableView.hidden = NO;
        _profileView.hidden = YES;
        
    }
}
- (void)setCurrentProfile:(NSString *)currentProfile
{
    _profileView.currentProfile = currentProfile;
}
#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectViewType == SelectViewTypeAnthony) {
        AnthonyCell *cell = [tableView dequeueReusableCellWithIdentifier:kAnthonyCellID];
        
        if (_selectedIndex == indexPath.row) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
        
//        SectionBrif *model = [_dataArray objectAtIndex:indexPath.row];
//        cell.model = model;
        
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"rate"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *rateLabel = [MyTool labelWithFont:[MyTool semiboldFontWithSize:8*ScaleX]
                                              text:_dataArray[indexPath.row]
                                         textColor:[UIColor whiteColor]];
        [cell addSubview:rateLabel];
        [rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
        }];
        if (_selectedIndex == indexPath.row) {
            rateLabel.textColor = kYellowColor;
        }else{
            rateLabel.textColor = [UIColor whiteColor];
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectViewType == SelectViewTypeAnthony) {
        return 45*ScaleX;
    }else{
        return 35*ScaleX;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_selectViewType == SelectViewTypeAnthony) {
        return 0.01;
    }else{
        return 25*ScaleX;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (_selectViewType == SelectViewTypeAnthony) {
        return 0.01;
//    }else{
//        return 35*ScaleX;
//    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    _selectedIndex = indexPath.row;
    [self.tableView reloadData];
    if (_selectViewType == SelectViewTypeAnthony) {
        if (self.refreshVideoUrlBlock) {
            self.refreshVideoUrlBlock(indexPath.row);
        }
    }else if (_selectViewType == SelectViewTypeRate){
        if (self.refreshVideoRateBlock) {
            self.refreshVideoRateBlock(_dataArray[indexPath.row], indexPath.row);
        }
    }
    

    [self removeFromSuperview];
}

@end


@interface AnthonyCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end
@implementation AnthonyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _icon = [[UIImageView alloc] init];
//        _icon.backgroundColor = kYellowColor;
        [self addSubview:_icon];
        
        _titleLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:7*ScaleX]
                                       text:@"1.1 肌骨疼痛之软组织评估思路及方法 "
                                  textColor:[UIColor whiteColor]];
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
        
        _timeLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:6*ScaleX]
                                      text:@"时长：00:55:33"
                                 textColor:[UIColor whiteColor]];
        [self addSubview:_timeLabel];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(8*ScaleX);
            make.width.mas_equalTo(60*ScaleX);
            make.height.mas_equalTo(35*ScaleX);
        }];
        _icon.layer.cornerRadius = 4*ScaleX;
        _icon.layer.masksToBounds = YES;
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_icon.mas_right).offset(5*ScaleX);
            make.right.equalTo(self).offset(-8*ScaleX);
            make.top.equalTo(_icon);
        }];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_left);
            make.bottom.equalTo(_icon.mas_bottom);
        }];
    }
    
    return self;
}

- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
        _titleLabel.textColor = kYellowColor;
        _timeLabel.textColor = kYellowColor;
    }else{
        _titleLabel.textColor = [UIColor whiteColor];
        _timeLabel.textColor = [UIColor whiteColor];
    }
}
//- (void)setModel:(SectionBrif *)model
//{
//    NSDictionary *dic = [model.thumb jsonStringToDictonary];
//    NSString *imgStr = dic[@"file"];
//    if (![imgStr hasPrefix:@"http"]) {
//        imgStr = [NSString stringWithFormat:@"%@%@", BASE_PIC_URL, imgStr];
//    }
//    [_icon yy_setImageWithURL:[NSURL URLWithString:imgStr] placeholder:[UIImage imageNamed:@"章节封面"]];
////    _icon.yy_imageURL = [NSURL URLWithString:imgStr];
//    _titleLabel.text = model.title;
//    NSInteger duration = model.duration;
//    
//    
//    long seconds = duration % 60;
//    long minutes = (duration / 60) % 60;
//    long hours = duration / 3600;
//    
//    _timeLabel.text =  [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours, minutes, seconds];
//    
////    _timeLabel.text = [NSString stringWithFormat:@"时长：%.2ld:%.2ld:%.2ld", duration/60/60, duration/60, duration % 60];
//}

@end



@interface VideoProfileView()

@property (nonatomic, strong) NSMutableArray *videoProfileArray;

@end
@implementation VideoProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {

        _videoProfileArray = [NSMutableArray array];
        
        NSArray *array = @[@"标清", @"高清", @"超清"];
        for (int i = 0; i < array.count; i++) {
            UIButton *btn = [MyTool buttonWithTitle:array[i]
                                         titleColor:UIColorFromRGB(0xFFFFFF)
                                          titleFont:[MyTool mediumFontWithSize:7*ScaleX]];
            [btn setTitleColor:kYellowColor forState:UIControlStateSelected];
            [self addSubview:btn];
            
            [btn addTarget:self action:@selector(changeVideoProfileAction:) forControlEvents:UIControlEventTouchDown];
            [_videoProfileArray addObject:btn];
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    for (int i = 0; i < _videoProfileArray.count; i++) {
        UIButton *btn = _videoProfileArray[i];
        if (i == 0) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self).offset(self.height/2-40*ScaleX);
                make.height.mas_equalTo(20*ScaleX);
            }];
            
        }else if (i == 1){
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.centerY.equalTo(self);
                make.height.mas_equalTo(20*ScaleX);
            }];
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self).offset(self.height/2+20*ScaleX);
                make.height.mas_equalTo(20*ScaleX);
            }];
        }
    }
}

- (void)setCurrentProfile:(NSString *)currentSelected
{
    for (UIButton *btn in _videoProfileArray) {
        if([btn.titleLabel.text isEqualToString:currentSelected]){
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}
#pragma mark - action
- (void)changeVideoProfileAction:(UIButton *)btn
{
    for (UIButton *btn in _videoProfileArray) {
        btn.selected = NO;
    }
    
    btn.selected = YES;
    
    if (self.refreshVideoProfileBlock) {
        self.refreshVideoProfileBlock(btn.titleLabel.text);
    }
    
    [self removeFromSuperview];
}
@end

@interface VideoSliderView()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIProgressView *slider;
@property (nonatomic, strong) UILabel *label;

@end

@implementation VideoSliderView

//- (instancetype)initWithFrame:(CGRect)frame
- (instancetype)initWithType:(IconType)type
{
    if ([super init]) {
        self.backgroundColor = UIColorFromRGBA(0x333333, 0.8);
        
        _type = type;
        
        _icon = [[UIImageView alloc] init];
        [self addSubview:_icon];
        
//        _slider = [[UISlider alloc] init];
//        _slider.minimumValue = 0;
//        _slider.maximumValue = 1;
//        _slider.maximumTrackTintColor = UIColorFromRGBA(0xFFFFFF, 0.2);
//        _slider.tintColor = kYellowColor;
////        _slider.thumbTintColor = [UIColor clearColor];
//        [self addSubview:_slider];
        
        _slider = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [self addSubview:_slider];
        _slider.progressTintColor = kYellowColor;
        _slider.trackTintColor = UIColorFromRGBA(0xFFFFFF, 0.2);
        
        _label = [MyTool labelWithFont:[MyTool semiboldFontWithSize:9*ScaleX]
                                  text:@""
                             textColor:[UIColor whiteColor]];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    self.layer.cornerRadius = self.height/2;
    self.layer.masksToBounds = YES;
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*ScaleX);
        make.centerY.equalTo(self);
    }];
    
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).offset(5*ScaleX);
        make.right.equalTo(self).offset(-10*ScaleX);
        make.height.mas_equalTo(1*ScaleX);
        make.centerY.equalTo(self);
    }];
}

- (void)setValue:(float)value
{
    if (_type == IconTypeValue) {
        _slider.hidden = YES;
        _icon.hidden = YES;
        _label.hidden = NO;
        
        NSString *str = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)value/60, (NSInteger)value%60];
        _label.text = [NSString stringWithFormat:@"%@/%@", str, _totalTime];
        [MyTool setTextColor:_label
               andFontNumber:_label.font
                 andRangeStr:str
                    andColor:kYellowColor];
    }else{
        _slider.progress = value;
        _slider.hidden = NO;
        _icon.hidden = NO;
        _label.hidden = YES;
        if (_type == IconTypeSun) {
            if (value >= 0.5) {
                _icon.image = [UIImage imageNamed:@"sun_max"];
            }else{
                _icon.image = [UIImage imageNamed:@"sun_min"];
            }
            
        }else if(_type == IconTypeVoice){
            if (value > 0.6) {
                _icon.image = [UIImage imageNamed:@"voice_max"];
            }else if (value == 0){
                _icon.image = [UIImage imageNamed:@"voice_min"];
            }else{
                _icon.image = [UIImage imageNamed:@"voice_middle"];
            }
            
        }
    }
    
}

@end
