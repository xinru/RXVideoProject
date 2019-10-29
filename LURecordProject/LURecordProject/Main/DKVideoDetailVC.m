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
//  DKVideoDetailVC.m
//  DookayProject
//
//  Created by dookay_73 on 2019/9/20.
//  Copyright © 2019 Dookay. All rights reserved.
//

#import "DKVideoDetailVC.h"
#import "VideoListCell.h"
#import "DKAVPlayer.h"


@interface DKVideoDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) DKAVPlayer *avPlayer;

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation DKVideoDetailVC
- (void)dealloc
{
    [_avPlayer removeAVPlayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.bar.title = @"视频播放";
    
    _avPlayer = [[DKAVPlayer alloc] initWithFrame:CGRectMake(0, DEF_BOTTOM(self.bar), mainWidth, 210*ScaleX) superView:self.view];
    WS(weakSelf);
    [_avPlayer setRefreshVideoUrlBlcok:^(NSInteger sectionIndex) {
        weakSelf.index = sectionIndex;
        [weakSelf.tableView reloadData];
    }];
    [self.view addSubview:_avPlayer];
    [_avPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.bar.mas_bottom);
        make.height.mas_equalTo(210*ScaleX);
    }];
    
    
    [self tableView];
    
    [self dk_requestCourseOutline];
    
}

- (void)clickAction_leftItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.avPlayer removeAVPlayer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}
#pragma mark - request模拟数据
- (void)dk_requestCourseOutline
{
    NSArray *array = @[@{@"url":@"http://vd4.bdstatic.com/mda-jjtgnwfnvni42ysb/sc/mda-jjtgnwfnvni42ysb.mp4", @"duration":@"180", @"title":@"MV"},
                       @{@"url":@"http://vd3.bdstatic.com/mda-ji1n0vxgcv51v0wc/sc/mda-ji1n0vxgcv51v0wc.mp4", @"duration":@"180", @"title":@"英语学习"},
                       @{@"url":@"http://vd2.bdstatic.com/mda-jjdmkxxv4ki9zr7k/sc/mda-jjdmkxxv4ki9zr7k.mp4", @"duration":@"180", @"title":@"小猪佩奇"}];
    _dataArray = [NSMutableArray array];
     for (NSDictionary *dataDic in array) {
         DKVideoModel *model = [[DKVideoModel alloc] init];
         model.mediaName = dataDic[@"title"];
         model.mediaUrlStr = dataDic[@"url"];
         model.totalSeconds = [dataDic[@"duration"] integerValue];
         [_dataArray addObject:model];
     }
     [self.tableView reloadData];
   
     DKVideoModel *videoModel = _dataArray[_index];
//    此选项用于实现选集功能，如不需要可不填
//     _avPlayer.sectionList = _dataArray;
//     _avPlayer.sectionIndex = _index;
    
     [_avPlayer prepareForPlayWithModel:videoModel isPlay:YES];
    
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
       
        return _dataArray.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoListCellID];
    if (indexPath.section == 1) {
        [cell reloadData:_dataArray[indexPath.row] index:indexPath.row+1];
    }else{
        [cell reloadData:_dataArray[_index] index:_index+1];
    }
    return cell;
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 0)];
    view.backgroundColor = [UIColor whiteColor];
    
    if (section == 1) {
        
        UILabel *label = [MyTool labelWithFont:[MyTool mediumFontWithSize:16*ScaleX]
                                          text:@"列表"
                                     textColor:UIColorFromRGB(0x8EC31F)];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(view).offset(15*ScaleX);
        }];
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66*ScaleX;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 46*ScaleX;
    }else{
        return 10*ScaleX;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1 ) {
        DKVideoModel *model = _dataArray[indexPath.row];

//        是否直接播放依照当前播放状态决定
        [_avPlayer prepareForPlayWithModel:model isPlay:_avPlayer.isPlaying];
        
        _index = indexPath.row;
        [self.tableView reloadData];

    }
    
    
}
#pragma mark -getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        [_tableView registerClass:[VideoListCell class]
           forCellReuseIdentifier:kVideoListCellID];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.bar.mas_bottom).offset(210*ScaleX);
        }];
    }
    
    return _tableView;
}

@end
