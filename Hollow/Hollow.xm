#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MaterialActionSheet.h"
#import "XCDYouTubeKit.h"
#import "SJYouTubeIDParser.h"
#import "BHDownloadManager.h"
#import <CoreGraphics/CoreGraphics.h>

%config(generator=internal)



@interface YTHeaderContentComboViewController : UIViewController
@end

@interface YTHeaderContentComboViewController (Hollow)
@end

@interface YTPlayerViewController : UIViewController
@property(readonly, nonatomic) NSString *contentVideoID;
@property(readonly, nonatomic) NSString *currentVideoID;
@end

//NSArray<NSString *>*APIs;

%hook YTPlayerViewController
- (void)viewDidLoad {
    %orig;
    //APIs = [NSArray arrayWithObjects:@"AIzaSyCzMbi1OfMouCHd_QH9dk9ZTcghUs0U0EE",@"AIzaSyBHOGugZaIhuhgRyR0gPGuuJLsHSulZwkw", @"AIzaSyAA8twzpX8HaHbVOEzRRp2buRR5Bo1-OGg", @"AIzaSyDooGfTk-XgVQ0NKvkG9IwsECmTpkwve6o", @"AIzaSyB0Yhz9vy0cJpOBaQ7tXzZML4vgZUJqh50", @"AIzaSyBKU1Afi5fOx6B_NQTXghrhUIIspXarKMk", @"AIzaSyBEP2TKpauQKijVOwu8ZGq2-0lRM3P_ozk", @"AIzaSyD6A-Fdzex-ylljNjdRR-O7dII2e6_HSsc", @"AIzaSyBOvqvMKhElRlxG2KEUW9to0BoQhzvyrRM", @"AIzaSyDIbZm-br3AN06Uwx1xqiAUPaibptRyxVY", nil];
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithBlock:^(id weakSender) {
        
        [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:self.currentVideoID completionHandler:^(XCDYouTubeVideo * _Nullable video, NSError * _Nullable error) {
            
            NSDictionary *streamURL = video.streamURLs;
            NSString *videoTitle = video.title;
            
            if (streamURL[@(XCDYouTubeVideoQualityHD1080)] != nil) {
                
                MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:video.title message:@"The video supports these Qualitys 👇"];
                MDCActionSheetAction *DownloadedAction = [MDCActionSheetAction actionWithTitle:@"HD 1080" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadVideoWithURL:streamURL[@(XCDYouTubeVideoQualityHD1080)] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                }];
                
                MDCActionSheetAction *AudioAction = [MDCActionSheetAction actionWithTitle:@"Audio" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadAudioFromVideoURL:streamURL[@(XCDYouTubeVideoQualityHD1080)] WithFileName:videoTitle inFolderName:@"BH"];
                    
                }];
                
                MDCActionSheetAction *cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:nil handler:nil];
                
                [actionSheet addAction:DownloadedAction];
                [actionSheet addAction:AudioAction];
                [actionSheet addAction:cancel];
                actionSheet.titleTextColor = [UIColor whiteColor];
                actionSheet.messageTextColor = [UIColor whiteColor];
                actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
                actionSheet.actionTextColor = [UIColor whiteColor];
                actionSheet.actionTintColor = [UIColor whiteColor];
                [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [self presentViewController:actionSheet animated:true completion:nil];
                
            } else if (streamURL[@(XCDYouTubeVideoQualityHD720)] != nil) {
                
                MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:video.title message:@"The video supports these Qualitys 👇"];
                MDCActionSheetAction *DownloadedAction = [MDCActionSheetAction actionWithTitle:@"HD 720" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadVideoWithURL:streamURL[@(XCDYouTubeVideoQualityHD720)] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    
                }];
                
                MDCActionSheetAction *AudioAction = [MDCActionSheetAction actionWithTitle:@"Audio" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadAudioFromVideoURL:streamURL[@(XCDYouTubeVideoQualityHD720)] WithFileName:videoTitle inFolderName:@"BH"];
                    
                    
                }];
                
                MDCActionSheetAction *cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:nil handler:nil];
                
                [actionSheet addAction:DownloadedAction];
                [actionSheet addAction:AudioAction];
                [actionSheet addAction:cancel];
                actionSheet.titleTextColor = [UIColor whiteColor];
                actionSheet.messageTextColor = [UIColor whiteColor];
                actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
                actionSheet.actionTextColor = [UIColor whiteColor];
                actionSheet.actionTintColor = [UIColor whiteColor];
                [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [self presentViewController:actionSheet animated:true completion:nil];
                
            } else if (streamURL[@(XCDYouTubeVideoQualityMedium360)] != nil) {
                
                MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:video.title message:@"The video supports these Qualitys 👇"];
                MDCActionSheetAction *DownloadedAction = [MDCActionSheetAction actionWithTitle:@"Medium 360" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadVideoWithURL:streamURL[@(XCDYouTubeVideoQualityMedium360)] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    
                }];
                
                MDCActionSheetAction *AudioAction = [MDCActionSheetAction actionWithTitle:@"Audio" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadAudioFromVideoURL:streamURL[@(XCDYouTubeVideoQualityMedium360)] WithFileName:videoTitle inFolderName:@"BH"];
                    
                }];
                
                MDCActionSheetAction *cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:nil handler:nil];
                
                [actionSheet addAction:DownloadedAction];
                [actionSheet addAction:AudioAction];
                [actionSheet addAction:cancel];
                actionSheet.titleTextColor = [UIColor whiteColor];
                actionSheet.messageTextColor = [UIColor whiteColor];
                actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
                actionSheet.actionTextColor = [UIColor whiteColor];
                actionSheet.actionTintColor = [UIColor whiteColor];
                [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [self presentViewController:actionSheet animated:true completion:nil];
                
            } else if (streamURL[@(XCDYouTubeVideoQualitySmall240)] != nil) {
                
                MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:video.title message:@"The video supports these Qualitys 👇"];
                MDCActionSheetAction *DownloadedAction = [MDCActionSheetAction actionWithTitle:@"Small 240" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    NSLog(@"%@", streamURL[@(XCDYouTubeVideoQualitySmall240)]);
                }];
                
                MDCActionSheetAction *AudioAction = [MDCActionSheetAction actionWithTitle:@"Audio" image:nil handler:^(MDCActionSheetAction * _Nonnull action) {
                    
                    [[BHDownloadManager new] DownloadThumbnailWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://img.youtube.com/vi/%@/maxresdefault.jpg",self.currentVideoID]] WithFileName:videoTitle inFolderName:@"BH"];
                    [[BHDownloadManager new] DownloadAudioFromVideoURL:streamURL[@(XCDYouTubeVideoQualitySmall240)] WithFileName:videoTitle inFolderName:@"BH"];
                    
                }];
                
                MDCActionSheetAction *cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:nil handler:nil];
                
                [actionSheet addAction:DownloadedAction];
                [actionSheet addAction:AudioAction];
                [actionSheet addAction:cancel];
                actionSheet.titleTextColor = [UIColor whiteColor];
                actionSheet.messageTextColor = [UIColor whiteColor];
                actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
                actionSheet.actionTextColor = [UIColor whiteColor];
                actionSheet.actionTintColor = [UIColor whiteColor];
                [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
                [self presentViewController:actionSheet animated:true completion:nil];
                
            }
        }];
        
//        SJYouTubeIDParser *youtubeParser = [SJYouTubeIDParser defaultParser];
//        youtubeParser.APIKey = APIs[arc4random() % APIs.count];
//        youtubeParser.thumbnailQuailty = SJYouTubeIDParserThumbnailQuailtyMaxres;
//        [youtubeParser getVideoInfoFromURL:[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@",self.currentVideoID] completionHandler:^(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long likeCount, long long dislikeCount, NSDate *uploaded, NSString *uploader, NSError *error) {
//
//            NSLog(@"%@", thumbnailURL);
//        }];
        
        
    }];
    [self.view addGestureRecognizer:tap];
    
}

%end

%hook YTHeaderContentComboViewController

- (void)didPressAccountPanelButton:(id)arg1 {
    
    MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                             message:nil];
    MDCActionSheetAction *importAction = [MDCActionSheetAction actionWithTitle:@"Open Downloaded library" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        RootViewController *vc = [[RootViewController alloc] init];
        UINavigationController *NavVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [NavVC.navigationBar setTranslucent:false];
        [NavVC.navigationBar setShadowImage:[[UIImage alloc] init]];
        [NavVC.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
            [self presentViewController:NavVC animated:true completion:nil];
        
        //[self presentViewController:NavVC animated:true completion:nil];
        
    }];
    
    MDCActionSheetAction *ShareAction = [MDCActionSheetAction actionWithTitle:@"YouTube setting" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        %orig;
    }];
    
    MDCActionSheetAction *Cancel = [MDCActionSheetAction actionWithTitle:@"Cancel" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_clear_white_24pt"] handler:nil];
    
    
    [actionSheet addAction:importAction];
    [actionSheet addAction:ShareAction];
    [actionSheet addAction:Cancel];
    actionSheet.inkColor = [UIColor colorWithWhite:0.6 alpha:1];
    actionSheet.actionTextColor = [UIColor whiteColor];
    actionSheet.actionTintColor = [UIColor whiteColor];
    [actionSheet setBackgroundColor:[UIColor colorFromHexString:@"282828"]];
    
    [self presentViewController:actionSheet animated:true completion:nil];
    
}

%end


%hook YTAppDelegate

- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {
    do {
        //[NEHTTPEye setEnabled:YES];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:true error:nil];
    } while (nil);
    return %orig;
}

%end

%hook YTSingleVideoController
- (_Bool)isCurrentlyBackgroundable {
    return YES;
}
%end

%hook YTVASTAd
- (_Bool)isSkippable {
    return YES;
}

- (_Bool)_skippable {
    return YES;
}

-(bool)isForecastingAd {
    return NO;
}

%end

%hook YTVideoQualitySwitchController

- (_Bool)canSelectFormat:(id)arg1 {
    return YES;
}

- (_Bool)_qualitySwitchAvailable {
    return YES;
}
- (_Bool)_qualitySwitchEnabled {
    return YES;
}

%end

%hook YTIPlayabilityStatus
- (bool)isPlayableInBackground {
    return true;
}
%end

%hook YTIPlayerResponse
- (bool)isMonetized {
    return false;
}
- (_Bool)adsAllowReuse {
    return NO;
}
%end

%hook YTPromotedVideoCellController
- (bool)shouldShowPromotedItems {
    return false;
}
%end

%hook YTIPlayabilityStatus
- (bool)isAgeCheckRequired {
    return false;
}
%end

%hook YTIPlayabilityStatus
- (bool)isPlayable {
    return true;
}
%end

%hook YTPlayerRequestFactory
- (bool)adultContentConfirmed {
    return true;
}
%end

%hook YTSettings
- (bool)enableMDXAutoCasting {
    return false;
}
%end

%hook YTSingleVideoMediaData
- (bool)isPlayableInBackground {
    return true;
}
%end

%hook YTReachability
- (BOOL)isOnWiFi {
    return true;
}
%end

%hook YTSettings
- (void)setStreamHDOnWiFiOnly:(BOOL)arg1 {
    arg1 = false;
    %orig;
}
%end

%hook YTSettings
- (BOOL)streamHDOnWiFiOnly {
    return false;
}
%end

%hook YTSettingsViewController
- (BOOL)onStreamHDOnWiFiOnly:(BOOL)arg1 {
    arg1 = false;
    return false;
    return %orig;
}
%end

%hook YTUserDefaults
- (BOOL)streamHDOnWiFiOnly {
    return false;
}
%end
