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
//  MediaReportVC.m
//  DookayProject
//
//  Created by dookay_73 on 2018/9/29.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "MediaReportVC.h"

@interface MediaReportVC ()<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSMutableArray *reasonArray;

@property (nonatomic, strong) UIButton *applyBtn;

@property (nonatomic, strong) UIImageView *successImgV;

@end

@implementation MediaReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"举报";
    
    self.dataArray = @[@"涉及黄赌毒和暴力", @"政治", @"版权问题", @"抄袭"];
    _reasonArray = [NSMutableArray arrayWithObject:@"0"];
    [self.view addSubview:self.tableView];
    
    CGFloat bottomY = 50*ScaleX;
    if (IS_IPHONE_X) {
        bottomY += X_foot;
    }
    
    [self.view addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-bottomY);
        make.width.mas_equalTo(240*ScaleX);
        make.height.mas_equalTo(36*ScaleX);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.successImgV];
    self.successImgV.hidden = YES;
    
}

#pragma mark - reuqest
//- (void)dk_requestReportWithReason:(NSString *)reason
//{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:reason forKey:@"reason"];
//    [dic setValue:self.textView.text forKey:@"content"];
//    [dic setValue:@(_domainId) forKey:@"domainId"];
//    [dic setValue:@(_type) forKey:@"type"];
//    
//    [[Interface instance] request:DKInterfaceRequestTypePost
//                           baseUrl:BASE_URL
//                         urlString:u_report
//                        parameters:dic
//                          finished:^(id responseObject, NSString *error) {
//                              if (error || responseObject == nil) {
//                                  [MBProgressHUD showErrorMessage:error.description];
//                              }else{
//                                  self.successImgV.hidden = NO;
//                                  WS(weakSelf);
//                                  dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
//                                  
//                                  dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                                      weakSelf.successImgV.hidden = YES;
//                                  });
//                                  
//                                 
//                              }
//                          }];
//}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _dataArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"reportCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0) {
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"media_unSelected"]];
        [cell addSubview:icon];
        
        for (NSString *str in _reasonArray) {
            if ([str intValue] == indexPath.row) {
                icon.image = [UIImage imageNamed:@"media_selected"];
                break;
            }
        }

        
        UILabel *label = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                          text:_dataArray[indexPath.row]
                                     textColor:UIColorFromRGB(0xFFFFFF)];
        [cell addSubview:label];
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(20*ScaleX);
            make.width.height.mas_equalTo(20*ScaleX);
            make.top.equalTo(cell).offset(20*ScaleX);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(icon.mas_right).offset(20*ScaleX);
            make.centerY.equalTo(icon);
        }];
        
    }else{
        
        UIView *bgV = [[UIView alloc] init];
        [cell addSubview:bgV];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.delegate = self;
        textView.text = @"请输入举报内容，我们将尽快处理";
        textView.textColor = UIColorFromRGB(0x999999);
        textView.backgroundColor = [UIColor clearColor];
        [bgV addSubview:textView];
        _textView = textView;
        
        [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell).offset(20*ScaleX);
            make.right.equalTo(cell).offset(-20*ScaleX);
            make.top.equalTo(cell).offset(40*ScaleX);
            make.height.mas_equalTo(160*ScaleX);
        }];
        
        bgV.layer.borderWidth = 1;
        bgV.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(bgV).offset(10*ScaleX);
            make.bottom.right.equalTo(bgV).offset(-10*ScaleX);
        }];
        
        UILabel *label = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                          text:@"也可以发邮件给我们：jubao@manamana.net"
                                     textColor:UIColorFromRGB(0xFFFFFF)];
        [cell addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgV.mas_left);
            make.top.equalTo(bgV.mas_bottom).offset(10*ScaleX);
        }];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40*ScaleX;
    }else{
        return 260*ScaleX;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0)];
        
        UILabel *titleLabel = [MyTool labelWithFont:[MyTool mediumFontWithSize:14*ScaleX]
                                               text:@"请选择举报理由"
                                          textColor:UIColorFromRGB(0xFFFFFF)];
        [view addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).offset(20*ScaleX);
            make.top.equalTo(view).offset(30*ScaleX);
        }];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50*ScaleX;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BOOL isAdd = YES;
        for (NSString *str in _reasonArray) {
            if ([str intValue] == indexPath.row) {
                isAdd = NO;
                break;
            }
        }
        if (isAdd) {
            [self.reasonArray addObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        }
        [self.tableView reloadData];
//        [self.tableView reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - textView
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入举报内容，我们将尽快处理"]) {
        textView.text = @"";
    }
}

#pragma mark - action
- (void)clickedApplyBtnAction
{
    if ([self.textView.text isEqualToString:@"请输入举报内容，我们将尽快处理"] || self.textView.text.length == 0) {
        [MBProgressHUD showWarnMessage:@"请输入举报内容"];
        return;
    }
    if (_reasonArray.count == 0) {
        [MBProgressHUD showWarnMessage:@"请选择举报理由"];
        return;
    }
    
    NSString *reason = @"";
    for (NSString *indexStr in _reasonArray) {
        NSInteger index = [indexStr integerValue];
        if (reason.length == 0) {
            reason = _dataArray[index];
        }else{
            reason = [NSString stringWithFormat:@"%@,%@", reason, _dataArray[index]];
        }
        
    }
//    [self dk_requestReportWithReason:reason];
}
#pragma mark - getter
- (UITableView *)tableView
{
    if (!_tableView) {
        CGFloat topY = 64;
        CGFloat height = mainHeight - topY;
        if (IS_IPHONE_X) {
            topY = 44 + X_head;
            height = mainHeight - topY - X_foot;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topY, mainWidth, height)
                                                  style:UITableViewStyleGrouped];
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = UIColorFromRGB(0x1D1C21);
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (UIButton *)applyBtn
{
    if (!_applyBtn) {
        _applyBtn = [MyTool buttonWithTitle:@"提交"
                                 titleColor:UIColorFromRGB(0xFFFFFF)
                                  titleFont:[MyTool mediumFontWithSize:14*ScaleX]];
        _applyBtn.backgroundColor = UIColorFromRGB(0x0E5BFF);
        _applyBtn.layer.cornerRadius = 18*ScaleX;
        _applyBtn.layer.masksToBounds = YES;
        [_applyBtn addTarget:self
                      action:@selector(clickedApplyBtnAction)
            forControlEvents:UIControlEventTouchDown];
    }
    return _applyBtn;
}

- (UIImageView *)successImgV
{
    if (!_successImgV) {
        _successImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"report_success"]];
        _successImgV.bounds = CGRectMake(0, 0, 270*ScaleX, 160*ScaleX);
        _successImgV.center = self.view.center;
    }
    return _successImgV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
