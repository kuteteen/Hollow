//
//  DownloadedCell+Video.h
//  ColorPickerTest
//
//  Created by BandarHelal on 06/06/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Colours.h"
#import "MDCButton.h"
#import "MDCSlider.h"

@interface DownloadedCell : UITableViewCell
@property (nonatomic, strong) UIView *CNView;
@property (nonatomic, strong) UIImageView *VideoImage;
@property (nonatomic, strong) UILabel *VideoTitle;
@property (nonatomic, strong) MDCButton *PlayButton;
@property (nonatomic, strong) UIView *MaskView;
@property (nonatomic, strong) MDCButton *MoreButton;
@property (nonatomic, strong) UIView *TimeView;
@property (nonatomic, strong) UIImageView *TypeImage;
@property (nonatomic, strong) UILabel *TimeLabel;
@property (nonatomic, strong) UILabel *TimeLabelOfTimeLine;
@property (nonatomic, strong) UILabel *TimeLineLabel;
@property (nonatomic, strong) MDCSlider *TimeLine;
@end
