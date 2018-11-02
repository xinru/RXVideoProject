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
//  MediaDetailVC.m
//  DookayProject
//
//  Created by dookay_73 on 2018/9/27.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "MediaDetailVC.h"

#import "DKAVPlayer.h"
#import "DKFullScreenVC.h"

#import "MediaReportVC.h"

#import "MediaDownloadVC.h"
#import "DKDownloadTask.h"
#import "MediaEditView.h"

@interface MediaDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DKAVPlayer *avPlayer;
@property (nonatomic, strong) DKFullScreenVC *fullPlayer;


@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) MediaModel *model;


@end

@implementation MediaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"视频详情";
//0x1D1C1F
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    _UrlStr = @"http://v.dansewudao.com/444fccb3590845a799459f6154d2833f/fe86a70dc4b8497f828eaa19058639ba-6e51c667edc099f5b9871e93d0370245-sd.mp4";
    self.avPlayer.mediaUrlStr = [NSString stringWithFormat:@"%@",_UrlStr];

}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videoCell"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        [cell addSubview:self.avPlayer];
    }else{
        UIButton *downLoadBtn = [MyTool buttonWithTitle:@"下载"
                                             titleColor:[UIColor blackColor]
                                              titleFont:[MyTool mediumFontWithSize:16*ScaleX]];
        [cell addSubview:downLoadBtn];

        [downLoadBtn addTarget:self
                        action:@selector(clickedDownloadAction)
              forControlEvents:UIControlEventTouchDown];
        
        UIButton *shareBtn = [MyTool buttonWithTitle:@"分享"
                                          titleColor:[UIColor blackColor]
                                           titleFont:[MyTool mediumFontWithSize:16*ScaleX]];
        [cell addSubview:shareBtn];
        
        [downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell).offset(-mainWidth/4);
            make.top.equalTo(cell).offset(20*ScaleX);
            make.width.mas_equalTo(100*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
        }];
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell).offset(mainWidth/4);
            make.centerY.equalTo(downLoadBtn);
            make.width.mas_equalTo(100*ScaleX);
            make.height.mas_equalTo(40*ScaleX);
        }];
    }
    
    return cell;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return mainWidth*9/16;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - action
- (void)clickedDownloadAction
{
    WS(weakSelf);
    MediaEditView *editView = [[MediaEditView alloc] init];
    [editView showEditView];
    [editView setGetVideoNameBlock:^(NSString *name) {
        if (name.length > 0) {
            MediaModel *model = [[MediaModel alloc] init];
            model.title = name;
            model.downloadUrl = weakSelf.UrlStr;
            [[DKDownloadTask taskShared] startDownloadVideoWithModel:model];
            MediaDownloadVC *downloadVC = [[MediaDownloadVC alloc] init];
            [weakSelf.navigationController pushViewController:downloadVC animated:YES];
        }
    }];

}

#pragma mark - getter
- (DKAVPlayer *)avPlayer
{
    if (!_avPlayer) {
        _avPlayer = [[DKAVPlayer alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainWidth*9/16) andMediaURL:nil];
        _avPlayer.backgroundColor = UIColorFromRGB(0x1D1C1F);
        WS(weakSelf);
        [_avPlayer setClickedFullScreenBlock:^(BOOL isFullScreen) {
            if (isFullScreen) {
                weakSelf.avPlayer.isFullScreen = YES;
                weakSelf.fullPlayer = [[DKFullScreenVC alloc] init];
                [weakSelf.fullPlayer.view addSubview:weakSelf.avPlayer];
                weakSelf.avPlayer.frame = CGRectMake(0, 0, mainHeight, mainWidth);
                [weakSelf.tempbtn removeFromSuperview];
                [weakSelf presentViewController:weakSelf.fullPlayer animated:NO completion:nil];
            }else{
                weakSelf.avPlayer.isFullScreen = NO;
                [weakSelf.fullPlayer dismissViewControllerAnimated:NO completion:^{

                    weakSelf.avPlayer.frame = CGRectMake(0, 0, mainWidth, 200*ScaleX);
                    [weakSelf.tableView reloadData];

                }];

            }
        }];
        
    }
    return _avPlayer;
}


-(void)dealloc{
    [self.avPlayer pausePlay];
    self.avPlayer =nil;
}

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
        _tableView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
    }
    return _tableView;
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
