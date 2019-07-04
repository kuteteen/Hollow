//
//  BHUtilities.m
//  Hollow
//
//  Created by BandarHelal on 03/07/2019.
//

#import "BHUtilities.h"

@implementation BHUtilities

- (void)ConvertVideoToAudio:(NSURL *)VideoURLPath VideoTitle:(NSString *)title {
    
    NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    
    AVMutableComposition *newAudioAsset = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *dstCompositionTrack;
    dstCompositionTrack = [newAudioAsset addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    AVAsset *srcAsset = [AVURLAsset URLAssetWithURL:VideoURLPath options:nil];
    AVAssetTrack *srcTrack = [[srcAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    
    CMTimeRange timeRange = srcTrack.timeRange;
    
    NSError *error;
    
    if (NO == [dstCompositionTrack insertTimeRange:timeRange ofTrack:srcTrack atTime:kCMTimeZero error:&error]) {
        NSLog(@"track insert failed: %@\n", error);
        return;
    }
    
    
    AVAssetExportSession *exportSesh = [[AVAssetExportSession alloc] initWithAsset:newAudioAsset presetName:AVAssetExportPresetPassthrough];
    
    exportSesh.outputFileType = AVFileTypeAppleM4A;
    exportSesh.outputURL = [[[NSURL fileURLWithPath:documentsDirectoryPath] URLByAppendingPathComponent:@"BH"] URLByAppendingPathComponent:title];
    
    
    [exportSesh exportAsynchronouslyWithCompletionHandler:^{
        AVAssetExportSessionStatus  status = exportSesh.status;
        NSLog(@"export: %ld", (long)status);
        
        if (AVAssetExportSessionStatusFailed == status) {
            NSLog(@"FAILURE: %@\n", exportSesh.error);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"error exporting \n %@", exportSesh.error]];
                    [SVProgressHUD dismissWithDelay:1.5];
                });
            });
        } else if (AVAssetExportSessionStatusCompleted == status) {
            NSLog(@"SUCCESS!\n");
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showSuccessWithStatus:@"Done"];
                    [SVProgressHUD dismissWithDelay:1.5];
                });
            });
        }
    }];
}
@end
