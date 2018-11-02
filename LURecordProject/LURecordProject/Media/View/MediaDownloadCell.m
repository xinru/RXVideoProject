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
//  MediaDownloadCell.m
//  DookayProject
//
//  Created by dookay_73 on 2018/10/10.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "MediaDownloadCell.h"

@interface MediaDownloadCell()

@property (nonatomic, strong) UIView *cellView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UILabel *byteLabel;
@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIButton *leftDeleteBtn;
@property (nonatomic, strong) UIButton *rightDeleteBtn;

@end

@implementation MediaDownloadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        _rightDeleteBtn = [MyTool buttonWithTitle:@"删除"
                                       titleColor:[UIColor whiteColor]
                                        titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
        [_rightDeleteBtn addTarget:self
                            action:@selector(deleteCellAction)
                  forControlEvents:UIControlEventTouchDown];
        _rightDeleteBtn.backgroundColor = UIColorFromRGB(0xFF3131);
        [self addSubview:_rightDeleteBtn];
        _leftDeleteBtn = [MyTool buttonWithImage:[UIImage imageNamed:@"download_delete"]
                                    selectedImage:[UIImage imageNamed:@"download_delete"]];
        [_leftDeleteBtn addTarget:self action:@selector(deleteCellAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_leftDeleteBtn];
        
        [_leftDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15*ScaleX);
            make.centerY.equalTo(self);
        }];
        [_rightDeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(65*ScaleX);
        }];
        
        _cellView = [[UIView alloc] init];
        _cellView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        [self addSubview:_cellView];
        [_cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
//        UIView *line = [[UIView alloc] init];
//        line.backgroundColor = UIColorFromRGB(0x2D2C2F);
//        [self addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self);
//            make.height.mas_equalTo(0.5);
//        }];
        
        [_cellView addSubview:self.progressView];
        _titleLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                       text:@""
                                  textColor:UIColorFromRGB(0x000000)];
        [_cellView addSubview:_titleLabel];
        
        _tipLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                     text:@""
                                textColor:UIColorFromRGB(0x999999)];
        [_cellView addSubview:_tipLabel];
        
       
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellView).offset(24*ScaleX);
            make.top.equalTo(self.cellView).offset(16*ScaleX);
            make.right.equalTo(self.cellView).offset(-24*ScaleX);
        }];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cellView).offset(-24*ScaleX);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12*ScaleX);
        }];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipLabel.mas_bottom).offset(5*ScaleX);
            make.left.equalTo(self.cellView).offset(24*ScaleX);
            make.right.equalTo(self.cellView).offset(-24*ScaleX);
            make.height.mas_equalTo(4*ScaleX);
        }];
        
        _byteLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                      text:@""
                                 textColor:UIColorFromRGB(0x999999)];
        [_cellView addSubview:_byteLabel];
        _byteLabel.hidden = YES;
        
        _icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"download_success"]];
        _icon.hidden = YES;
        [_cellView addSubview:_icon];
        
        [_byteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15*ScaleX);
        }];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cellView).offset(-15*ScaleX);
            make.centerY.equalTo(self.byteLabel);
        }];
        
        _cellView.userInteractionEnabled = YES;
//        [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(<#selector#>)]
//        UISwipeGestureRecognizer *swipeGest = [[UISwipeGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            [UIView animateWithDuration:.5 animations:^{
//                _cellView.x = -65*ScaleX;
//            }];
//        }];
//        swipeGest.direction = UISwipeGestureRecognizerDirectionLeft;
//        [_cellView addGestureRecognizer:swipeGest];
//
//        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            [UIView animateWithDuration:.5 animations:^{
//                _cellView.x = 0;
//            }];
//        }];
//        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//        [_cellView addGestureRecognizer:rightSwipe];
        
    }
    
    return self;
}
- (void)setIsDelete:(BOOL)isDelete
{
    if (isDelete) {
        [UIView animateWithDuration:.5 animations:^{
            self.cellView.x = 35*ScaleX;
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            self.cellView.x = 0;
        }];
    }
}
- (void)setVideoName:(NSString *)videoName
{
    _titleLabel.text = videoName;
}
- (void)setModel:(MediaDownloadModel *)model
{
    _model = model;
    _titleLabel.text = model.videoName;
    if (model.videoBytes > 0) {
        _byteLabel.text = [NSString stringWithFormat:@"大小%.1fMB", model.videoBytes/1024/1024];
    }
}
- (void)refreshDownloadTaskInfoWithValue:(CGFloat)value andBytesStr:(NSString *)bytesStr andTotalBytes:(NSString *)totalBytes
{
    _progressView.progress = value;
    _tipLabel.text = bytesStr;
    _byteLabel.text = totalBytes;
}

- (void)refreshDownloadUI:(BOOL)isSuccess
{
    _progressView.hidden = isSuccess;
    _tipLabel.hidden = isSuccess;
    _byteLabel.hidden = !isSuccess;
    _icon.hidden = !isSuccess;
}

#pragma mark - action

- (void)deleteCellAction
{
    self.deleteCellBlock(self);
}

#pragma mark - getter

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        //设置进度条颜色
        _progressView.trackTintColor = [UIColor whiteColor];;
        //设置进度条上进度的颜色
        _progressView.progressTintColor = UIColorFromRGB(0x0E5BFF);
        //设置进度默认值，这个相当于百分比，范围在0~1之间，不可以设置最大最小值
        _progressView.progress = 0.0;
    }
    return _progressView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
