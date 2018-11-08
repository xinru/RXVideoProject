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
//  MediaFullScreenVC.m
//  LURecordProject
//
//  Created by dookay_73 on 2018/11/8.
//  Copyright © 2018 LU. All rights reserved.
//

#import "MediaFullScreenVC.h"
#import "DKAVPlayer.h"
#import "DKFullScreenVC.h"

@interface MediaFullScreenVC ()

@property (nonatomic, strong) DKAVPlayer *avPlayer;
@property (nonatomic, strong) DKFullScreenVC *fullPlayer;

@end

@implementation MediaFullScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _avPlayer = [[DKAVPlayer alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainWidth*9/16)
                                      andMediaURL:nil];
    _avPlayer.backgroundColor = UIColorFromRGB(0x1D1C1F);
    _avPlayer.isFullScreen = YES;
    self.fullPlayer = [[DKFullScreenVC alloc] init];
    [self.fullPlayer.view addSubview:self.avPlayer];
    self.avPlayer.frame = CGRectMake(0, 0, mainHeight, mainWidth);
    [self presentViewController:self.fullPlayer animated:NO completion:nil];
}

-(void)dealloc{
    [self.avPlayer pausePlay];
    self.avPlayer =nil;
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
