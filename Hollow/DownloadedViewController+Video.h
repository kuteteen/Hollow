//
//  DownloadedViewController+Video.h
//  ColorPickerTest
//
//  Created by BandarHelal on 06/06/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MaterialActionSheet.h"
#import <Photos/Photos.h>
#import "Colours.h"
#import "MaterialDialogs.h"
#import "jodebox.h"
#import "DownloadedCell.h"
#import "ALActionBlocks.h"
#import "FCFileManager.h"
#import "BHDownloadManager.h"
#import "UIDeviceHardware.h"
#import "BHUtilities.h"

@interface DownloadedViewController_Video : UIViewController
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray<NSURL *> *files;
@property (nonatomic, strong) AVPlayer *VideoPlayer;
@property (nonatomic, strong) MPRemoteCommandCenter *commandCenter;
@property (nonatomic, strong) UIAlertController *alertVC;
@end
