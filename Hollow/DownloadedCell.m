//
//  DownloadedCell+Video.m
//  ColorPickerTest
//
//  Created by BandarHelal on 06/06/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import "DownloadedCell.h"

@implementation DownloadedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        [self SetupMaskView];
        [self setupImages];
        [self setupTitles];
        [self SetupPlayButton];
        [self SetupMoreButton];
        [self SetupTimeView];
        [self SetupTypeView];
        [self SetupTimeLine];
    }
    return self;
}

- (void)setupContentView {
    self.CNView = UIView.new;
    self.CNView.backgroundColor = [UIColor colorFromHexString:@"282828"];
    [self.CNView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addSubview:self.CNView];
    
    [self.CNView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    [self.CNView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = true;
    [self.CNView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;
    [self.CNView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
}

- (void)setupImages {
    
    self.VideoImage = UIImageView.new;
    self.VideoImage.backgroundColor = UIColor.clearColor;
    
    self.VideoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.VideoImage setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addSubview:self.VideoImage];
    
    // Video constraint
    [self.VideoImage.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.VideoImage.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.VideoImage.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.VideoImage.heightAnchor constraintEqualToConstant:233].active = true;
    [self.VideoImage.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    
}

- (void)setupTitles {
    
    self.VideoTitle = UILabel.new;
    self.VideoTitle.textColor = UIColor.whiteColor;
    //self.VideoTitle.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:16];
    self.VideoTitle.textAlignment = NSTextAlignmentLeft;
    self.VideoTitle.numberOfLines = 0;
    [self.VideoTitle setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addSubview:self.VideoTitle];
    
    [self.VideoTitle.topAnchor constraintEqualToAnchor:self.MaskView.bottomAnchor constant:11].active = YES;
    [self.VideoTitle.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16].active = true;
    
}

- (void)SetupPlayButton {
    
    self.PlayButton = [[MDCButton alloc] init];
    [self.PlayButton setInkMaxRippleRadius:2];
    [self.PlayButton.layer setCornerRadius:2];
    [self.PlayButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.PlayButton setTranslatesAutoresizingMaskIntoConstraints:false];
    // /Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt
    [self.PlayButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_pause_white_48pt"] forState:UIControlStateNormal];
    [self.PlayButton setTintColor:[UIColor whiteColor]];
    [self.PlayButton setAlpha:0];
    [self addSubview:self.PlayButton];
    
    [self.PlayButton.heightAnchor constraintEqualToConstant:200];
    [self.PlayButton.widthAnchor constraintEqualToConstant:200];
    [self.PlayButton.centerXAnchor constraintEqualToAnchor:self.VideoImage.centerXAnchor].active = true;
    [self.PlayButton.centerYAnchor constraintEqualToAnchor:self.VideoImage.centerYAnchor].active = true;
}

- (void)SetupMoreButton {
    
    self.MoreButton = [[MDCButton alloc] init];
    [self.MoreButton setInkMaxRippleRadius:20];
    [self.MoreButton.layer setCornerRadius:20];
    [self.MoreButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.MoreButton setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.MoreButton setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    // /Library/Application Support/BH/Ressources.bundle/baseline_more_vert_white_18pt
    [self.MoreButton setImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/baseline_more_vert_white_18pt"] forState:UIControlStateNormal];
    [self.MoreButton setTintColor:[UIColor whiteColor]];
    [self addSubview:self.MoreButton];
    
    [self.MoreButton.topAnchor constraintEqualToAnchor:self.MaskView.bottomAnchor].active = true;
    [self.MoreButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;
    [self.MoreButton.leadingAnchor constraintEqualToAnchor:self.VideoTitle.trailingAnchor].active = true;
    [self.MoreButton.widthAnchor constraintEqualToConstant:40].active = true;
    [self.MoreButton.heightAnchor constraintEqualToConstant:40].active = true;
    
}

- (void)SetupTimeView {
    
    self.TimeView = UIView.new;
    self.TimeLabel = UILabel.new;
    [self.TimeLabel setTextColor:[UIColor whiteColor]];
    self.TimeLabel.font = [UIFont systemFontOfSize:12];
    self.TimeLabel.textAlignment = NSTextAlignmentCenter;
    self.TimeLabel.numberOfLines = 0;
    [self.TimeView setBackgroundColor:[UIColor colorFromHexString:@"04141B"]];
    [self.TimeView.layer setCornerRadius:2];
    [self.TimeView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.TimeLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.VideoImage addSubview:self.TimeView];
    [self.TimeView addSubview:self.TimeLabel];
    
    [self.TimeView.trailingAnchor constraintEqualToAnchor:self.VideoImage.trailingAnchor constant:-5].active = true;
    [self.TimeView.bottomAnchor constraintEqualToAnchor:self.VideoImage.bottomAnchor constant:-5].active = true;
    [self.TimeView.widthAnchor constraintEqualToConstant:41].active = true;
    [self.TimeView.heightAnchor constraintEqualToConstant:18].active = true;
    
    [self.TimeLabel.centerXAnchor constraintEqualToAnchor:self.TimeView.centerXAnchor].active = true;
    [self.TimeLabel.centerYAnchor constraintEqualToAnchor:self.TimeView.centerYAnchor].active = true;
}

- (void)SetupTypeView {
    
    self.TypeImage = [UIImageView new];
    [self.TypeImage setTintColor:[UIColor whiteColor]];
    [self.TypeImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.TypeImage setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.VideoImage addSubview:self.TypeImage];
    
    [self.TypeImage.bottomAnchor constraintEqualToAnchor:self.VideoImage.bottomAnchor constant:-5].active = true;
    [self.TypeImage.leadingAnchor constraintEqualToAnchor:self.VideoImage.leadingAnchor constant:7].active = true;
    [self.TypeImage.widthAnchor constraintEqualToConstant:20].active = true;
    [self.TypeImage.heightAnchor constraintEqualToConstant:20].active = true;
}

- (void)SetupMaskView {
    
    self.MaskView = UIView.new;
    [self.MaskView setBackgroundColor:[UIColor blackColor]];
    [self.MaskView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.MaskView setAlpha:0];
    [self addSubview:self.MaskView];
    
    [self.MaskView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.MaskView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.MaskView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.MaskView.heightAnchor constraintEqualToConstant:233].active = true;
    [self.MaskView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    
    
}

- (void)SetupTimeLine {
    
    self.TimeLine = [[MDCSlider alloc] init];
    [self.TimeLine setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.TimeLine setStatefulAPIEnabled:true];
    [self.TimeLine setThumbColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.TimeLine setTrackFillColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.TimeLine setTrackBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.TimeLine setValue:1];
    [self.TimeLine setAlpha:0];
    [self.TimeLabelOfTimeLine setAlpha:0];
    [self.TimeLineLabel setAlpha:0];
    
    self.TimeLineLabel = UILabel.new;
    [self.TimeLineLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.TimeLineLabel setTextColor:[UIColor whiteColor]];
    self.TimeLineLabel.font = [UIFont systemFontOfSize:12];
    self.TimeLineLabel.textAlignment = NSTextAlignmentCenter;
    self.TimeLineLabel.numberOfLines = 0;
    
    self.TimeLabelOfTimeLine = UILabel.new;
    [self.TimeLabelOfTimeLine setTranslatesAutoresizingMaskIntoConstraints:false];
    [self.TimeLabelOfTimeLine setTextColor:[UIColor whiteColor]];
    self.TimeLabelOfTimeLine.font = [UIFont systemFontOfSize:12];
    self.TimeLabelOfTimeLine.textAlignment = NSTextAlignmentCenter;
    self.TimeLabelOfTimeLine.numberOfLines = 0;
    
    [self addSubview:self.TimeLine];
    [self addSubview:self.TimeLineLabel];
    [self addSubview:self.TimeLabelOfTimeLine];
    
    [self.TimeLineLabel.bottomAnchor constraintEqualToAnchor:self.VideoImage.bottomAnchor constant:-1].active = true;
    [self.TimeLineLabel.leadingAnchor constraintEqualToAnchor:self.VideoImage.leadingAnchor constant:5].active = true;
    [self.TimeLineLabel.widthAnchor constraintEqualToConstant:40].active = true;
    [self.TimeLineLabel.heightAnchor constraintEqualToConstant:40].active = true;
    
    [self.TimeLine.centerYAnchor constraintEqualToAnchor:self.TimeLineLabel.centerYAnchor].active = true;
    [self.TimeLine.leadingAnchor constraintEqualToAnchor:self.TimeLineLabel.trailingAnchor].active = true;
    [self.TimeLine.trailingAnchor constraintEqualToAnchor:self.TimeLabelOfTimeLine.leadingAnchor].active = true;
    
    [self.TimeLabelOfTimeLine.bottomAnchor constraintEqualToAnchor:self.VideoImage.bottomAnchor constant:-1].active = true;
    [self.TimeLabelOfTimeLine.leadingAnchor constraintEqualToAnchor:self.TimeLine.trailingAnchor].active = true;
    [self.TimeLabelOfTimeLine.trailingAnchor constraintEqualToAnchor:self.VideoImage.trailingAnchor constant:-5].active = true;
    [self.TimeLabelOfTimeLine.widthAnchor constraintEqualToConstant:40].active = true;
    [self.TimeLabelOfTimeLine.heightAnchor constraintEqualToConstant:40].active = true;
    
}

@end
