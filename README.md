# 描述
本播放器是基于AVPlayer实现的视频播放器+本地下载功能

## 播放器实现功能
- 开始/暂停播放
- 快进快退
- 全屏播放
- 锁屏功能
- 定时隐藏工具栏功能
- 下载功能
- `手势控制音量、亮度、进度`
- `选集功能`
- `播放速度`
- `清晰度选择功能`
加底色的功能是比`master`分支多添加的新功能，如有需要，可切换到`media-20190829`分支查看，[阅读文档](http://note.youdao.com/noteshare?id=86e5d0ae71dbe55a3a26cf8cb6de504f)

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

