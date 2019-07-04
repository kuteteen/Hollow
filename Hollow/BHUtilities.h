//
//  BHUtilities.h
//  Hollow
//
//  Created by BandarHelal on 03/07/2019.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "SVProgressHUD.h"
#import "FCFileManager.h"

@interface BHUtilities : NSObject
- (void)ConvertVideoToAudio:(NSURL *)VideoURLPath VideoTitle:(NSString *)title;
@end

