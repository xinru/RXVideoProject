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
//  MediaDownloadVC.m
//  DookayProject
//
//  Created by dookay_73 on 2018/10/10.
//  Copyright © 2018年 Dookay. All rights reserved.
//

#import "MediaDownloadVC.h"
#import "MediaDownloadCell.h"
#import "DKDownloadTask.h"
#import "MediaDownloadModel.h"

NSString *kMediaDownloadCell = @"MediaDownloadCell";

@interface MediaDownloadVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isDelete;

@end

@implementation MediaDownloadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"离线下载";
    _isDelete = NO;
    WS(weakSelf);
    [self setRightButtonWithTitle:@"编辑"
                            Image:@""
                    SelectedImage:@""
                           Action:^{
                               weakSelf.isDelete = !weakSelf.isDelete;
                               for (int i = 0; i < weakSelf.dataArray.count; i++) {
                                   NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                   MediaDownloadCell *cell = (MediaDownloadCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                                   cell.isDelete = weakSelf.isDelete;
                               }
                               
                           }];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kDownloadVideoList];
    _dataArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        MediaDownloadModel *model = [MediaDownloadModel yy_modelWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [self.view addSubview:self.tableView];
    
    [self refreshDownloadCell];
    
}
#pragma mark - 下载状态刷新
- (void)refreshDownloadCell
{
    WS(weakSelf);
    [[DKDownloadTask taskShared] setRefreshSliderValueBlock:^(CGFloat value, CGFloat currentBytes, CGFloat totalBytes, NSString *videoUrl) {
        
        NSLog(@"%f__%f___%f___%@", value, currentBytes, totalBytes, videoUrl);
        for (int i = 0; i < weakSelf.dataArray.count; i++) {
            MediaDownloadModel *model = weakSelf.dataArray[i];
            
            if ([videoUrl rangeOfString:model.url].location != NSNotFound) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                MediaDownloadCell *cell = (MediaDownloadCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                NSString *str = [NSString stringWithFormat:@"缓存中：%.1f/%.1fMB", currentBytes, totalBytes];
                [cell refreshDownloadTaskInfoWithValue:value andBytesStr:str andTotalBytes:[NSString stringWithFormat:@"大小：%.1fMB", totalBytes]];
                break;
            }
        }
        
    }];
    
    [[DKDownloadTask taskShared] setRefreshDownloadSuccessCellBlock:^(NSString *videoUrl) {

        for (int i = 0; i < weakSelf.dataArray.count; i++) {
            MediaDownloadModel *model = weakSelf.dataArray[i];
            
            if ([videoUrl rangeOfString:model .url].location != NSNotFound) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                MediaDownloadCell *cell = (MediaDownloadCell *)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
                [cell refreshDownloadUI:YES];
                break;
            }
        }
    }];
}



#pragma mark - table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MediaDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:kMediaDownloadCell];
    MediaDownloadModel *model = _dataArray[indexPath.row];
//    cell.videoName = dic[@"videoName"];
    cell.model = model;
    cell.isDelete = _isDelete;
    [cell refreshDownloadUI:model.isDownload];
    WS(weakSelf);
    [cell setDeleteCellBlock:^(MediaDownloadCell *cell) {
        NSInteger index = [weakSelf.tableView indexPathForCell:cell].row;
        [[DKDownloadTask taskShared] deleteDownloadVideoWithIndex:index];
        [weakSelf.dataArray removeObjectAtIndex:index];
        weakSelf.isDelete = NO;
        [weakSelf.tableView reloadData];
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark - tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 96*ScaleX;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        [_tableView registerClass:[MediaDownloadCell class]
           forCellReuseIdentifier:kMediaDownloadCell];
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
