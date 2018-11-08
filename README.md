# 描述
本播放器是基于AVPlayer实现的视频播放器+本地下载功能

## 播放器实现功能
- 开始/暂停播放
- 快进快退
- 全屏播放
- 锁屏功能
- 定时隐藏工具栏功能
- 下载功能


## 使用方法
- 播放视频
```
- (instancetype)initWithFrame:(CGRect)frame
                  andMediaURL:(NSString *)urlStr;
```
- 如果视频地址是网络请求的，MediaURL可以穿nil, 给mediaUrlStr赋值
```
//视频地址
@property (nonatomic, strong) NSString *mediaUrlStr;
```

- 下载视频(MediaModel主要存储一些视频相关的信息，可改动)
```
//开始下载
- (void)startDownloadVideoWithModel:(MediaModel *)model;
```

- 删除视频
```
//删除下载
- (void)deleteDownloadVideoWithIndex:(NSInteger)index;
```

