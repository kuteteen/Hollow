//
//  RootViewController.m
//  ColorPickerTest
//
//  Created by BandarHelal on 23/05/2019.
//  Copyright © 2019 BandarHelal. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <KPSmartTabBarDelegate>
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    // /Library/Application Support/BH/Ressources.bundle/exit
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"/Library/Application Support/BH/Ressources.bundle/exit"]];
    UIBarButtonItem *barbuttton = [[UIBarButtonItem alloc] initWithImage:[image image] style:UIBarButtonItemStylePlain target:self action:@selector(Colse)];
    [barbuttton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = barbuttton;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:@"282828"]];
    self.navigationItem.title = @"Downloaded library";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    
                                                                    NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                    
                                                                    };
    [self SetupViewController];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}


- (void)Colse {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)SetupViewController {
    
    
    DownloadedViewController_Video *VideoVC = DownloadedViewController_Video.new;
    DownloadedViewController_Audio *AudioVC = DownloadedViewController_Audio.new;
    
    self.tabbar = [[KPSmartTabBar alloc] initWithViewControllers:@[VideoVC, AudioVC] frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) options:@{
                                                                                                                                                                         KPSmartTabBarOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0],
                                                                                                                                                                         KPSmartTabBarOptionMenuItemSelectedFont: [UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0],
                                                                                                                                                                         KPSmartTabBarOptionMenuItemSeparatorWidth : @(4.3),
                                                                                                                                                                         //KPSmartTabBarOptionMenuItemSeparatorColor : [UIColor lightGrayColor],
                                                                                                                                                                         //KPSmartTabBarOptionViewBackgroundColor : [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0],
                                                                                                                                                                         KPSmartTabBarOptionSelectionIndicatorColor : [UIColor colorWithRed:8.0/255.0 green:150.0/255.0 blue:225.0/255.0 alpha:1.0],
                                                                                                                                                                         KPSmartTabBarOptionMenuMargin:@(20.0),
                                                                                                                                                                         KPSmartTabBarOptionMenuHeight: @(40.0),
                                                                                                                                                                         KPSmartTabBarOptionSelectedMenuItemLabelColor: [UIColor colorWithRed:8.0/255.0 green:150.0/255.0 blue:225.0/255.0 alpha:1.0],
                                                                                                                                                                         KPSmartTabBarOptionBottomMenuHairlineColor: [UIColor clearColor],
                                                                                                                                                                         KPSmartTabBarOptionCenterMenuItems: @(YES),
                                                                                                                                                                         KPSmartTabBarOptionUseMenuLikeSegmentedControl : @(YES),
                                                                                                                                                                         KPSmartTabBarOptionMenuItemSeparatorRoundEdges:@(YES),
                                                                                                                                                                         KPSmartTabBarOptionEnableHorizontalBounce:@(NO),
                                                                                                                                                                         KPSmartTabBarOptionMenuItemSeparatorPercentageHeight:@(0.1),
                                                                                                                                                                         KPSmartTabBarOptionSelectionIndicatorHeight:@(2.0),
                                                                                                                                                                         KPSmartTabBarOptionAddBottomMenuHairline : @(YES),
                                                                                                                                                                         KPSmartTabBarOptionBottomMenuHairlineHeight : @(1.0)
                                                                                                                                                                             }];
    [self.tabbar.view setTranslatesAutoresizingMaskIntoConstraints:false];
    self.tabbar.delegate = self;
    [self.view addSubview:self.tabbar.view];
    
    [self.tabbar.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = true;
    [self.tabbar.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = true;
    [self.tabbar.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = true;
    [self.tabbar.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = true;
    
}

- (CGRect)statusBarFrameViewRect:(UIView *)view
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect statusBarWindowRect = [view.window convertRect:statusBarFrame fromWindow: nil];
    CGRect statusBarViewRect = [view convertRect:statusBarWindowRect fromView: nil];
    return statusBarViewRect;
}
@end
