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
//  RootNavBar.m
//  DookayProject
//
//  Created by dookay_73 on 2019/8/8.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "RootNavBar.h"

@interface RootNavBar()

//标题  title
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imgV;

@end


@implementation RootNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _imgV = [[UIImageView alloc] init];
        [self addSubview:_imgV];
        
        _titleLabel = [MyTool labelWithFont:[MyTool regularFontWithSize:18]
                                       text:@""
                                  textColor:UIColorFromRGB(0x333333)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _leftBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"xn_default_back"]
                             selectedImage:nil];
        [self addSubview:_leftBtn];
        [_leftBtn addTarget:self
                     action:@selector(backBtnAction)
           forControlEvents:UIControlEventTouchDown];
        
        _rightBtn = [MyTool buttonWithTitle:@""];
        [self addSubview:_rightBtn];
        [_rightBtn addTarget:self
                      action:@selector(rightBtnAction)
            forControlEvents:UIControlEventTouchDown];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(60*ScaleX);
            make.right.equalTo(self).offset(-60*ScaleX);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(44);
        }];
        
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0*ScaleX);
            make.height.mas_equalTo(44);
            make.width.mas_greaterThanOrEqualTo(44);
            make.centerY.equalTo(_titleLabel);
        }];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10*ScaleX);
            make.width.height.mas_equalTo(44);
            make.centerY.equalTo(_titleLabel);
        }];
    }
    return self;
}


#pragma mark - setter
- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
- (void)setIsHiddenLeftBtn:(BOOL)isHiddenLeftBtn
{
    _leftBtn.hidden = isHiddenLeftBtn;
}

- (void)setBarType:(NavBarType)barType
{
    if (barType == NavBarTypeDefault) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = UIColorFromRGB(0x333333);
        [_leftBtn setImage:[UIImage imageNamed:@"xn_default_back"] forState:UIControlStateNormal];
    }else if (barType == NavBarTypeBlack){
        self.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [_leftBtn setImage:[UIImage imageNamed:@"xn_default_white"] forState:UIControlStateNormal];
    }else if (barType == NavBarTypeImage){
        self.image = [UIImage imageNamed:@"navigationBar_bg"];
        self.titleLabel.textColor = [UIColor whiteColor];
        [_leftBtn setImage:[UIImage imageNamed:@"xn_default_white"] forState:UIControlStateNormal];
    }else if (barType == NavBarTypeBottomImage){
        _imgV.image = [UIImage imageNamed:@"navBar_icon"];
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(2*ScaleX);
        }];
    }
}
#pragma mark - action
- (void)backBtnAction
{
    if (_leftBtnBlock) {
        _leftBtnBlock();
    }
}
- (void)rightBtnAction
{
    if (_rightBtnBlock) {
        _rightBtnBlock();
    }
}
@end
