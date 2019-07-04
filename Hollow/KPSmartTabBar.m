//
//  KPSmartTabBar.m
//  KPSmartTabBar
//
//  Created by Krishna on 05/04/17.
//  Copyright © 2017 Krishna Patel. All rights reserved.
//

#import "KPSmartTabBar.h"

@interface MenuItemView ()

@end

@implementation MenuItemView

- (void)setUpMenuItemView:(CGFloat)menuItemWidth menuScrollViewHeight:(CGFloat)menuScrollViewHeight indicatorHeight:(CGFloat)indicatorHeight separatorPercentageHeight:(CGFloat)separatorPercentageHeight separatorWidth:(CGFloat)separatorWidth separatorRoundEdges:(BOOL)separatorRoundEdges menuItemSeparatorColor:(UIColor *)menuItemSeparatorColor
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, menuItemWidth, menuScrollViewHeight - indicatorHeight)];
    _menuItemSeparator = [[UIView alloc] initWithFrame:CGRectMake(menuItemWidth - (separatorWidth / 2), floor(menuScrollViewHeight * ((1.0 - separatorPercentageHeight) / 2.0)), separatorWidth, floor(menuScrollViewHeight * separatorPercentageHeight))];
    
    if (separatorRoundEdges) {
        _menuItemSeparator.layer.cornerRadius = _menuItemSeparator.frame.size.width / 2;
    }
    
    _menuItemSeparator.hidden = YES;
    [self addSubview:_menuItemSeparator];
    [self addSubview:_titleLabel];
}

- (void)setTitleText:(NSString *)text
{
    if (_titleLabel) {
        _titleLabel.text = text;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    }
}

@end

typedef NS_ENUM(NSUInteger, KPSmartTabBarScrollDirection) {
    KPSmartTabBarScrollDirectionLeft,
    KPSmartTabBarScrollDirectionRight,
    KPSmartTabBarScrollDirectionOther
};

@interface KPSmartTabBar ()

@property (nonatomic) NSMutableArray *mutableMenuItems;
@property (nonatomic) NSMutableArray *mutableMenuItemWidths;
@property (nonatomic) CGFloat totalMenuItemWidthIfDifferentWidths;
@property (nonatomic) CGFloat startingMenuMargin;

@property (nonatomic) UIView *selectionIndicatorView;

@property (nonatomic) BOOL currentOrientationIsPortrait;
@property (nonatomic) NSInteger pageIndexForOrientationChange;
@property (nonatomic) BOOL didLayoutSubviewsAfterRotation;
@property (nonatomic) BOOL didScrollAlready;

@property (nonatomic) CGFloat lastControllerScrollViewContentOffset;
@property (nonatomic) KPSmartTabBarScrollDirection lastScrollDirection;
@property (nonatomic) NSInteger startingPageForScroll;
@property (nonatomic) BOOL didTapMenuItemToScroll;
@property (nonatomic) NSMutableSet *pagesAddedSet;

@property (nonatomic) NSTimer *tapTimer;

@end


@implementation KPSmartTabBar

NSString * const KPSmartTabBarOptionSelectionIndicatorHeight             = @"selectionIndicatorHeight";
NSString * const KPSmartTabBarOptionMenuItemSeparatorWidth               = @"menuItemSeparatorWidth";
NSString * const KPSmartTabBarOptionScrollMenuBackgroundColor            = @"scrollMenuBackgroundColor";
NSString * const KPSmartTabBarOptionViewBackgroundColor                  = @"viewBackgroundColor";
NSString * const KPSmartTabBarOptionBottomMenuHairlineColor              = @"bottomMenuHairlineColor";
NSString * const KPSmartTabBarOptionSelectionIndicatorColor              = @"selectionIndicatorColor";
NSString * const KPSmartTabBarOptionMenuItemSeparatorColor               = @"menuItemSeparatorColor";
NSString * const KPSmartTabBarOptionMenuMargin                           = @"menuMargin";
NSString * const KPSmartTabBarOptionMenuHeight                           = @"menuHeight";
NSString * const KPSmartTabBarOptionSelectedMenuItemLabelColor           = @"selectedMenuItemLabelColor";
NSString * const KPSmartTabBarOptionUnselectedMenuItemLabelColor         = @"unselectedMenuItemLabelColor";
NSString * const KPSmartTabBarOptionUseMenuLikeSegmentedControl          = @"useMenuLikeSegmentedControl";
NSString * const KPSmartTabBarOptionMenuItemSeparatorRoundEdges          = @"menuItemSeparatorRoundEdges";
NSString * const KPSmartTabBarOptionMenuItemFont                         = @"menuItemFont";
NSString * const KPSmartTabBarOptionMenuItemSelectedFont                 = @"menuItemSelectedFont";
NSString * const KPSmartTabBarOptionMenuItemSeparatorPercentageHeight    = @"menuItemSeparatorPercentageHeight";
NSString * const KPSmartTabBarOptionMenuItemWidth                        = @"menuItemWidth";
NSString * const KPSmartTabBarOptionEnableHorizontalBounce               = @"enableHorizontalBounce";
NSString * const KPSmartTabBarOptionAddBottomMenuHairline                = @"addBottomMenuHairline";
NSString * const KPSmartTabBarOptionMenuItemWidthBasedOnTitleTextWidth   = @"menuItemWidthBasedOnTitleTextWidth";
NSString * const KPSmartTabBarOptionScrollAnimationDurationOnMenuItemTap = @"scrollAnimationDurationOnMenuItemTap";
NSString * const KPSmartTabBarOptionCenterMenuItems                      = @"centerMenuItems";
NSString * const KPSmartTabBarOptionHideTopMenuBar                       = @"hideTopMenuBar";
NSString * const KPSmartTabBarOptioncolor                                = @"color";
NSString * const KPSmartTabBarOptionBottomMenuHairlineHeight             = @"bottomHairlineHeight";

- (instancetype)initWithViewControllers:(NSArray *)viewControllers frame:(CGRect)frame options:(NSDictionary *)options
{
    self = [super initWithNibName:nil bundle:nil];
    if (!self) return nil;
    
    [self initValues];
    
    _controllerArray = viewControllers;
    
    self.view.frame = frame;
    
    if (options) {
        for (NSString *key in options) {
            if ([key isEqualToString:KPSmartTabBarOptionSelectionIndicatorHeight]) {
                _selectionIndicatorHeight = [options[key] floatValue];
            } else if ([key isEqualToString: KPSmartTabBarOptionMenuItemSeparatorWidth]) {
                _menuItemSeparatorWidth = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionScrollMenuBackgroundColor]) {
                _scrollMenuBackgroundColor = (UIColor *)options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionViewBackgroundColor]) {
                _viewBackgroundColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionBottomMenuHairlineColor]) {
                _bottomMenuHairlineColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionSelectionIndicatorColor]) {
                _selectionIndicatorColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorColor]) {
                _menuItemSeparatorColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuMargin]) {
                _menuMargin = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuHeight]) {
                _menuHeight = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionSelectedMenuItemLabelColor]) {
                _selectedMenuItemLabelColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionUnselectedMenuItemLabelColor]) {
                _unselectedMenuItemLabelColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionUseMenuLikeSegmentedControl]) {
                _useMenuLikeSegmentedControl = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorRoundEdges]) {
                _menuItemSeparatorRoundEdges = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemFont]) {
                _menuItemFont = options[key];
            }else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSelectedFont]) {
                _menuItemSelectedFont = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorPercentageHeight]) {
                _menuItemSeparatorPercentageHeight = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemWidth]) {
                _menuItemWidth = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionEnableHorizontalBounce]) {
                _enableHorizontalBounce = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionAddBottomMenuHairline]) {
                _addBottomMenuHairline = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemWidthBasedOnTitleTextWidth]) {
                _menuItemWidthBasedOnTitleTextWidth = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionScrollAnimationDurationOnMenuItemTap]) {
                _scrollAnimationDurationOnMenuItemTap = [options[key] integerValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionCenterMenuItems]) {
                _centerMenuItems = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionHideTopMenuBar]) {
                _hideTopMenuBar = [options[key] boolValue];
            }else if ([key isEqualToString:KPSmartTabBarOptionBottomMenuHairlineHeight]) {
                _bottomHairlineHeight = [options[key] floatValue];
            }
            else if ([key isEqualToString:KPSmartTabBarOptioncolor]) {
                //_hideTopMenuBar = [options[key] boolValue];
                
            }
        }
        
        if (_hideTopMenuBar) {
            _addBottomMenuHairline = NO;
            _menuHeight = 0.0;
        }
    }
    
    [self setUpUserInterface];
    if (_menuScrollView.subviews.count == 0) {
        [self configureUserInterface];
    }
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers frame:(CGRect)frame options:(NSDictionary *)options colors:(NSArray *)colors{
    self = [super initWithNibName:nil bundle:nil];
    if (!self) return nil;
    
    [self initValues];
    
    _controllerArray = viewControllers;
    _arrMenuItemColors=colors;
    
    self.view.frame = frame;
    
    if (options) {
        for (NSString *key in options) {
            if ([key isEqualToString:KPSmartTabBarOptionSelectionIndicatorHeight]) {
                _selectionIndicatorHeight = [options[key] floatValue];
            } else if ([key isEqualToString: KPSmartTabBarOptionMenuItemSeparatorWidth]) {
                _menuItemSeparatorWidth = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionScrollMenuBackgroundColor]) {
                _scrollMenuBackgroundColor = (UIColor *)options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionViewBackgroundColor]) {
                _viewBackgroundColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionBottomMenuHairlineColor]) {
                _bottomMenuHairlineColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionSelectionIndicatorColor]) {
                _selectionIndicatorColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorColor]) {
                _menuItemSeparatorColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuMargin]) {
                _menuMargin = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuHeight]) {
                _menuHeight = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionSelectedMenuItemLabelColor]) {
                _selectedMenuItemLabelColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionUnselectedMenuItemLabelColor]) {
                _unselectedMenuItemLabelColor = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionUseMenuLikeSegmentedControl]) {
                _useMenuLikeSegmentedControl = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorRoundEdges]) {
                _menuItemSeparatorRoundEdges = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemFont]) {
                _menuItemFont = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSelectedFont]) {
                _menuItemSelectedFont = options[key];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemSeparatorPercentageHeight]) {
                _menuItemSeparatorPercentageHeight = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemWidth]) {
                _menuItemWidth = [options[key] floatValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionEnableHorizontalBounce]) {
                _enableHorizontalBounce = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionAddBottomMenuHairline]) {
                _addBottomMenuHairline = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionMenuItemWidthBasedOnTitleTextWidth]) {
                _menuItemWidthBasedOnTitleTextWidth = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionScrollAnimationDurationOnMenuItemTap]) {
                _scrollAnimationDurationOnMenuItemTap = [options[key] integerValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionCenterMenuItems]) {
                _centerMenuItems = [options[key] boolValue];
            } else if ([key isEqualToString:KPSmartTabBarOptionHideTopMenuBar]) {
                _hideTopMenuBar = [options[key] boolValue];
            }else if ([key isEqualToString:KPSmartTabBarOptionBottomMenuHairlineHeight]) {
                _bottomHairlineHeight = [options[key] floatValue];
            }
            else if ([key isEqualToString:KPSmartTabBarOptioncolor]) {
                //_hideTopMenuBar = [options[key] boolValue];
                
            }
        }
        
        if (_hideTopMenuBar) {
            _addBottomMenuHairline = NO;
            _menuHeight = 0.0;
        }
    }
    
    [self setUpUserInterface];
    if (_menuScrollView.subviews.count == 0) {
        [self configureUserInterface];
    }
    return self;
}

- (void)initValues
{
    _menuScrollView       = [UIScrollView new];
    _controllerScrollView = [UIScrollView new];
    _mutableMenuItems       = [NSMutableArray array];
    _mutableMenuItemWidths  = [NSMutableArray array];
    
    _menuHeight                           = 34.0;
    _menuMargin                           = 15.0;
    _menuItemWidth                        = 111.0;
    _selectionIndicatorHeight             = 3.0;
    _totalMenuItemWidthIfDifferentWidths  = 0.0;
    _scrollAnimationDurationOnMenuItemTap = 500;
    _startingMenuMargin                   = 0.0;
    
    _selectionIndicatorView = [UIView new];
    
    _currentPageIndex = 0;
    _lastPageIndex    = 0;
    
    _selectionIndicatorColor      = [UIColor whiteColor];
    _selectedMenuItemLabelColor   = [UIColor whiteColor];
    _unselectedMenuItemLabelColor = [UIColor lightGrayColor];
    _scrollMenuBackgroundColor    = [UIColor colorFromHexString:@"282828"];
    _viewBackgroundColor          = [UIColor whiteColor];
    _bottomMenuHairlineColor      = [UIColor whiteColor];
    _menuItemSeparatorColor       = [UIColor lightGrayColor];
    
    _menuItemFont = [UIFont systemFontOfSize:15.0];
    _menuItemSeparatorPercentageHeight = 0.2;
    _menuItemSeparatorWidth            = 0.5;
    _bottomHairlineHeight              = 5.0;
    _menuItemSeparatorRoundEdges       = NO;
    
    _addBottomMenuHairline              = YES;
    _menuItemWidthBasedOnTitleTextWidth = NO;
    _useMenuLikeSegmentedControl        = NO;
    _centerMenuItems                    = NO;
    _enableHorizontalBounce             = YES;
    _hideTopMenuBar                     = NO;
    
    _currentOrientationIsPortrait   = YES;
    _pageIndexForOrientationChange  = 0;
    _didLayoutSubviewsAfterRotation = NO;
    _didScrollAlready               = NO;
    
    _lastControllerScrollViewContentOffset = 0.0;
    _startingPageForScroll = 0;
    _didTapMenuItemToScroll = NO;
    
    _menuItemFont = [UIFont systemFontOfSize:15];
    _menuItemSelectedFont = [UIFont systemFontOfSize:15];
    
    _pagesAddedSet = [NSMutableSet set];
}

- (void)setUpUserInterface
{
    NSDictionary *viewsDictionary = @{
                                      @"menuScrollView" : _menuScrollView,
                                      @"controllerScrollView":_controllerScrollView
                                      };
    
    _controllerScrollView.pagingEnabled                             = YES;
    _controllerScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _controllerScrollView.alwaysBounceHorizontal = _enableHorizontalBounce;
    _controllerScrollView.bounces                = _enableHorizontalBounce;
    
    _controllerScrollView.frame = CGRectMake(0.0, _menuHeight, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:_controllerScrollView];
    
    NSArray *controllerScrollView_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[controllerScrollView]|" options:0 metrics:nil views:viewsDictionary];
    NSString *controllerScrollView_constraint_V_Format = [NSString stringWithFormat:@"V:|-0-[controllerScrollView]|"];
    NSArray *controllerScrollView_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:controllerScrollView_constraint_V_Format options:0 metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:controllerScrollView_constraint_H];
    [self.view addConstraints:controllerScrollView_constraint_V];
    
    // Set up menu scroll view
    _menuScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _menuScrollView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, _menuHeight);
    //my
    _menuScrollView.bounces=NO;
    [self.view addSubview:_menuScrollView];
    
    NSArray *menuScrollView_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[menuScrollView]|" options:0 metrics:nil views:viewsDictionary];
    NSString *menuScrollView_constrant_V_Format = [NSString stringWithFormat:@"V:|[menuScrollView(%.f)]",_menuHeight];
    NSArray *menuScrollView_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:menuScrollView_constrant_V_Format options:0 metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:menuScrollView_constraint_H];
    [self.view addConstraints:menuScrollView_constraint_V];
    
    if (_addBottomMenuHairline) {
        UIView *menuBottomHairline = [UIView new];
        
        menuBottomHairline.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:menuBottomHairline];
        
        NSArray *menuBottomHairline_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[menuBottomHairline]|" options:0 metrics:nil views:@{@"menuBottomHairline":menuBottomHairline}];
        NSString *menuBottomHairline_constraint_V_Format = [NSString stringWithFormat:@"V:|-%f-[menuBottomHairline(%f)]",_menuHeight, _bottomHairlineHeight];
        NSArray *menuBottomHairline_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:menuBottomHairline_constraint_V_Format options:0 metrics:nil views:@{@"menuBottomHairline":menuBottomHairline}];
        
        [self.view addConstraints:menuBottomHairline_constraint_H];
        [self.view addConstraints:menuBottomHairline_constraint_V];
        
        menuBottomHairline.backgroundColor = _bottomMenuHairlineColor;
    }
    
    // Disable scroll bars
    _menuScrollView.showsHorizontalScrollIndicator       = NO;
    _menuScrollView.showsVerticalScrollIndicator         = NO;
    _controllerScrollView.showsHorizontalScrollIndicator = NO;
    _controllerScrollView.showsVerticalScrollIndicator   = NO;
    
    // Set background color behind scroll views and for menu scroll view
    self.view.backgroundColor = _viewBackgroundColor;
    _menuScrollView.backgroundColor = _scrollMenuBackgroundColor;
}

- (void)configureUserInterface
{
    UITapGestureRecognizer *menuItemTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleMenuItemTap:)];
    menuItemTapGestureRecognizer.numberOfTapsRequired    = 1;
    menuItemTapGestureRecognizer.numberOfTouchesRequired = 1;
    menuItemTapGestureRecognizer.delegate                = self;
    [_menuScrollView addGestureRecognizer:menuItemTapGestureRecognizer];
    
    // Set delegate for controller scroll view
    _controllerScrollView.delegate = self;
    
    // When the user taps the status bar, the scroll view beneath the touch which is closest to the status bar will be scrolled to top,
    // but only if its `scrollsToTop` property is YES, its delegate does not return NO from `shouldScrollViewScrollToTop`, and it is not already at the top.
    // If more than one scroll view is found, none will be scrolled.
    // Disable scrollsToTop for menu and controller scroll views so that iOS finds scroll views within our pages on status bar tap gesture.
    _menuScrollView.scrollsToTop       = NO;;
    _controllerScrollView.scrollsToTop = NO;;
    
    // Configure menu scroll view
    if (_useMenuLikeSegmentedControl) {
        _menuScrollView.scrollEnabled = NO;;
        _menuScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _menuHeight);
        _menuMargin = 0.0;
    } else {
        _menuScrollView.contentSize = CGSizeMake((_menuItemWidth + _menuMargin) * (CGFloat)_controllerArray.count + _menuMargin, _menuHeight);
    }
    // Configure controller scroll view content size
    _controllerScrollView.contentSize = CGSizeMake(self.view.frame.size.width * (CGFloat)_controllerArray.count, 0.0);
    
    CGFloat index = 0.0;
    
    for (UIViewController *controller in _controllerArray) {
        if (index == 0.0) {
            // Add first two controllers to scrollview and as child view controller
            [controller viewWillAppear:YES];
            [self addPageAtIndex:0];
            [controller viewDidAppear:YES];
        }
        
        // Set up menu item for menu scroll view
        CGRect menuItemFrame;
        
        if (_useMenuLikeSegmentedControl) {
            menuItemFrame = CGRectMake(self.view.frame.size.width / (CGFloat)_controllerArray.count * (CGFloat)index, 0.0, (CGFloat)self.view.frame.size.width / (CGFloat)_controllerArray.count, _menuHeight);
        } else if (_menuItemWidthBasedOnTitleTextWidth) {
            NSString *controllerTitle = controller.title;
            NSString *titleText;
            
            if (index == 0) {
                titleText = controllerTitle != nil ? controllerTitle : [NSString stringWithFormat:@"Video"];
            }
            
            if (index == 1) {
                titleText = controllerTitle != nil ? controllerTitle : [NSString stringWithFormat:@"Audio"];
            }
            
            
            CGRect itemWidthRect = [titleText boundingRectWithSize:CGSizeMake(1000, 1000) options: NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName:_menuItemFont} context: nil];
            
            _menuItemWidth = itemWidthRect.size.width;
            
            menuItemFrame = CGRectMake(_totalMenuItemWidthIfDifferentWidths + _menuMargin + (_menuMargin * index), 0.0, _menuItemWidth, _menuHeight);
            
            _totalMenuItemWidthIfDifferentWidths += itemWidthRect.size.width;
            [_mutableMenuItemWidths addObject:@(itemWidthRect.size.width)];
        } else {
            if (_centerMenuItems && index == 0.0) {
                _startingMenuMargin = ((self.view.frame.size.width - (((CGFloat)_controllerArray.count * _menuItemWidth) + (CGFloat)(_controllerArray.count - 1) * _menuMargin)) / 2.0) -  _menuMargin;
                
                if (_startingMenuMargin < 0.0) {
                    _startingMenuMargin = 0.0;
                }
                
                menuItemFrame = CGRectMake(_startingMenuMargin + _menuMargin, 0.0, _menuItemWidth, _menuHeight);
            } else {
                menuItemFrame = CGRectMake(_menuItemWidth * index + _menuMargin * (index + 1) + _startingMenuMargin, 0.0, _menuItemWidth, _menuHeight);
            }
        }
        
        MenuItemView *menuItemView = [[MenuItemView alloc] initWithFrame:menuItemFrame];
        if (_useMenuLikeSegmentedControl) {
            [menuItemView setUpMenuItemView:(CGFloat)self.view.frame.size.width / (CGFloat)_controllerArray.count menuScrollViewHeight:_menuHeight indicatorHeight:_selectionIndicatorHeight separatorPercentageHeight:_menuItemSeparatorPercentageHeight separatorWidth:_menuItemSeparatorWidth separatorRoundEdges:_menuItemSeparatorRoundEdges menuItemSeparatorColor:_menuItemSeparatorColor];
            
        } else {
            [menuItemView setUpMenuItemView:_menuItemWidth menuScrollViewHeight:_menuHeight indicatorHeight:_selectionIndicatorHeight separatorPercentageHeight:_menuItemSeparatorPercentageHeight separatorWidth:_menuItemSeparatorWidth separatorRoundEdges:_menuItemSeparatorRoundEdges menuItemSeparatorColor:_menuItemSeparatorColor];
        }
        
        // Configure menu item label font if font is set by user
        menuItemView.titleLabel.font = _menuItemFont;
        
        menuItemView.titleLabel.textAlignment = NSTextAlignmentCenter;
        menuItemView.titleLabel.textColor = _unselectedMenuItemLabelColor;
        
        // Set title depending on if controller has a title set
        if (controller.title != nil) {
            [menuItemView setTitleText:controller.title];
            
            if(_arrMenuItemColors.count > 0){
                UIColor *c=(UIColor *)[_arrMenuItemColors objectAtIndex:index];
                menuItemView.titleLabel.backgroundColor=c;
            }
            
        } else {
            
            if (index == 0) {
                [menuItemView setTitleText:[NSString stringWithFormat:@"Video"]];
            }
            
            if (index == 1) {
                [menuItemView setTitleText:[NSString stringWithFormat:@"Audio"]];
            }
            
        }
        
        // Add separator between menu items when using as segmented control
        if (_useMenuLikeSegmentedControl) {
            if ((NSInteger)index < _controllerArray.count - 1) {
                menuItemView.menuItemSeparator.hidden = NO;
            }
        }
        
        // Add menu item view to menu scroll view
        [_menuScrollView addSubview:menuItemView];
        
        [_mutableMenuItems addObject:menuItemView];
        
        index++;
    }
    
    // Set new content size for menu scroll view if needed
    if (_menuItemWidthBasedOnTitleTextWidth) {
        _menuScrollView.contentSize = CGSizeMake((_totalMenuItemWidthIfDifferentWidths + _menuMargin) + (CGFloat)_controllerArray.count * _menuMargin, _menuHeight);
    }
    
    // Set selected color for title label of selected menu item
    if (_mutableMenuItems.count > 0) {
        if ([_mutableMenuItems[_currentPageIndex] titleLabel] != nil) {
            [_mutableMenuItems[_currentPageIndex] titleLabel].textColor = _selectedMenuItemLabelColor;
            [_mutableMenuItems[_currentPageIndex] titleLabel].font=_menuItemSelectedFont;
        }
    }
    else{
        [_mutableMenuItems[_currentPageIndex] titleLabel].font=_menuItemFont;
    }
    
    // Configure selection indicator view
    CGRect selectionIndicatorFrame;
    
    if (_useMenuLikeSegmentedControl) {
        selectionIndicatorFrame = CGRectMake(0.0, _menuHeight - _selectionIndicatorHeight, self.view.frame.size.width / (CGFloat)_controllerArray.count, _selectionIndicatorHeight);
    } else if (_menuItemWidthBasedOnTitleTextWidth) {
        selectionIndicatorFrame = CGRectMake(_menuMargin, _menuHeight - _selectionIndicatorHeight, [_mutableMenuItemWidths[0] floatValue], _selectionIndicatorHeight);
    } else {
        if (_centerMenuItems) {
            selectionIndicatorFrame = CGRectMake(_startingMenuMargin + _menuMargin, _menuHeight - _selectionIndicatorHeight, _menuItemWidth, _selectionIndicatorHeight);
        } else {
            selectionIndicatorFrame = CGRectMake(_menuMargin, _menuHeight - _selectionIndicatorHeight, _menuItemWidth, _selectionIndicatorHeight);
        }
    }
    
    _selectionIndicatorView = [[UIView alloc] initWithFrame:selectionIndicatorFrame];
    _selectionIndicatorView.backgroundColor = _selectionIndicatorColor;
    [_menuScrollView addSubview:_selectionIndicatorView];
}

#pragma mark - Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_didLayoutSubviewsAfterRotation) {
        if ([scrollView isEqual:_controllerScrollView]) {
            if (scrollView.contentOffset.x >= 0.0 && scrollView.contentOffset.x <= ((CGFloat)(_controllerArray.count - 1) * self.view.frame.size.width)) {
                UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
                if ((_currentOrientationIsPortrait && UIInterfaceOrientationIsPortrait(orientation)) || (!_currentOrientationIsPortrait && UIInterfaceOrientationIsLandscape(orientation))){
                    // Check if scroll direction changed
                    if (!_didTapMenuItemToScroll) {
                        if (_didScrollAlready) {
                            KPSmartTabBarScrollDirection newScrollDirection  = KPSmartTabBarScrollDirectionOther;
                            
                            if ((CGFloat)_startingPageForScroll * scrollView.frame.size.width > scrollView.contentOffset.x) {
                                newScrollDirection = KPSmartTabBarScrollDirectionRight;
                            } else if ((CGFloat)_startingPageForScroll * scrollView.frame.size.width < scrollView.contentOffset.x) {
                                newScrollDirection = KPSmartTabBarScrollDirectionLeft;
                            }
                            
                            if (newScrollDirection != KPSmartTabBarScrollDirectionOther) {
                                if (_lastScrollDirection != newScrollDirection) {
                                    NSInteger index = newScrollDirection == KPSmartTabBarScrollDirectionLeft ? _currentPageIndex + 1 : _currentPageIndex - 1;
                                    
                                    if (index >= 0 && index < _controllerArray.count ){
                                        // Check dictionary if page was already added
                                        if (![_pagesAddedSet containsObject:@(index)]) {
                                            
                                            [self addPageAtIndex:index];
                                            
                                            [_pagesAddedSet addObject:@(index)];
                                        }
                                    }
                                }
                            }
                            
                            _lastScrollDirection = newScrollDirection;
                        }
                        
                        if (!_didScrollAlready) {
                            if (_lastControllerScrollViewContentOffset > scrollView.contentOffset.x) {
                                if (_currentPageIndex != _controllerArray.count - 1 ){
                                    // Add page to the left of current page
                                    NSInteger index = _currentPageIndex - 1;
                                    
                                    if (![_pagesAddedSet containsObject:@(index)] && index < _controllerArray.count && index >= 0) {
                                        [self addPageAtIndex:index];
                                        
                                        [_pagesAddedSet addObject:@(index)];
                                    }
                                    
                                    _lastScrollDirection = KPSmartTabBarScrollDirectionRight;
                                }
                            } else if (_lastControllerScrollViewContentOffset < scrollView.contentOffset.x) {
                                if (_currentPageIndex != 0) {
                                    // Add page to the right of current page
                                    NSInteger index = _currentPageIndex + 1;
                                    
                                    if (![_pagesAddedSet containsObject:@(index)] && index < _controllerArray.count && index >= 0) {
                                        
                                        [self addPageAtIndex:index];
                                        [_pagesAddedSet addObject:@(index)];
                                    }
                                    
                                    _lastScrollDirection = KPSmartTabBarScrollDirectionLeft;
                                }
                            }
                            
                            _didScrollAlready = YES;
                        }
                        
                        _lastControllerScrollViewContentOffset = scrollView.contentOffset.x;
                    }
                    
                    CGFloat ratio = 1.0;
                    
                    // Calculate ratio between scroll views
                    ratio = (_menuScrollView.contentSize.width - self.view.frame.size.width) / (_controllerScrollView.contentSize.width - self.view.frame.size.width);
                    
                    if (_menuScrollView.contentSize.width > self.view.frame.size.width ){
                        CGPoint offset  = _menuScrollView.contentOffset;
                        offset.x = _controllerScrollView.contentOffset.x * ratio;
                        [_menuScrollView setContentOffset:offset animated: NO];
                    }
                    
                    // Calculate current page
                    CGFloat width = _controllerScrollView.frame.size.width;
                    NSInteger page = (NSInteger)(_controllerScrollView.contentOffset.x + (0.5 * width)) / width;
                    
                    // Update page if changed
                    if (page != _currentPageIndex) {
                        _lastPageIndex = _currentPageIndex;
                        _currentPageIndex = page;
                        
                        
                        if (![_pagesAddedSet containsObject:@(page)] && page < _controllerArray.count && page >= 0){
                            [self addPageAtIndex:page];
                            [_pagesAddedSet addObject:@(page)];
                            
                        }
                        
                        if (!_didTapMenuItemToScroll) {
                            // Add last page to pages dictionary to make sure it gets removed after scrolling
                            if (![_pagesAddedSet containsObject:@(_lastPageIndex)]) {
                                [_pagesAddedSet addObject:@(_lastPageIndex)];
                            }
                            
                            // Make sure only up to 3 page views are in memory when fast scrolling, otherwise there should only be one in memory
                            NSInteger indexLeftTwo = page - 2;
                            if ([_pagesAddedSet containsObject:@(indexLeftTwo)]) {
                                
                                [_pagesAddedSet removeObject:@(indexLeftTwo)];
                                
                                [self removePageAtIndex:indexLeftTwo];
                            }
                            NSInteger indexRightTwo = page + 2;
                            if ([_pagesAddedSet containsObject:@(indexRightTwo)]) {
                                
                                [_pagesAddedSet removeObject:@(indexRightTwo)];
                                
                                [self removePageAtIndex:indexRightTwo];
                            }
                        }
                    }
                    
                    // Move selection indicator view when swiping
                    [self moveSelectionIndicator:page];
                }
            } else {
                CGFloat ratio = 1.0;
                
                ratio = (_menuScrollView.contentSize.width - self.view.frame.size.width) / (_controllerScrollView.contentSize.width - self.view.frame.size.width);
                
                if (_menuScrollView.contentSize.width > self.view.frame.size.width) {
                    CGPoint offset = self.menuScrollView.contentOffset;
                    offset.x = _controllerScrollView.contentOffset.x * ratio;
                    [self.menuScrollView setContentOffset:offset animated:NO];
                }
            }
        }
    } else {
        _didLayoutSubviewsAfterRotation = NO;
        
        // Move selection indicator view when swiping
        [self moveSelectionIndicator:self.currentPageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_controllerScrollView]) {
        // Call didMoveToPage delegate function
        UIViewController *currentController = _controllerArray[_currentPageIndex];
        if ([_delegate respondsToSelector:@selector(didMoveToPage:index:)]) {
            [_delegate didMoveToPage:currentController index:_currentPageIndex];
        }
        
        // Remove all but current page after decelerating
        for (NSNumber *num in _pagesAddedSet) {
            if (![num isEqualToNumber:@(self.currentPageIndex)]) {
                [self removePageAtIndex:num.integerValue];
            }
        }
        
        _didScrollAlready = NO;
        _startingPageForScroll = _currentPageIndex;
        
        // Empty out pages in dictionary
        [_pagesAddedSet removeAllObjects];
    }
}

- (void)scrollViewDidEndTapScrollingAnimation
{
    // Call didMoveToPage delegate function
    UIViewController *currentController = _controllerArray[_currentPageIndex];
    if ([_delegate respondsToSelector:@selector(didMoveToPage:index:)]) {
        [_delegate didMoveToPage:currentController index:_currentPageIndex];
    }
    
    // Remove all but current page after decelerating
    for (NSNumber *num in _pagesAddedSet) {
        if (![num isEqualToNumber:@(self.currentPageIndex)]) {
            [self removePageAtIndex:num.integerValue];
        }
    }
    
    _startingPageForScroll = _currentPageIndex;
    _didTapMenuItemToScroll = NO;
    
    // Empty out pages in dictionary
    [_pagesAddedSet removeAllObjects];
}

// MARK: - Handle Selection Indicator
- (void)moveSelectionIndicator:(NSInteger)pageIndex
{
    if (pageIndex >= 0 && pageIndex < _controllerArray.count) {
        [UIView animateWithDuration:0.15 animations:^{
            
            CGFloat selectionIndicatorWidth = self.selectionIndicatorView.frame.size.width;
            CGFloat selectionIndicatorX = 0.0;
            
            if (self.useMenuLikeSegmentedControl) {
                selectionIndicatorX = (CGFloat)pageIndex * (self.view.frame.size.width / (CGFloat)self.controllerArray.count);
                selectionIndicatorWidth = self.view.frame.size.width / (CGFloat)self.controllerArray.count;
            } else if (self.menuItemWidthBasedOnTitleTextWidth) {
                selectionIndicatorWidth = [self.menuItemWidths[pageIndex] floatValue];
                selectionIndicatorX += self.menuMargin;
                
                if (pageIndex > 0) {
                    for (NSInteger i=0; i<pageIndex; i++) {
                        selectionIndicatorX += (self.menuMargin + [self.menuItemWidths[i] floatValue]);
                    }
                }
            } else {
                if (self.centerMenuItems && pageIndex == 0) {
                    selectionIndicatorX = self.startingMenuMargin + self.menuMargin;
                } else {
                    selectionIndicatorX = self.menuItemWidth * (CGFloat)pageIndex + self.menuMargin * (CGFloat)(pageIndex + 1) + self.startingMenuMargin;
                }
            }
            
            self.selectionIndicatorView.frame = CGRectMake(selectionIndicatorX, self.selectionIndicatorView.frame.origin.y, selectionIndicatorWidth, self.selectionIndicatorView.frame.size.height);
            
            // Switch newly selected menu item title label to selected color and old one to unselected color
            if (self.menuItems.count > 0) {
                if ([self.menuItems[self.lastPageIndex] titleLabel] != nil && [self.menuItems[self.currentPageIndex] titleLabel] != nil) {
                    [self.menuItems[self.lastPageIndex] titleLabel].textColor = self.unselectedMenuItemLabelColor;
                    [self.menuItems[self.currentPageIndex] titleLabel].textColor = self.selectedMenuItemLabelColor;
                    [_mutableMenuItems[_currentPageIndex] titleLabel].font=_menuItemSelectedFont;
                    [_mutableMenuItems[self.lastPageIndex] titleLabel].font=_menuItemFont;
                }
            }
        }];
    }
}


// MARK: - Tap gesture recognizer selector
- (void)handleMenuItemTap:(UITapGestureRecognizer *)gestureRecognizer
{
    
    CGPoint tappedPoint = [gestureRecognizer locationInView:_menuScrollView];
    
    if (tappedPoint.y < self.menuScrollView.frame.size.height) {
        
        // Calculate tapped page
        NSInteger itemIndex = 0;
        
        if (_useMenuLikeSegmentedControl) {
            itemIndex = (NSInteger) (tappedPoint.x / (self.view.frame.size.width / (CGFloat)_controllerArray.count));
        } else if (_menuItemWidthBasedOnTitleTextWidth) {
            // Base case being first item
            CGFloat menuItemLeftBound = 0.0;
            CGFloat menuItemRightBound = [_mutableMenuItemWidths[0] floatValue] + _menuMargin + (_menuMargin / 2);
            
            if (!(tappedPoint.x >= menuItemLeftBound && tappedPoint.x <= menuItemRightBound)) {
                for (NSInteger i = 1; i<=_controllerArray.count - 1; i++) {
                    menuItemLeftBound = menuItemRightBound + 1.0;
                    menuItemRightBound = menuItemLeftBound + [_mutableMenuItemWidths[i] floatValue] + _menuMargin;
                    
                    if (tappedPoint.x >= menuItemLeftBound && tappedPoint.x <= menuItemRightBound) {
                        itemIndex = i;
                        break;
                    }
                }
            }
        } else {
            CGFloat rawItemIndex = ((tappedPoint.x - _startingMenuMargin) - _menuMargin / 2) / (_menuMargin + _menuItemWidth);
            
            // Prevent moving to first item when tapping left to first item
            if (rawItemIndex < 0) {
                itemIndex = -1;
            } else {
                itemIndex = (NSInteger)rawItemIndex;
            }
        }
        
        if (itemIndex >= 0 && itemIndex < _controllerArray.count) {
            // Update page if changed
            if (itemIndex != _currentPageIndex) {
                _startingPageForScroll = itemIndex;
                _lastPageIndex = _currentPageIndex;
                _currentPageIndex = itemIndex;
                _didTapMenuItemToScroll = YES;
                
                // Add pages in between current and tapped page if necessary
                NSInteger smallerIndex = _lastPageIndex < _currentPageIndex ? _lastPageIndex : _currentPageIndex;
                NSInteger largerIndex = _lastPageIndex > _currentPageIndex ? _lastPageIndex : _currentPageIndex;
                
                if (smallerIndex + 1 != largerIndex) {
                    for (NSInteger i=smallerIndex + 1; i< largerIndex; i++) {
                        
                        if (![_pagesAddedSet containsObject:@(i)]) {
                            [self addPageAtIndex:i];
                            [_pagesAddedSet addObject:@(i)];
                        }
                    }
                }
                
                [self addPageAtIndex:itemIndex];
                
                // Add page from which tap is initiated so it can be removed after tap is done
                [_pagesAddedSet addObject:@(_lastPageIndex)];
                
            }
            
            // Move controller scroll view when tapping menu item
            double duration = _scrollAnimationDurationOnMenuItemTap / 1000.0;
            
            [UIView animateWithDuration:duration animations:^{
                CGFloat xOffset = (CGFloat)itemIndex * _controllerScrollView.frame.size.width;
                [_controllerScrollView setContentOffset:CGPointMake(xOffset, _controllerScrollView.contentOffset.y)];
            }];
            
            if (_tapTimer != nil) {
                [_tapTimer invalidate];
            }
            
            NSTimeInterval timerInterval = (double)_scrollAnimationDurationOnMenuItemTap * 0.001;
            _tapTimer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(scrollViewDidEndTapScrollingAnimation) userInfo:nil repeats:NO];
        }
    }
}

// MARK: - Remove/Add Page
- (void)addPageAtIndex:(NSInteger)index
{
    // Call didMoveToPage delegate function
    UIViewController *currentController = _controllerArray[index];
    if ([_delegate respondsToSelector:@selector(willMoveToPage:index:)]) {
        [_delegate willMoveToPage:currentController index:index];
    }
    UIViewController *newVC = _controllerArray[index];
    
    [newVC willMoveToParentViewController:self];
    
    newVC.view.frame = CGRectMake(self.view.frame.size.width * (CGFloat)index, _menuHeight, self.view.frame.size.width, self.view.frame.size.height - _menuHeight);
    
    @try {
        [self addChildViewController:newVC];
        [_controllerScrollView addSubview:newVC.view];
        [newVC didMoveToParentViewController:self];
    } @catch (NSException *exception) {
        
    }
    
    
    if(_arrMenuItemColors == nil){}
    else{
        
        if (_addBottomMenuHairline) {
            UIView *menuBottomHairline = [UIView new];
            
            menuBottomHairline.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self.view addSubview:menuBottomHairline];
            
            
            NSArray *menuBottomHairline_constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[menuBottomHairline]|" options:0 metrics:nil views:@{@"menuBottomHairline":menuBottomHairline}];
            NSString *menuBottomHairline_constraint_V_Format = [NSString stringWithFormat:@"V:|-%f-[menuBottomHairline(%f)]",_menuHeight, _bottomHairlineHeight];
            NSArray *menuBottomHairline_constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:menuBottomHairline_constraint_V_Format options:0 metrics:nil views:@{@"menuBottomHairline":menuBottomHairline}];
            
            [self.view addConstraints:menuBottomHairline_constraint_H];
            [self.view addConstraints:menuBottomHairline_constraint_V];
            
            menuBottomHairline.backgroundColor = _arrMenuItemColors[index];
        }
    }
}

- (void)removePageAtIndex:(NSInteger)index
{
    UIViewController *oldVC = _controllerArray[index];
    
    [oldVC willMoveToParentViewController:nil];
    
    [oldVC.view removeFromSuperview];
    [oldVC removeFromParentViewController];
    
    [oldVC didMoveToParentViewController:nil];
}


// MARK: - Orientation Change

- (void)viewDidLayoutSubviews
{
    // Configure controller scroll view content size
    _controllerScrollView.contentSize = CGSizeMake(self.view.frame.size.width * (CGFloat)_controllerArray.count, self.view.frame.size.height - _menuHeight);
    
    BOOL oldCurrentOrientationIsPortrait = _currentOrientationIsPortrait;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    _currentOrientationIsPortrait = UIInterfaceOrientationIsPortrait(orientation);
    
    if ((oldCurrentOrientationIsPortrait && UIInterfaceOrientationIsLandscape(orientation)) || (!oldCurrentOrientationIsPortrait && UIInterfaceOrientationIsPortrait(orientation))){
        _didLayoutSubviewsAfterRotation = YES;
        
        //Resize menu items if using as segmented control
        if (_useMenuLikeSegmentedControl) {
            _menuScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _menuHeight);
            
            // Resize selectionIndicator bar
            CGFloat selectionIndicatorX = (CGFloat)_currentPageIndex * (self.view.frame.size.width / (CGFloat)_controllerArray.count);
            CGFloat selectionIndicatorWidth = self.view.frame.size.width / (CGFloat)_controllerArray.count;
            _selectionIndicatorView.frame =  CGRectMake(selectionIndicatorX, self.selectionIndicatorView.frame.origin.y, selectionIndicatorWidth, self.selectionIndicatorView.frame.size.height);
            
            // Resize menu items
            NSInteger index = 0;
            
            for (MenuItemView *item in _mutableMenuItems) {
                item.frame = CGRectMake(self.view.frame.size.width / (CGFloat)_controllerArray.count * (CGFloat)index, 0.0, self.view.frame.size.width / (CGFloat)_controllerArray.count, _menuHeight);
                if (item.titleLabel) {
                    item.titleLabel.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width / (CGFloat)_controllerArray.count, _menuHeight);
                }
                if (item.menuItemSeparator){
                    item.menuItemSeparator.frame = CGRectMake(item.frame.size.width - (_menuItemSeparatorWidth / 2), item.menuItemSeparator.frame.origin.y, item.menuItemSeparator.frame.size.width, item.menuItemSeparator.frame.size.height);
                }
                
                index++;
            }
        } else if (_centerMenuItems) {
            _startingMenuMargin = ((self.view.frame.size.width - (((CGFloat)_controllerArray.count * _menuItemWidth) + ((CGFloat)(_controllerArray.count - 1) * _menuMargin))) / 2.0) -  _menuMargin;
            
            if (_startingMenuMargin < 0.0) {
                _startingMenuMargin = 0.0;
            }
            
            CGFloat selectionIndicatorX = self.menuItemWidth * (CGFloat)_currentPageIndex + self.menuMargin * (CGFloat)(_currentPageIndex + 1) + self.startingMenuMargin;
            _selectionIndicatorView.frame =  CGRectMake(selectionIndicatorX, self.selectionIndicatorView.frame.origin.y, self.selectionIndicatorView.frame.size.width, self.selectionIndicatorView.frame.size.height);
            
            // Recalculate frame for menu items if centered
            NSInteger index = 0;
            
            for (MenuItemView *item in _mutableMenuItems) {
                if (index == 0) {
                    item.frame = CGRectMake(_startingMenuMargin + _menuMargin, 0.0, _menuItemWidth, _menuHeight);
                } else {
                    item.frame = CGRectMake(_menuItemWidth * (CGFloat)index + _menuMargin * (CGFloat)index + 1.0 + _startingMenuMargin, 0.0, _menuItemWidth, _menuHeight);
                }
                
                index++;
            }
        }
        
        for (UIView *view in _controllerScrollView.subviews) {
            view.frame = CGRectMake(self.view.frame.size.width * (CGFloat)(_currentPageIndex), _menuHeight, _controllerScrollView.frame.size.width, self.view.frame.size.height - _menuHeight);
        }
        
        CGFloat xOffset = (CGFloat)(self.currentPageIndex) * _controllerScrollView.frame.size.width;
        [_controllerScrollView setContentOffset:CGPointMake(xOffset, _controllerScrollView.contentOffset.y)];
        
        CGFloat ratio = (_menuScrollView.contentSize.width - self.view.frame.size.width) / (_controllerScrollView.contentSize.width - self.view.frame.size.width);
        
        if (_menuScrollView.contentSize.width > self.view.frame.size.width) {
            CGPoint offset = _menuScrollView.contentOffset;
            offset.x = _controllerScrollView.contentOffset.x * ratio;
            [_menuScrollView setContentOffset:offset animated:NO];
        }
    }
    
    // Hsoi 2015-02-05 - Running on iOS 7.1 complained: "'NSInternalInconsistencyException', reason: 'Auto Layout
    // still required after sending -viewDidLayoutSubviews to the view controller. ViewController's implementation
    // needs to send -layoutSubviews to the view to invoke auto layout.'"
    //
    // http://stackoverflow.com/questions/15490140/auto-layout-error
    //
    // Given the SO answer and caveats presented there, we'll call layoutIfNeeded() instead.
    [self.view layoutIfNeeded];
}

// MARK: - Move to page index

/**
 Move to page at index
 
 :param: index Index of the page to move to
 */
- (void)moveToPage:(NSInteger)index
{
    if (index >= 0 && index < _controllerArray.count) {
        // Update page if changed
        if (index != _currentPageIndex) {
            _startingPageForScroll = index;
            _lastPageIndex = _currentPageIndex;
            _currentPageIndex = index;
            _didTapMenuItemToScroll = YES;
            
            // Add pages in between current and tapped page if necessary
            NSInteger smallerIndex = _lastPageIndex < _currentPageIndex ? _lastPageIndex : _currentPageIndex;
            NSInteger largerIndex = _lastPageIndex > _currentPageIndex ? _lastPageIndex : _currentPageIndex;
            
            if (smallerIndex + 1 != largerIndex) {
                for (NSInteger i=smallerIndex + 1; i<largerIndex; i++) {
                    
                    if (![_pagesAddedSet containsObject:@(i)]) {
                        [self addPageAtIndex:i];
                        [_pagesAddedSet addObject:@(i)];
                    }
                }
            }
            [self addPageAtIndex:index];
            
            // Add page from which tap is initiated so it can be removed after tap is done
            [_pagesAddedSet addObject:@(_lastPageIndex)];
        }
        
        // Move controller scroll view when tapping menu item
        double duration = (double)(_scrollAnimationDurationOnMenuItemTap) / (double)(1000);
        
        [UIView animateWithDuration:duration animations:^{
            CGFloat xOffset = (CGFloat)index * self.controllerScrollView.frame.size.width;
            [self.controllerScrollView setContentOffset:CGPointMake(xOffset, self.controllerScrollView.contentOffset.y) animated:NO];
        }];
        
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}


// MARK: Getter
- (NSArray *)menuItems
{
    return _mutableMenuItems;
}

- (NSArray *)menuItemWidths
{
    return _mutableMenuItemWidths;
}

@end
