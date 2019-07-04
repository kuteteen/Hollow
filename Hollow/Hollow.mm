#line 1 "/Users/mac/Desktop/Hollow/JB/Hollow/Hollow.xm"
#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MaterialActionSheet.h"
#import "XCDYouTubeKit.h"
#import "SJYouTubeIDParser.h"
#import "BHDownloadManager.h"
#import <CoreGraphics/CoreGraphics.h>





@interface YTHeaderContentComboViewController : UIViewController
@end

@interface YTHeaderContentComboViewController (Hollow)
@end

@interface YTPlayerViewController : UIViewController
@property(readonly, nonatomic) NSString *contentVideoID;
@property(readonly, nonatomic) NSString *currentVideoID;
@end




#include <objc/message.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__attribute__((unused)) static void _logos_register_hook$(Class _class, SEL _cmd, IMP _new, IMP *_old) {
unsigned int _count, _i;
Class _searchedClass = _class;
Method *_methods;
while (_searchedClass) {
_methods = class_copyMethodList(_searchedClass, &_count);
for (_i = 0; _i < _count; _i++) {
if (method_getName(_methods[_i]) == _cmd) {
if (_class == _searchedClass) {
*_old = method_getImplementation(_methods[_i]);
*_old = method_setImplementation(_methods[_i], _new);
} else {
class_addMethod(_class, _cmd, _new, method_getTypeEncoding(_methods[_i]));
}
free(_methods);
return;
}
}
free(_methods);
_searchedClass = class_getSuperclass(_searchedClass);
}
}
@class YTSettingsViewController; @class YTIPlayabilityStatus; @class YTVASTAd; @class YTPlayerViewController; @class YTHeaderContentComboViewController; @class YTPlayerRequestFactory; @class YTReachability; @class YTUserDefaults; @class YTAppDelegate; @class YTPromotedVideoCellController; @class YTSingleVideoController; @class YTIPlayerResponse; @class YTVideoQualitySwitchController; @class YTSingleVideoMediaData; @class YTSettings; 
static Class _logos_superclass$_ungrouped$YTPlayerViewController; static void (*_logos_orig$_ungrouped$YTPlayerViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL YTPlayerViewController* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTHeaderContentComboViewController; static void (*_logos_orig$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$)(_LOGOS_SELF_TYPE_NORMAL YTHeaderContentComboViewController* _LOGOS_SELF_CONST, SEL, id);static Class _logos_superclass$_ungrouped$YTAppDelegate; static _Bool (*_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST, SEL, id, id);static Class _logos_superclass$_ungrouped$YTSingleVideoController; static _Bool (*_logos_orig$_ungrouped$YTSingleVideoController$isCurrentlyBackgroundable)(_LOGOS_SELF_TYPE_NORMAL YTSingleVideoController* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTVASTAd; static _Bool (*_logos_orig$_ungrouped$YTVASTAd$isSkippable)(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST, SEL);static _Bool (*_logos_orig$_ungrouped$YTVASTAd$_skippable)(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST, SEL);static bool (*_logos_orig$_ungrouped$YTVASTAd$isForecastingAd)(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTVideoQualitySwitchController; static _Bool (*_logos_orig$_ungrouped$YTVideoQualitySwitchController$canSelectFormat$)(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST, SEL, id);static _Bool (*_logos_orig$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchAvailable)(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST, SEL);static _Bool (*_logos_orig$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchEnabled)(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTIPlayabilityStatus; static bool (*_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground)(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST, SEL);static bool (*_logos_orig$_ungrouped$YTIPlayabilityStatus$isAgeCheckRequired)(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST, SEL);static bool (*_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayable)(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTIPlayerResponse; static bool (*_logos_orig$_ungrouped$YTIPlayerResponse$isMonetized)(_LOGOS_SELF_TYPE_NORMAL YTIPlayerResponse* _LOGOS_SELF_CONST, SEL);static _Bool (*_logos_orig$_ungrouped$YTIPlayerResponse$adsAllowReuse)(_LOGOS_SELF_TYPE_NORMAL YTIPlayerResponse* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTPromotedVideoCellController; static bool (*_logos_orig$_ungrouped$YTPromotedVideoCellController$shouldShowPromotedItems)(_LOGOS_SELF_TYPE_NORMAL YTPromotedVideoCellController* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTPlayerRequestFactory; static bool (*_logos_orig$_ungrouped$YTPlayerRequestFactory$adultContentConfirmed)(_LOGOS_SELF_TYPE_NORMAL YTPlayerRequestFactory* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTSettings; static bool (*_logos_orig$_ungrouped$YTSettings$enableMDXAutoCasting)(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST, SEL);static void (*_logos_orig$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$)(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST, SEL, BOOL);static BOOL (*_logos_orig$_ungrouped$YTSettings$streamHDOnWiFiOnly)(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTSingleVideoMediaData; static bool (*_logos_orig$_ungrouped$YTSingleVideoMediaData$isPlayableInBackground)(_LOGOS_SELF_TYPE_NORMAL YTSingleVideoMediaData* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTReachability; static BOOL (*_logos_orig$_ungrouped$YTReachability$isOnWiFi)(_LOGOS_SELF_TYPE_NORMAL YTReachability* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTSettingsViewController; static BOOL (*_logos_orig$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$)(_LOGOS_SELF_TYPE_NORMAL YTSettingsViewController* _LOGOS_SELF_CONST, SEL, BOOL);static Class _logos_superclass$_ungrouped$YTUserDefaults; static BOOL (*_logos_orig$_ungrouped$YTUserDefaults$streamHDOnWiFiOnly)(_LOGOS_SELF_TYPE_NORMAL YTUserDefaults* _LOGOS_SELF_CONST, SEL);

#line 26 "/Users/mac/Desktop/Hollow/JB/Hollow/Hollow.xm"

static void _logos_method$_ungrouped$YTPlayerViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL YTPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    (_logos_orig$_ungrouped$YTPlayerViewController$viewDidLoad ? _logos_orig$_ungrouped$YTPlayerViewController$viewDidLoad : (__typeof__(_logos_orig$_ungrouped$YTPlayerViewController$viewDidLoad))class_getMethodImplementation(_logos_superclass$_ungrouped$YTPlayerViewController, @selector(viewDidLoad)))(self, _cmd);
    
    
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
        







        
        
    }];
    
    [self.view addGestureRecognizer:tap];
    
}





static void _logos_method$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$(_LOGOS_SELF_TYPE_NORMAL YTHeaderContentComboViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    
    MDCActionSheetController *actionSheet = [MDCActionSheetController actionSheetControllerWithTitle:nil
                                                                                             message:nil];
    MDCActionSheetAction *importAction = [MDCActionSheetAction actionWithTitle:@"Open Downloaded library" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        
        RootViewController *vc = [[RootViewController alloc] init];
        UINavigationController *NavVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [NavVC.navigationBar setTranslucent:false];
        [NavVC.navigationBar setShadowImage:[[UIImage alloc] init]];
        [NavVC.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
            [self presentViewController:NavVC animated:true completion:nil];
        
        
        
    }];
    
    MDCActionSheetAction *ShareAction = [MDCActionSheetAction actionWithTitle:@"YouTube setting" image:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_folder_white_24pt"] handler:^(MDCActionSheetAction * _Nonnull action) {
        (_logos_orig$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$ ? _logos_orig$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$ : (__typeof__(_logos_orig$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$))class_getMethodImplementation(_logos_superclass$_ungrouped$YTHeaderContentComboViewController, @selector(didPressAccountPanelButton:)))(self, _cmd, arg1);
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






static _Bool _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2) {
    do {
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:true error:nil];
    } while (nil);
    return (_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$ ? _logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$ : (__typeof__(_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$))class_getMethodImplementation(_logos_superclass$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:)))(self, _cmd, arg1, arg2);
}




static _Bool _logos_method$_ungrouped$YTSingleVideoController$isCurrentlyBackgroundable(_LOGOS_SELF_TYPE_NORMAL YTSingleVideoController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}



static _Bool _logos_method$_ungrouped$YTVASTAd$isSkippable(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}

static _Bool _logos_method$_ungrouped$YTVASTAd$_skippable(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}

static bool _logos_method$_ungrouped$YTVASTAd$isForecastingAd(_LOGOS_SELF_TYPE_NORMAL YTVASTAd* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return NO;
}





static _Bool _logos_method$_ungrouped$YTVideoQualitySwitchController$canSelectFormat$(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    return YES;
}

static _Bool _logos_method$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchAvailable(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}
static _Bool _logos_method$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchEnabled(_LOGOS_SELF_TYPE_NORMAL YTVideoQualitySwitchController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return YES;
}




static bool _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return true;
}



static bool _logos_method$_ungrouped$YTIPlayerResponse$isMonetized(_LOGOS_SELF_TYPE_NORMAL YTIPlayerResponse* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}
static _Bool _logos_method$_ungrouped$YTIPlayerResponse$adsAllowReuse(_LOGOS_SELF_TYPE_NORMAL YTIPlayerResponse* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return NO;
}



static bool _logos_method$_ungrouped$YTPromotedVideoCellController$shouldShowPromotedItems(_LOGOS_SELF_TYPE_NORMAL YTPromotedVideoCellController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}



static bool _logos_method$_ungrouped$YTIPlayabilityStatus$isAgeCheckRequired(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}



static bool _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayable(_LOGOS_SELF_TYPE_NORMAL YTIPlayabilityStatus* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return true;
}



static bool _logos_method$_ungrouped$YTPlayerRequestFactory$adultContentConfirmed(_LOGOS_SELF_TYPE_NORMAL YTPlayerRequestFactory* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return true;
}



static bool _logos_method$_ungrouped$YTSettings$enableMDXAutoCasting(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}



static bool _logos_method$_ungrouped$YTSingleVideoMediaData$isPlayableInBackground(_LOGOS_SELF_TYPE_NORMAL YTSingleVideoMediaData* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return true;
}



static BOOL _logos_method$_ungrouped$YTReachability$isOnWiFi(_LOGOS_SELF_TYPE_NORMAL YTReachability* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return true;
}



static void _logos_method$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
    arg1 = false;
    (_logos_orig$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$ ? _logos_orig$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$ : (__typeof__(_logos_orig$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$))class_getMethodImplementation(_logos_superclass$_ungrouped$YTSettings, @selector(setStreamHDOnWiFiOnly:)))(self, _cmd, arg1);
}



static BOOL _logos_method$_ungrouped$YTSettings$streamHDOnWiFiOnly(_LOGOS_SELF_TYPE_NORMAL YTSettings* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}



static BOOL _logos_method$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$(_LOGOS_SELF_TYPE_NORMAL YTSettingsViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
    arg1 = false;
    return false;
    return (_logos_orig$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$ ? _logos_orig$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$ : (__typeof__(_logos_orig$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$))class_getMethodImplementation(_logos_superclass$_ungrouped$YTSettingsViewController, @selector(onStreamHDOnWiFiOnly:)))(self, _cmd, arg1);
}



static BOOL _logos_method$_ungrouped$YTUserDefaults$streamHDOnWiFiOnly(_LOGOS_SELF_TYPE_NORMAL YTUserDefaults* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    return false;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTPlayerViewController = objc_getClass("YTPlayerViewController"); _logos_superclass$_ungrouped$YTPlayerViewController = class_getSuperclass(_logos_class$_ungrouped$YTPlayerViewController); { _logos_register_hook$(_logos_class$_ungrouped$YTPlayerViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$YTPlayerViewController$viewDidLoad, (IMP *)&_logos_orig$_ungrouped$YTPlayerViewController$viewDidLoad);}Class _logos_class$_ungrouped$YTHeaderContentComboViewController = objc_getClass("YTHeaderContentComboViewController"); _logos_superclass$_ungrouped$YTHeaderContentComboViewController = class_getSuperclass(_logos_class$_ungrouped$YTHeaderContentComboViewController); { _logos_register_hook$(_logos_class$_ungrouped$YTHeaderContentComboViewController, @selector(didPressAccountPanelButton:), (IMP)&_logos_method$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$, (IMP *)&_logos_orig$_ungrouped$YTHeaderContentComboViewController$didPressAccountPanelButton$);}Class _logos_class$_ungrouped$YTAppDelegate = objc_getClass("YTAppDelegate"); _logos_superclass$_ungrouped$YTAppDelegate = class_getSuperclass(_logos_class$_ungrouped$YTAppDelegate); { _logos_register_hook$(_logos_class$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$, (IMP *)&_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$);}Class _logos_class$_ungrouped$YTSingleVideoController = objc_getClass("YTSingleVideoController"); _logos_superclass$_ungrouped$YTSingleVideoController = class_getSuperclass(_logos_class$_ungrouped$YTSingleVideoController); { _logos_register_hook$(_logos_class$_ungrouped$YTSingleVideoController, @selector(isCurrentlyBackgroundable), (IMP)&_logos_method$_ungrouped$YTSingleVideoController$isCurrentlyBackgroundable, (IMP *)&_logos_orig$_ungrouped$YTSingleVideoController$isCurrentlyBackgroundable);}Class _logos_class$_ungrouped$YTVASTAd = objc_getClass("YTVASTAd"); _logos_superclass$_ungrouped$YTVASTAd = class_getSuperclass(_logos_class$_ungrouped$YTVASTAd); { _logos_register_hook$(_logos_class$_ungrouped$YTVASTAd, @selector(isSkippable), (IMP)&_logos_method$_ungrouped$YTVASTAd$isSkippable, (IMP *)&_logos_orig$_ungrouped$YTVASTAd$isSkippable);}{ _logos_register_hook$(_logos_class$_ungrouped$YTVASTAd, @selector(_skippable), (IMP)&_logos_method$_ungrouped$YTVASTAd$_skippable, (IMP *)&_logos_orig$_ungrouped$YTVASTAd$_skippable);}{ _logos_register_hook$(_logos_class$_ungrouped$YTVASTAd, @selector(isForecastingAd), (IMP)&_logos_method$_ungrouped$YTVASTAd$isForecastingAd, (IMP *)&_logos_orig$_ungrouped$YTVASTAd$isForecastingAd);}Class _logos_class$_ungrouped$YTVideoQualitySwitchController = objc_getClass("YTVideoQualitySwitchController"); _logos_superclass$_ungrouped$YTVideoQualitySwitchController = class_getSuperclass(_logos_class$_ungrouped$YTVideoQualitySwitchController); { _logos_register_hook$(_logos_class$_ungrouped$YTVideoQualitySwitchController, @selector(canSelectFormat:), (IMP)&_logos_method$_ungrouped$YTVideoQualitySwitchController$canSelectFormat$, (IMP *)&_logos_orig$_ungrouped$YTVideoQualitySwitchController$canSelectFormat$);}{ _logos_register_hook$(_logos_class$_ungrouped$YTVideoQualitySwitchController, @selector(_qualitySwitchAvailable), (IMP)&_logos_method$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchAvailable, (IMP *)&_logos_orig$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchAvailable);}{ _logos_register_hook$(_logos_class$_ungrouped$YTVideoQualitySwitchController, @selector(_qualitySwitchEnabled), (IMP)&_logos_method$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchEnabled, (IMP *)&_logos_orig$_ungrouped$YTVideoQualitySwitchController$_qualitySwitchEnabled);}Class _logos_class$_ungrouped$YTIPlayabilityStatus = objc_getClass("YTIPlayabilityStatus"); _logos_superclass$_ungrouped$YTIPlayabilityStatus = class_getSuperclass(_logos_class$_ungrouped$YTIPlayabilityStatus); { _logos_register_hook$(_logos_class$_ungrouped$YTIPlayabilityStatus, @selector(isPlayableInBackground), (IMP)&_logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground, (IMP *)&_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground);}{ _logos_register_hook$(_logos_class$_ungrouped$YTIPlayabilityStatus, @selector(isAgeCheckRequired), (IMP)&_logos_method$_ungrouped$YTIPlayabilityStatus$isAgeCheckRequired, (IMP *)&_logos_orig$_ungrouped$YTIPlayabilityStatus$isAgeCheckRequired);}{ _logos_register_hook$(_logos_class$_ungrouped$YTIPlayabilityStatus, @selector(isPlayable), (IMP)&_logos_method$_ungrouped$YTIPlayabilityStatus$isPlayable, (IMP *)&_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayable);}Class _logos_class$_ungrouped$YTIPlayerResponse = objc_getClass("YTIPlayerResponse"); _logos_superclass$_ungrouped$YTIPlayerResponse = class_getSuperclass(_logos_class$_ungrouped$YTIPlayerResponse); { _logos_register_hook$(_logos_class$_ungrouped$YTIPlayerResponse, @selector(isMonetized), (IMP)&_logos_method$_ungrouped$YTIPlayerResponse$isMonetized, (IMP *)&_logos_orig$_ungrouped$YTIPlayerResponse$isMonetized);}{ _logos_register_hook$(_logos_class$_ungrouped$YTIPlayerResponse, @selector(adsAllowReuse), (IMP)&_logos_method$_ungrouped$YTIPlayerResponse$adsAllowReuse, (IMP *)&_logos_orig$_ungrouped$YTIPlayerResponse$adsAllowReuse);}Class _logos_class$_ungrouped$YTPromotedVideoCellController = objc_getClass("YTPromotedVideoCellController"); _logos_superclass$_ungrouped$YTPromotedVideoCellController = class_getSuperclass(_logos_class$_ungrouped$YTPromotedVideoCellController); { _logos_register_hook$(_logos_class$_ungrouped$YTPromotedVideoCellController, @selector(shouldShowPromotedItems), (IMP)&_logos_method$_ungrouped$YTPromotedVideoCellController$shouldShowPromotedItems, (IMP *)&_logos_orig$_ungrouped$YTPromotedVideoCellController$shouldShowPromotedItems);}Class _logos_class$_ungrouped$YTPlayerRequestFactory = objc_getClass("YTPlayerRequestFactory"); _logos_superclass$_ungrouped$YTPlayerRequestFactory = class_getSuperclass(_logos_class$_ungrouped$YTPlayerRequestFactory); { _logos_register_hook$(_logos_class$_ungrouped$YTPlayerRequestFactory, @selector(adultContentConfirmed), (IMP)&_logos_method$_ungrouped$YTPlayerRequestFactory$adultContentConfirmed, (IMP *)&_logos_orig$_ungrouped$YTPlayerRequestFactory$adultContentConfirmed);}Class _logos_class$_ungrouped$YTSettings = objc_getClass("YTSettings"); _logos_superclass$_ungrouped$YTSettings = class_getSuperclass(_logos_class$_ungrouped$YTSettings); { _logos_register_hook$(_logos_class$_ungrouped$YTSettings, @selector(enableMDXAutoCasting), (IMP)&_logos_method$_ungrouped$YTSettings$enableMDXAutoCasting, (IMP *)&_logos_orig$_ungrouped$YTSettings$enableMDXAutoCasting);}{ _logos_register_hook$(_logos_class$_ungrouped$YTSettings, @selector(setStreamHDOnWiFiOnly:), (IMP)&_logos_method$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$, (IMP *)&_logos_orig$_ungrouped$YTSettings$setStreamHDOnWiFiOnly$);}{ _logos_register_hook$(_logos_class$_ungrouped$YTSettings, @selector(streamHDOnWiFiOnly), (IMP)&_logos_method$_ungrouped$YTSettings$streamHDOnWiFiOnly, (IMP *)&_logos_orig$_ungrouped$YTSettings$streamHDOnWiFiOnly);}Class _logos_class$_ungrouped$YTSingleVideoMediaData = objc_getClass("YTSingleVideoMediaData"); _logos_superclass$_ungrouped$YTSingleVideoMediaData = class_getSuperclass(_logos_class$_ungrouped$YTSingleVideoMediaData); { _logos_register_hook$(_logos_class$_ungrouped$YTSingleVideoMediaData, @selector(isPlayableInBackground), (IMP)&_logos_method$_ungrouped$YTSingleVideoMediaData$isPlayableInBackground, (IMP *)&_logos_orig$_ungrouped$YTSingleVideoMediaData$isPlayableInBackground);}Class _logos_class$_ungrouped$YTReachability = objc_getClass("YTReachability"); _logos_superclass$_ungrouped$YTReachability = class_getSuperclass(_logos_class$_ungrouped$YTReachability); { _logos_register_hook$(_logos_class$_ungrouped$YTReachability, @selector(isOnWiFi), (IMP)&_logos_method$_ungrouped$YTReachability$isOnWiFi, (IMP *)&_logos_orig$_ungrouped$YTReachability$isOnWiFi);}Class _logos_class$_ungrouped$YTSettingsViewController = objc_getClass("YTSettingsViewController"); _logos_superclass$_ungrouped$YTSettingsViewController = class_getSuperclass(_logos_class$_ungrouped$YTSettingsViewController); { _logos_register_hook$(_logos_class$_ungrouped$YTSettingsViewController, @selector(onStreamHDOnWiFiOnly:), (IMP)&_logos_method$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$, (IMP *)&_logos_orig$_ungrouped$YTSettingsViewController$onStreamHDOnWiFiOnly$);}Class _logos_class$_ungrouped$YTUserDefaults = objc_getClass("YTUserDefaults"); _logos_superclass$_ungrouped$YTUserDefaults = class_getSuperclass(_logos_class$_ungrouped$YTUserDefaults); { _logos_register_hook$(_logos_class$_ungrouped$YTUserDefaults, @selector(streamHDOnWiFiOnly), (IMP)&_logos_method$_ungrouped$YTUserDefaults$streamHDOnWiFiOnly, (IMP *)&_logos_orig$_ungrouped$YTUserDefaults$streamHDOnWiFiOnly);}} }
#line 349 "/Users/mac/Desktop/Hollow/JB/Hollow/Hollow.xm"
