//
//  DownloadedViewController+Audio.m
//  ColorPickerTest
//
//  Created by BandarHelal on 06/06/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import "DownloadedViewController+Audio.h"


@interface DownloadedViewController_Audio () <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end


@implementation DownloadedViewController_Audio

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetupViewController];
    [self SetupRemoteTransportControls];
    [self SetupDocumentsDirectoryPath];
}

- (void)SetupViewController {
    self.view.backgroundColor = [UIColor colorFromHexString:@"282828"];
    self.AudioTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.AudioTable setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.AudioTable setBackgroundColor: [UIColor colorFromHexString:@"282828"]];
    [self.AudioTable setOpaque:NO];
    self.AudioTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.AudioTable.delegate = self;
    self.AudioTable.dataSource = self;
    [self.view addSubview:self.AudioTable];
    [self.AudioTable registerClass:DownloadedCell.class forCellReuseIdentifier:@"Acell"];
    
    [self.AudioTable.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.AudioTable.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.AudioTable.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.AudioTable.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
}

- (void)SetupRemoteTransportControls {
    
    self.AudioCommandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    [self.AudioCommandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        if (!self.audioPlayer.isPlaying) {
            [self.audioPlayer play];
            return MPRemoteCommandHandlerStatusSuccess;
        }
        return MPRemoteCommandHandlerStatusCommandFailed;
    }];
    
    [self.AudioCommandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        
        if (self.audioPlayer.isPlaying) {
            [self.audioPlayer pause];
            return MPRemoteCommandHandlerStatusSuccess;
        }
        return MPRemoteCommandHandlerStatusCommandFailed;
    }];
    
    [self.AudioCommandCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        
        if (self.islastRow == true) {
            DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.AudioTable.indexPathsForVisibleRows.lastObject.row inSection:0]];
            [Acell.PlayButton setAlpha:0];
            [Acell.TimeView setAlpha:1];
            [Acell.TimeLine setAlpha:0];
            [Acell.TimeLineLabel setAlpha:0];
            [Acell.TimeLabelOfTimeLine setAlpha:0];
            [self.audioPlayer stop];
            return MPRemoteCommandHandlerStatusSuccess;
        } else {
            DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:self.index];
            [Acell.PlayButton setAlpha:0];
            [Acell.TimeView setAlpha:1];
            [Acell.TimeLine setAlpha:0];
            [Acell.TimeLineLabel setAlpha:0];
            [Acell.TimeLabelOfTimeLine setAlpha:0];
            [self nextAutoTrack];
            return MPRemoteCommandHandlerStatusSuccess;
        }
        return MPRemoteCommandHandlerStatusCommandFailed;
    }];
    
    [self.AudioCommandCenter.playCommand setEnabled:true];
    [self.AudioCommandCenter.pauseCommand setEnabled:true];
    [self.AudioCommandCenter.nextTrackCommand setEnabled:true];
    [self.AudioCommandCenter.previousTrackCommand setEnabled:false];
    
    
    
}

- (void)SetupDocumentsDirectoryPath {
    
    [FCFileManager createDirectoriesForPath:@"BH"];
    
    NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectoryPath];
    
    do {
        NSError *error;
        self.Audiofiles = [NSFileManager.defaultManager contentsOfDirectoryAtURL:[documentsURL URLByAppendingPathComponent:@"BH"] includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
        if (error) {
            NSLog(@"i found some errors:%@", error);
        }
    } while (nil);
    
    
    //NSLog(@"files count = %lu", (unsigned long)self.Audiofiles.count);
    //NSLog(@"%@",documentsURL);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.AudioTable reloadData];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Audiofiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable dequeueReusableCellWithIdentifier:@"Acell"];
    AVAsset *asset = [AVAsset assetWithURL:self.Audiofiles[indexPath.row].absoluteURL];
    NSUInteger durationSeconds = (long)CMTimeGetSeconds(asset.duration);
    NSUInteger hours = floor(durationSeconds / 3600);
    NSUInteger minutes = floor(durationSeconds % 3600 / 60);
    NSUInteger seconds = floor(durationSeconds % 3600 % 60);
    
    Acell.selectionStyle = UITableViewCellSelectionStyleNone;
    [Acell.MoreButton addTarget:self action:@selector(ShowAudioSheet:event:) forControlEvents:UIControlEventTouchUpInside];
    [Acell.TimeLine addTarget:self action:@selector(TimeLineHandler:) forControlEvents:UIControlEventValueChanged];
    
    if ([self.Audiofiles[indexPath.row].lastPathComponent containsString:@".png"]) {
        
        [self.Audiofiles removeObjectAtIndex:indexPath.row];
        [self.AudioTable reloadData];
        
    } else if ([self.Audiofiles[indexPath.row].lastPathComponent containsString:@".jpg"]) {
        
        [self.Audiofiles removeObjectAtIndex:indexPath.row];
        [self.AudioTable reloadData];
        
    } else if ([self.Audiofiles[indexPath.row].lastPathComponent containsString:@".mp4"]) {
        
        [self.Audiofiles removeObjectAtIndex:indexPath.row];
        [self.AudioTable reloadData];
    } else {
        if (self.Audiofiles[indexPath.row].lastPathComponent) {
            
            if (hours == 0) {
                
                Acell.VideoTitle.text = [self.Audiofiles[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".m4a" withString:@""];
                Acell.VideoImage.image = [UIImage imageNamed:[self.Audiofiles[indexPath.row].path stringByReplacingOccurrencesOfString:@"m4a" withString:@"png"]];
                // /Library/Application Support/BH/Ressources.bundle/baseline_library_music_white_24pt
                Acell.TypeImage.image = [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_library_music_white_24pt"];
                Acell.TimeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)minutes,(unsigned long)seconds];
            } else {
                
                Acell.VideoTitle.text = [self.Audiofiles[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
                Acell.VideoImage.image = [UIImage imageNamed:[self.Audiofiles[indexPath.row].path stringByReplacingOccurrencesOfString:@"mp4" withString:@"png"]];
                // /Library/Application Support/BH/Ressources.bundle/baseline_video_library_white_24pt
                Acell.TypeImage.image = [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_video_library_white_24pt"];
                Acell.TimeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hours,(unsigned long)minutes,(unsigned long)seconds];
            }
            
        }
    }
    return Acell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.audioPlayer stop];
    DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:indexPath];
    AVAsset *asset = [AVAsset assetWithURL:self.Audiofiles[indexPath.row].absoluteURL];
    NSUInteger durationSeconds = (long)CMTimeGetSeconds(asset.duration);
    NSUInteger hours = floor(durationSeconds / 3600);
    NSUInteger minutes = floor(durationSeconds % 3600 / 60);
    NSUInteger seconds = floor(durationSeconds % 3600 % 60);
    
    [Acell.PlayButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        // 1: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
        // 2: /Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt
        // 3: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
        if (Acell.PlayButton.currentImage == [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"]) {
            [Acell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt"] forState:UIControlStateNormal];
            [self.audioPlayer stop];
        } else {
            [Acell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"] forState:UIControlStateNormal];
            [self.audioPlayer play];
        }
        
    }];
    
    if (Acell.PlayButton.alpha == 0) {
        
        if (self.index == 0) {
            self.index = indexPath;
            self.Autoindex = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        } else {
            DownloadedCell *Icell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:self.index];
            [self.audioPlayer stop];
            [Icell.PlayButton setAlpha:0];
            [Icell.TimeLine setAlpha:0];
            [Icell.TimeLine setValue:0];
            [Icell.TimeLabelOfTimeLine setAlpha:0];
            [Icell.TimeLineLabel setAlpha:0];
            [Icell.TimeView setAlpha:1];
            [Icell.TypeImage setAlpha:1];
            self.index = indexPath;
            self.Autoindex = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        }
        
        [Acell.PlayButton setAlpha:1];
        [Acell.TimeLine setAlpha:1];
        [Acell.TypeImage setAlpha:0];
        [Acell.TimeLabelOfTimeLine setAlpha:1];
        [Acell.TimeLineLabel setAlpha:1];
        [Acell.TimeView setAlpha:0];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.Audiofiles[indexPath.row].absoluteURL error:&error];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:@{
                                                                    MPMediaItemPropertyTitle: [self.Audiofiles[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".m4a" withString:@""],
                                                                    MPMediaItemPropertyPlaybackDuration: [NSNumber numberWithInteger:durationSeconds]
                                                                    }];
        [Acell.TimeLine setMaximumValue:(CGFloat)self.audioPlayer.duration];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
            
            if (hours == 0) {
                [Acell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                Acell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)minutes,(unsigned long)seconds];
                Acell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)((int)(Acell.TimeLine.value)) / 60, (int)((int)(Acell.TimeLine.value)) % 60];
            } else {
                [Acell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                Acell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hours,(unsigned long)minutes,(unsigned long)seconds];
                Acell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)((int)(Acell.TimeLine.value / 3600)),
                                           (int)((int)(Acell.TimeLine.value)) / 60, (int)((int)(Acell.TimeLine.value)) % 60];
            }
        }];
        
        if (error) {
            NSLog(@"i found some errors:%@",error);
        }
        
    } else {
        [Acell.PlayButton setAlpha:0];
        [Acell.TimeLine setAlpha:0];
        [Acell.TimeLine setValue:0];
        [Acell.TimeLabelOfTimeLine setAlpha:0];
        [Acell.TimeLineLabel setAlpha:0];
        [Acell.TimeView setAlpha:1];
        [Acell.TypeImage setAlpha:1];
    }
}

- (void)ShowAudioSheet:(id *)sender event:(id)event {
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.AudioTable];
    
    NSIndexPath *indexPath = [self.AudioTable indexPathForRowAtPoint: currentTouchPosition];
    self.VideoImage = [UIImage imageNamed:[self.Audiofiles[indexPath.row].path stringByReplacingOccurrencesOfString:@"m4a" withString:@"png"]];
    self.seletedindex = indexPath;
    
    MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                             message:nil];
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt
    MDCActionSheetAction *importAction = [MDCActionSheetAction actionWithTitle:@"Import to library" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        NSString *platformString = [UIDeviceHardware platformString];
        
//        if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
//        if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
//        if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
//        if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
        
        if ([platformString containsString:@"iPhone11,2"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"hi" message:@"Sorry but your Device(A12) not support this feature"];
                
                MDCAlertAction *alertAction = [MDCAlertAction actionWithTitle:@"OK" handler:nil];
                [alertController setTitleColor:[UIColor whiteColor]];
                [alertController setMessageColor:[UIColor whiteColor]];
                [alertController setButtonTitleColor:[UIColor whiteColor]];
                [alertController setButtonInkColor:[UIColor colorWithWhite:0.7 alpha:1]];
                [alertController setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [alertController addAction:alertAction];
                
                [self presentViewController:alertController animated:true completion:nil];
            });
            
        } else if ([platformString containsString:@"iPhone11,4"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"hi" message:@"Sorry but your Device(A12) not support this feature"];
                
                MDCAlertAction *alertAction = [MDCAlertAction actionWithTitle:@"OK" handler:nil];
                [alertController setTitleColor:[UIColor whiteColor]];
                [alertController setMessageColor:[UIColor whiteColor]];
                [alertController setButtonTitleColor:[UIColor whiteColor]];
                [alertController setButtonInkColor:[UIColor colorWithWhite:0.7 alpha:1]];
                [alertController setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [alertController addAction:alertAction];
                
                [self presentViewController:alertController animated:true completion:nil];
            });
            
        } else if ([platformString containsString:@"iPhone11,8"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"hi" message:@"Sorry but your Device(A12) not support this feature"];
                
                MDCAlertAction *alertAction = [MDCAlertAction actionWithTitle:@"OK" handler:nil];
                [alertController setTitleColor:[UIColor whiteColor]];
                [alertController setMessageColor:[UIColor whiteColor]];
                [alertController setButtonTitleColor:[UIColor whiteColor]];
                [alertController setButtonInkColor:[UIColor colorWithWhite:0.7 alpha:1]];
                [alertController setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [alertController addAction:alertAction];
                
                [self presentViewController:alertController animated:true completion:nil];
            });
            
        }
        
        self.alertVC = [UIAlertController alertControllerWithTitle:@"import song" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        // Song name
        [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"%@", textField.text);
        }];
        
        // Artist Name
        [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"%@", textField.text);
        }];
        
        // Album Name
        [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            NSLog(@"%@", textField.text);
        }];
        
        // setup text fields
        [self.alertVC.textFields[0] setPlaceholder:@"Song name"];
        [self.alertVC.textFields[0] setText:[self.Audiofiles[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".m4a" withString:@""]];
        [self.alertVC.textFields[1] setPlaceholder:@"Artist name"];
        [self.alertVC.textFields[2] setPlaceholder:@"Album Name"];
        
        UIAlertAction *importAction = [UIAlertAction actionWithTitle:@"import with custom image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *imagePickController = [[UIImagePickerController alloc] init];
            imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickController.navigationItem.title = @"Select Song image";
            imagePickController.delegate = self;
            imagePickController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:imagePickController animated:true completion:nil];
        }];
        
        UIAlertAction *importAction2 = [UIAlertAction actionWithTitle:@"import with video image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [JODebox importSongWithTitle:self.alertVC.textFields[0].text artist:self.alertVC.textFields[1].text image:self.VideoImage albumName:self.alertVC.textFields[2].text trackNumber:[NSNumber numberWithInt:4] duration:[NSNumber numberWithInt:15] year:[NSNumber numberWithInt:2019] path:self.Audiofiles[self.seletedindex.row].path genre:@"YT"];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
        [self.alertVC addAction:importAction];
        [self.alertVC addAction:importAction2];
        [self.alertVC addAction:cancel];
        
        [self presentViewController:self.alertVC animated:true completion:nil];
        
    }];
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_reply_white_24pt
    MDCActionSheetAction *ShareAction = [MDCActionSheetAction actionWithTitle:@"Share" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_reply_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        UIActivityViewController *ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.Audiofiles[indexPath.row]] applicationActivities:nil];
        
         [self presentViewController:ActivityVC animated:true completion:nil];
    }];
    
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_delete_white_24pt
    MDCActionSheetAction *RemoveAction = [MDCActionSheetAction actionWithTitle:@"Remove" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_delete_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtURL:self.Audiofiles[indexPath.row].absoluteURL error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:[self.Audiofiles[indexPath.row].path stringByReplacingOccurrencesOfString:@".m4a" withString:@".png"] error:&error];
        [self SetupDocumentsDirectoryPath];
    }];
    
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_clear_white_24pt
    MDCActionSheetAction *Cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_clear_white_24pt"] handler:nil];
    
    
    [actionSheet addAction:importAction];
    [actionSheet addAction:ShareAction];
    [actionSheet addAction:RemoveAction];
    [actionSheet addAction:Cancel];
    actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
    actionSheet.actionTextColor = [UIColor whiteColor];
    actionSheet.actionTintColor = [UIColor whiteColor];
    [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
    
    [self presentViewController:actionSheet animated:true completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 290;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    if (self.islastRow == true) {
        DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.AudioTable.indexPathsForVisibleRows.lastObject.row inSection:0]];
        [Acell.PlayButton setAlpha:0];
        [Acell.TimeView setAlpha:1];
        [Acell.TimeLine setAlpha:0];
        [Acell.TimeLineLabel setAlpha:0];
        [Acell.TimeLabelOfTimeLine setAlpha:0];
    } else {
        DownloadedCell *Acell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:self.index];
        [Acell.PlayButton setAlpha:0];
        [Acell.TimeView setAlpha:1];
        [Acell.TimeLine setAlpha:0];
        [Acell.TimeLineLabel setAlpha:0];
        [Acell.TimeLabelOfTimeLine setAlpha:0];
        [self nextAutoTrack];
    }
}

- (void)nextAutoTrack {
    NSLog(@"%ld", (long)self.Autoindex.row);
    DownloadedCell *AutoCell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:self.Autoindex];
    AVAsset *asset = [AVAsset assetWithURL:self.Audiofiles[self.Autoindex.row].absoluteURL];
    NSUInteger durationSeconds = (long)CMTimeGetSeconds(asset.duration);
    NSUInteger hours = floor(durationSeconds / 3600);
    NSUInteger minutes = floor(durationSeconds % 3600 / 60);
    NSUInteger seconds = floor(durationSeconds % 3600 % 60);
    
    if (self.Autoindex.row == self.AudioTable.indexPathsForVisibleRows.lastObject.row) {
        NSLog(@"last");
        self.islastRow = true;
        self.Autoindex = [NSIndexPath indexPathForRow:self.AudioTable.indexPathsForVisibleRows.lastObject.row inSection:0];
        DownloadedCell *lastCell = (DownloadedCell *)[self.AudioTable cellForRowAtIndexPath:self.Autoindex];
        [lastCell.PlayButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            
            // 1: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
            // 2: /Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt
            // 3: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
            if (lastCell.PlayButton.currentImage == [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"]) {
                [lastCell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt"] forState:UIControlStateNormal];
                [self.audioPlayer stop];
            } else {
                [lastCell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"] forState:UIControlStateNormal];
                [self.audioPlayer play];
            }
            
        }];
        [lastCell.PlayButton setAlpha:1];
        [lastCell.TimeLine setAlpha:1];
        [lastCell.TypeImage setAlpha:0];
        [lastCell.TimeLabelOfTimeLine setAlpha:1];
        [lastCell.TimeLineLabel setAlpha:1];
        [lastCell.TimeView setAlpha:0];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.Audiofiles[self.Autoindex.row].absoluteURL error:&error];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:@{
                                                                    MPMediaItemPropertyTitle: [self.Audiofiles[self.Autoindex.row].lastPathComponent stringByReplacingOccurrencesOfString:@".m4a" withString:@""],
                                                                    MPMediaItemPropertyPlaybackDuration: [NSNumber numberWithInteger:durationSeconds],
                                                                    }];
        [lastCell.TimeLine setMaximumValue:(CGFloat)self.audioPlayer.duration];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
            
            if (hours == 0) {
                [lastCell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                lastCell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)minutes,(unsigned long)seconds];
                lastCell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)((int)(lastCell.TimeLine.value)) / 60, (int)((int)(lastCell.TimeLine.value)) % 60];
            } else {
                [lastCell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                lastCell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hours,(unsigned long)minutes,(unsigned long)seconds];
                lastCell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)((int)(lastCell.TimeLine.value / 3600)),
                                               (int)((int)(lastCell.TimeLine.value)) / 60, (int)((int)(lastCell.TimeLine.value)) % 60];
            }
        }];
        
        if (error) {
            NSLog(@"i found some errors:%@",error);
        }
        //self.Autoindex = [NSIndexPath indexPathForRow:0 inSection:0];
        //self.index = [NSIndexPath indexPathForRow:0 inSection:0];
    } else {
        self.islastRow = false;
        self.index = self.Autoindex;
        [AutoCell.PlayButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
            
            // 1: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
            // 2: /Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt
            // 3: /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
            if (AutoCell.PlayButton.currentImage == [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"]) {
                [AutoCell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_play_arrow_white_48pt"] forState:UIControlStateNormal];
                [self.audioPlayer stop];
            } else {
                [AutoCell.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"] forState:UIControlStateNormal];
                [self.audioPlayer play];
            }
            
        }];
        [AutoCell.PlayButton setAlpha:1];
        [AutoCell.TimeLine setAlpha:1];
        [AutoCell.TypeImage setAlpha:0];
        [AutoCell.TimeLabelOfTimeLine setAlpha:1];
        [AutoCell.TimeLineLabel setAlpha:1];
        [AutoCell.TimeView setAlpha:0];
        NSError *error;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.Audiofiles[self.Autoindex.row].absoluteURL error:&error];
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:@{
                                                                    MPMediaItemPropertyTitle: [self.Audiofiles[self.Autoindex.row].lastPathComponent stringByReplacingOccurrencesOfString:@".m4a" withString:@""],
                                                                    MPMediaItemPropertyPlaybackDuration: [NSNumber numberWithInteger:durationSeconds],
                                                                    }];
        [AutoCell.TimeLine setMaximumValue:(CGFloat)self.audioPlayer.duration];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:true block:^(NSTimer * _Nonnull timer) {
            
            if (hours == 0) {
                [AutoCell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                AutoCell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)minutes,(unsigned long)seconds];
                AutoCell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)((int)(AutoCell.TimeLine.value)) / 60, (int)((int)(AutoCell.TimeLine.value)) % 60];
            } else {
                [AutoCell.TimeLine setValue:(CGFloat)self.audioPlayer.currentTime animated:true];
                AutoCell.TimeLabelOfTimeLine.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hours,(unsigned long)minutes,(unsigned long)seconds];
                AutoCell.TimeLineLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)((int)(AutoCell.TimeLine.value / 3600)),
                                            (int)((int)(AutoCell.TimeLine.value)) / 60, (int)((int)(AutoCell.TimeLine.value)) % 60];
            }
        }];
        
        if (error) {
            NSLog(@"i found some errors:%@",error);
        }
    }
        self.Autoindex = [NSIndexPath indexPathForRow:self.Autoindex.row + 1 inSection:0];
    NSLog(@"%ld", (long)self.Autoindex.row);
}

- (void)TimeLineHandler:(MDCSlider *)sender {
    
    if (!self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
        self.audioPlayer.currentTime = (NSTimeInterval)sender.value;
    } else {
        [self.audioPlayer stop];
        self.audioPlayer.currentTime = (NSTimeInterval)sender.value;
        [self.audioPlayer play];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController dismissViewControllerAnimated:true completion:nil];
    UIImage *SongImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [JODebox importSongWithTitle:self.alertVC.textFields[0].text artist:self.alertVC.textFields[1].text image:SongImage albumName:self.alertVC.textFields[2].text trackNumber:[NSNumber numberWithInt:4] duration:[NSNumber numberWithInt:15] year:[NSNumber numberWithInt:2019] path:self.Audiofiles[self.seletedindex.row].path genre:@"YT"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController dismissViewControllerAnimated:true completion:nil];
    
}

@end
