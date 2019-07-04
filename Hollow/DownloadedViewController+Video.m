//
//  DownloadedViewController+Video.m
//  ColorPickerTest
//
//  Created by BandarHelal on 06/06/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import "DownloadedViewController+Video.h"


@interface DownloadedViewController_Video () <UITableViewDelegate, UITableViewDataSource>
@end


@implementation DownloadedViewController_Video

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:@"282828"]];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                    
                                                                    };
    [self SetupViewController];
    [self SetupDocumentsDirectoryPath];
    [self SetupRemoteTransportControls];
    //[[BHDownloadManager new] HUDProgress:[[[UIApplication sharedApplication] delegate] window] WithHUDProgress:[NSProgress progressWithTotalUnitCount:100]];
}

- (void)SetupRemoteTransportControls {
    
    self.commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    [self.commandCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        if (self.VideoPlayer.rate == 0.0) {
            [self.VideoPlayer play];
            return MPRemoteCommandHandlerStatusSuccess;
        }
        return MPRemoteCommandHandlerStatusCommandFailed;
    }];
    
    [self.commandCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        
        if (self.VideoPlayer.rate == 1.0) {
            [self.VideoPlayer pause];
            return MPRemoteCommandHandlerStatusSuccess;
        }
        return MPRemoteCommandHandlerStatusCommandFailed;
    }];
    
    [self.commandCenter.playCommand setEnabled:true];
    [self.commandCenter.pauseCommand setEnabled:true];
    
    
}

- (void)SetupViewController {
    
    self.view.backgroundColor = [UIColor colorFromHexString:@"282828"];
    self.table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.table setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.table setBackgroundColor: [UIColor colorFromHexString:@"282828"]];
    [self.table setOpaque:NO];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    [self.view sendSubviewToBack:self.table];
    [self.table registerClass:DownloadedCell.class forCellReuseIdentifier:@"Vcell"];
    
    [self.table.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.table.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.table.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.table.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
}

- (void)SetupDocumentsDirectoryPath {
    
    [FCFileManager createDirectoriesForPath:@"BH"];
    
    NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    NSURL *documentsURL = [NSURL fileURLWithPath:documentsDirectoryPath];
    
    do {
        NSError *error;
        self.files = [NSFileManager.defaultManager contentsOfDirectoryAtURL:[documentsURL URLByAppendingPathComponent:@"BH"] includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
        if (error) {
            NSLog(@"i found some errors:%@", error);
        }
    } while (nil);
    
    
    NSLog(@"files count = %lu", self.files.count);
    NSLog(@"%@",documentsURL);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.table reloadData];
    });
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DownloadedCell *cell = (DownloadedCell *)[self.table dequeueReusableCellWithIdentifier:@"Vcell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.MoreButton addTarget:self action:@selector(ShowSheet:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    AVAsset *asset = [AVAsset assetWithURL:self.files[indexPath.row].absoluteURL];
    NSUInteger durationSeconds = (long)CMTimeGetSeconds(asset.duration);
    NSUInteger hours = floor(durationSeconds / 3600);
    NSUInteger minutes = floor(durationSeconds % 3600 / 60);
    NSUInteger seconds = floor(durationSeconds % 3600 % 60);
    
    
    if ([self.files[indexPath.row].lastPathComponent containsString:@".png"]) {
        
        [self.files removeObjectAtIndex:indexPath.row];
        [self.table reloadData];
        
    } else if ([self.files[indexPath.row].lastPathComponent containsString:@".jpg"]) {
        
        [self.files removeObjectAtIndex:indexPath.row];
        [self.table reloadData];
        
    } else if ([self.files[indexPath.row].lastPathComponent containsString:@".m4a"]) {
        
        [self.files removeObjectAtIndex:indexPath.row];
        [self.table reloadData];
        
    } else {
        
        if (self.files[indexPath.row].lastPathComponent) {
            
            if (hours == 0) {
                cell.VideoTitle.text = [self.files[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
                cell.VideoImage.image = [UIImage imageNamed:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@"mp4" withString:@"png"]];
                cell.TypeImage.image = [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_video_library_white_24pt"];
                //cell.ChannelImage.image = [UIImage imageNamed:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@".mp4" withString:@"C.png"]];
                cell.TimeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)minutes,(unsigned long)seconds];
            } else {
                cell.VideoTitle.text = [self.files[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".mp4" withString:@""];
                cell.VideoImage.image = [UIImage imageNamed:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@"mp4" withString:@"png"]];
                cell.TypeImage.image = [UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_video_library_white_24pt"];
                //cell.ChannelImage.image = [UIImage imageNamed:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@".mp4" withString:@"C.png"]];
                cell.TimeLabel.text = [NSString stringWithFormat:@"%02lu:%02lu:%02lu",(unsigned long)hours,(unsigned long)minutes,(unsigned long)seconds];
            }
            
            return cell;
        }
    }
    return UITableViewCell.new;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AVPlayerItem *video = [AVPlayerItem playerItemWithURL:self.files[indexPath.row].absoluteURL];
    self.VideoPlayer = [AVPlayer playerWithPlayerItem:video];
    AVPlayerViewController *videoViewController = [[AVPlayerViewController alloc] init];
    videoViewController.player = self.VideoPlayer;
    
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:@{
                                                                MPMediaItemPropertyTitle: [self.files[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".mp4" withString:@""]
                                                                }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:videoViewController animated:true completion:^{
        [self.VideoPlayer play];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 290;
}


- (void)ShowSheet:(id *)sender event:(id)event {
    
    
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:self.table];
    
    NSIndexPath *indexPath = [self.table indexPathForRowAtPoint: currentTouchPosition];
    
    MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                             message:nil];
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt
    MDCActionSheetAction *importAction = [MDCActionSheetAction actionWithTitle:@"Import to library" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        
        
        MDCActionSheetController *actionSheet2 = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                                 message:nil];
        
        MDCActionSheetAction *AppleMusic = [MDCActionSheetAction actionWithTitle:@"Apple Music" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
            
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
            
            self.alertVC = [UIAlertController alertControllerWithTitle:@"import video to music" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            // Song name
            [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"%@", textField.text);
            }];
            
            // Artist Name
            [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"%@", textField.text);
            }];
            
            // setup text fields
            [self.alertVC.textFields[0] setPlaceholder:@"Video name"];
            [self.alertVC.textFields[0] setText:[self.files[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@".mp4" withString:@""]];
            [self.alertVC.textFields[1] setPlaceholder:@"Artist name"];
            //[self.alertVC.textFields[2] setPlaceholder:@"Album Name"];
            
            UIAlertAction *importAction = [UIAlertAction actionWithTitle:@"import" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [JODebox importMusicVideoWithTitle:self.alertVC.textFields[0].text artist:self.alertVC.textFields[1].text image:[UIImage imageNamed:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@"m4a" withString:@"png"]] duration:[NSNumber numberWithInteger:15] year:[NSNumber numberWithInteger:2019] path:self.files[indexPath.row].path genre:@"YT"];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
            
            [self.alertVC addAction:importAction];
            [self.alertVC addAction:cancel];
            
            [self presentViewController:self.alertVC animated:true completion:nil];
            
        }];
        
        MDCActionSheetAction *CameraRoll = [MDCActionSheetAction actionWithTitle:@"Camera Roll" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
            
            __block PHObjectPlaceholder *placeholder;
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:self.files[indexPath.row].absoluteURL];
                placeholder = [createAssetRequest placeholderForCreatedAsset];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                
                if (error != nil) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"hi" message:@"Error save video"];
                        
                        MDCAlertAction *alertAction = [MDCAlertAction actionWithTitle:@"OK" handler:nil];
                        [alertController setTitleColor:[UIColor whiteColor]];
                        [alertController setMessageColor:[UIColor whiteColor]];
                        [alertController setButtonTitleColor:[UIColor whiteColor]];
                        [alertController setButtonInkColor:[UIColor colorWithWhite:0.7 alpha:1]];
                        [alertController setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                        [alertController addAction:alertAction];
                        
                        [self presentViewController:alertController animated:true completion:nil];
                    });
                } else {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MDCAlertController *alertController = [MDCAlertController alertControllerWithTitle:@"hi" message:@"Success save video"];
                        
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
            }];
        }];
        
        [actionSheet2 addAction:AppleMusic];
        [actionSheet2 addAction:CameraRoll];
        actionSheet2.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
        actionSheet2.actionTextColor = [UIColor whiteColor];
        actionSheet2.actionTintColor = [UIColor whiteColor];
        [actionSheet2 setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
        
        [self presentViewController:actionSheet2 animated:true completion:nil];
        
        
    }];
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_reply_white_24pt
    MDCActionSheetAction *ShareAction = [MDCActionSheetAction actionWithTitle:@"Share" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_reply_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        UIActivityViewController *ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:@[self.files[indexPath.row]] applicationActivities:nil];
        
        [self presentViewController:ActivityVC animated:true completion:nil];
    }];
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_delete_white_24pt
    MDCActionSheetAction *RemoveAction = [MDCActionSheetAction actionWithTitle:@"Remove" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_delete_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtURL:self.files[indexPath.row].absoluteURL error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:[self.files[indexPath.row].path stringByReplacingOccurrencesOfString:@".mp4" withString:@".png"] error:&error];
        [self SetupDocumentsDirectoryPath];
    }];
    
    MDCActionSheetAction *ConvertAction = [MDCActionSheetAction actionWithTitle:@"Convert to Audio" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_audiotrack_white_24pt.png"] handler:^(MDCActionSheetAction * _Nonnull action) {
        NSString *FinalTitle = [NSString stringWithFormat:@"%@", [self.files[indexPath.row].lastPathComponent stringByReplacingOccurrencesOfString:@"mp4" withString:@"m4a"]];
        [[BHUtilities new] ConvertVideoToAudio:self.files[indexPath.row] VideoTitle:FinalTitle];
    }];
    
    
    // /Library/Application Support/BH/Ressources.bundle/baseline_clear_white_24pt
    MDCActionSheetAction *Cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_clear_white_24pt"] handler:nil];
    
    
    [actionSheet addAction:importAction];
    [actionSheet addAction:ShareAction];
    [actionSheet addAction:RemoveAction];
    [actionSheet addAction:ConvertAction];
    [actionSheet addAction:Cancel];
    actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
    actionSheet.actionTextColor = [UIColor whiteColor];
    actionSheet.actionTintColor = [UIColor whiteColor];
    [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
    
    [self presentViewController:actionSheet animated:true completion:nil];
}

@end
