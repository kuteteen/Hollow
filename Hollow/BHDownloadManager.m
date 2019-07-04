//
//  BHDownloadManager.m
//  ColorPickerTest
//
//  Created by BandarHelal on 29/05/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import "BHDownloadManager.h"

@implementation BHDownloadManager

- (void)DownloadVideoWithURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        NSLog(@"%.2f", downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showProgress:(CGFloat)downloadProgress.fractionCompleted status:@"Downloading..."];
            });
        });
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [[documentsDirectoryURL URLByAppendingPathComponent:folder] URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSString *str = [NSString stringWithFormat:@"%@/%@",folder,filePath.lastPathComponent];
        [FCFileManager renameItemAtPath:str withName:[NSString stringWithFormat:@"%@.mp4",filename]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"Done"];
                [SVProgressHUD dismissWithDelay:2];
            });
        });
        NSLog(@"Done");
        
    }];
    [downloadTask resume];
    
}

- (void)DownloadThumbnailWithURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [[documentsDirectoryURL URLByAppendingPathComponent:folder] URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSString *str = [NSString stringWithFormat:@"%@/%@",folder,filePath.lastPathComponent];
        [FCFileManager renameItemAtPath:str withName:[NSString stringWithFormat:@"%@.png",filename]];
        NSLog(@"Done");
    }];
    [downloadTask resume];
    
}

- (void)DownloadAudioFromVideoURL:(NSURL *)url WithFileName:(NSString *)filename inFolderName:(NSString *)folder {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        NSLog(@"%.2f", downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showProgress:(CGFloat)downloadProgress.fractionCompleted status:@"Downloading..."];
            });
        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [[documentsDirectoryURL URLByAppendingPathComponent:folder] URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error1) {
//        NSString *str = [NSString stringWithFormat:@"%@/%@",folder,filePath.lastPathComponent];
//        [FCFileManager renameItemAtPath:str withName:[NSString stringWithFormat:@"%@.mp4",filename]];
//        NSLog(@"Done");
        
        NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
        
        AVMutableComposition *newAudioAsset = [AVMutableComposition composition];
        AVMutableCompositionTrack *dstCompositionTrack;
        dstCompositionTrack = [newAudioAsset addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        
        
        AVAsset *srcAsset = [AVURLAsset URLAssetWithURL:filePath.absoluteURL options:nil];
        AVAssetTrack *srcTrack = [[srcAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
        
        
        CMTimeRange timeRange = srcTrack.timeRange;
        
        NSError *error;
        
        if (NO == [dstCompositionTrack insertTimeRange:timeRange ofTrack:srcTrack atTime:kCMTimeZero error:&error]) {
            NSLog(@"track insert failed: %@\n", error);
            return;
        }
        
        
        AVAssetExportSession *exportSesh = [[AVAssetExportSession alloc] initWithAsset:newAudioAsset presetName:AVAssetExportPresetPassthrough];
        
        exportSesh.outputFileType = AVFileTypeAppleM4A;
        exportSesh.outputURL = [[[NSURL fileURLWithPath:documentsDirectoryPath] URLByAppendingPathComponent:folder] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a",filename]];
        
        
        [exportSesh exportAsynchronouslyWithCompletionHandler:^{
            AVAssetExportSessionStatus  status = exportSesh.status;
            NSLog(@"export: %ld", (long)status);
            
            if (AVAssetExportSessionStatusFailed == status) {
                NSLog(@"FAILURE: %@\n", exportSesh.error);
            } else if (AVAssetExportSessionStatusCompleted == status) {
                NSLog(@"SUCCESS!\n");
                [[NSFileManager defaultManager] removeItemAtURL:filePath.absoluteURL error:nil];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showSuccessWithStatus:@"Done"];
                        [SVProgressHUD dismissWithDelay:2];
                    });
                });
            }
        }];
        
        
    }];
    [downloadTask resume];
}


@end
