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
//  MediaEditView.m
//  LURecordProject
//
//  Created by dookay_73 on 2018/11/1.
//  Copyright © 2018 LU. All rights reserved.
//

#import "MediaEditView.h"

@interface MediaEditView()

@property (nonatomic, strong) UITextField *tf;

@end

@implementation MediaEditView

- (instancetype)init
{
    if ([super initWithFrame:CGRectMake(0, mainHeight - 300*ScaleX, mainWidth, 300*ScaleX)]) {
        
        self.backgroundColor = UIColorFromRGBA(0xFFFFFF, 1);
        self.layer.cornerRadius = 5*ScaleX;
        self.layer.masksToBounds = YES;
        
        _tf = [[UITextField alloc] init];
        _tf.placeholder = @"请为您的视频命名";
        [_tf setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_tf addTarget:self
                action:@selector(clickedEditTF:)
      forControlEvents:UIControlEventEditingChanged];
        _tf.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tf];
        [_tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.right.equalTo(self).offset(-15*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
            make.top.equalTo(self);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = UIColorFromRGB(0xDDDDDD);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tf.mas_bottom).offset(2*ScaleX);
            make.left.equalTo(self).offset(15*ScaleX);
            make.right.equalTo(self).offset(-15*ScaleX);
            make.height.mas_equalTo(0.5);
        }];
        
        UIButton *sureBtn = [MyTool buttonWithTitle:@"确定"
                                         titleColor:[UIColor whiteColor]
                                          titleFont:[MyTool mediumFontWithSize:16*ScaleX]];
        sureBtn.backgroundColor = kThemeBlueColor;
        [self addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tf.mas_bottom).offset(20*ScaleX);
            make.left.equalTo(self).offset(30*ScaleX);
            make.right.equalTo(self).offset(-30*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
        }];
        sureBtn.layer.cornerRadius = 20*ScaleX;
        sureBtn.layer.masksToBounds = YES;
        [sureBtn addTarget:self action:@selector(clickedSureBtnAction) forControlEvents:UIControlEventTouchDown];

        UIButton *cancelBtn = [MyTool buttonWithTitle:@"取消"
                                         titleColor:kThemeBlueColor
                                          titleFont:[MyTool mediumFontWithSize:16*ScaleX]];
//        cancelBtn.backgroundColor = kThemeBlueColor;
        [self addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(sureBtn.mas_bottom).offset(20*ScaleX);
            make.left.equalTo(self).offset(30*ScaleX);
            make.right.equalTo(self).offset(-30*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
        }];
        cancelBtn.layer.cornerRadius = 20*ScaleX;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.borderColor = kThemeBlueColor.CGColor;
        cancelBtn.layer.borderWidth = 1;
        [cancelBtn addTarget:self action:@selector(dismissEditView) forControlEvents:UIControlEventTouchDown];
    }
    
    return self;
}

- (void)clickedEditTF:(UITextField *)tf
{
    if (tf.text.length > 18) {
        tf.text = [tf.text substringToIndex:18];
        [MBProgressHUD showWarnMessage:@"最多18个字"];
    }
}
- (void)showEditView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}
- (void)clickedSureBtnAction
{
    self.getVideoNameBlock(_tf.text);
    [self dismissEditView];
}
- (void)dismissEditView
{
    if (self.superview != nil) {
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
