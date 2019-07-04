//
//  BHDownloadManager.h
//  ColorPickerTest
//
//  Created by BandarHelal on 29/05/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "FCFileManager.h"
#import <AVFoundation/AVFoundation.h>
#import "SVProgressHUD.h"


@interface BHDownloadManager : NSObject
- (void)DownloadVideoWithURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder;
- (void)DownloadThumbnailWithURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder;
- (void)DownloadAudioFromVideoURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder ;
@end
