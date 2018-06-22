//
//  AGVCGlobalDefine.h
//  AGUIKit
//
//  Created by Tao Yunfei on 7/29/15.
//  Copyright (c) 2015 AboveGEM. All rights reserved.
//

@import LITCommon;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AGStyleCoordinator.h"

#define UI [AGUIDefine singleton]
#define COLOR(aValue) [[AGStyleCoordinator singleton] colorForValue:aValue]
#define RGB(aValue) [[AGStyleCoordinator singleton] rgbForValue:aValue]
#define SET_COLOR(aKey, aValue) [UI setColor:aKey value:aValue]

//sizes
#define STYLE_NAVIGATION_BAR_HEIGHT 44.0
#define STYLE_STATUS_BAR_HEIGHT 20.0
#define STYLE_TAB_BAR_HEIGHT 50.0
#define STYLE_DEVICE_WIDTH [DSDeviceUtil bounds].size.width
#define STYLE_DEVICE_HEIGHT [DSDeviceUtil bounds].size.height
#define STYLE_DEVICE_CONTENT_HEIGHT STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT-STYLE_TAB_BAR_HEIGHT
#define STYLE_DEVICE_CONTENT_HEIGHT_WITH_STATUS_BAR_AND_NAVIGATION_BAR STYLE_DEVICE_HEIGHT-STYLE_NAVIGATION_BAR_HEIGHT-STYLE_STATUS_BAR_HEIGHT
#define STYLE_PADDING_LR_DEFAULT 15.0


//fonts
#define FONT_WITH_SIZE(aSize) [UIFont fontWithName:UI.fontNameDefault size:aSize]
#define FONT_BOLD_WITH_SIZE(aSize) [UIFont fontWithName:UI.fontNameBold size:aSize]
#define FONT_LIGHT_WITH_SIZE(aSize) [UIFont fontWithName:UI.fontNameLight size:aSize]
#define FONT_REGULAR_WITH_SIZE(aSize) [UIFont fontWithName:UI.fontNameRegular size:aSize]
#define FONT_MEDIUM_WITH_SIZE(aSize) [UIFont fontWithName:UI.fontNameMedium size:aSize]

//base colors
#define RGB_WHITE @"255,255,255"
#define RGB_BLACK @"0,0,0"
#define RGB_DUMMY RGB_BLACK

//header colors
#define RGB_HEADER @"RGB_HEADER|162,162,162"

//title colors
#define RGB_TITLE_DARK @"RGB_TITLE_DARK"
#define RGB_TITLE @"RGB_TITLE|37,37,37"
#define RGB_TITLE_LIGHT @"RGB_TITLE_LIGHT|153,153,153"

//subtitle colors
#define RGB_SUBTITLE @"RGB_SUBTITLE"
#define RGB_CHECK_BOX_ON_TINT @"RGB_CHECK_BOX_ON_TINT"
#define RGB_CHECK_BOX_ON_FILL @"RGB_CHECK_BOX_ON_FILL"

#define RGB_IMPORTANT @"RGB_IMPORTANT"

#define RGB_BORDER @"RGB_BORDER|242,242,242"

#define RGB_BACKGROUND_NORMAL @"RGB_BACKGROUND_NORMAL|252,252,252"

#define RGB_THEME @"RGB_THEME"
#define RGB_THEME_FOR_CONTROL @"RGB_THEME_FOR_CONTROL"

#define RGB_AVC_FAILURE_MESSAGE_TITLE @"RGB_AVC_FAILURE_MESSAGE_TITLE|117,55,55"
#define RGB_AVC_FAILURE_MESSAGE_BACKGROUND @"RGB_AVC_FAILURE_MESSAGE_BACKGROUND|254,207,208"
#define RGB_AVC_SUCCESS_MESSAGE_TITLE @"RGB_AVC_SUCCESS_MESSAGE_TITLE|37,108,18"
#define RGB_AVC_SUCCESS_MESSAGE_BACKGROUND @"RGB_AVC_SUCCESS_MESSAGE_BACKGROUND|204,251,204"
#define RGB_AVC_LOADING_MESSAGE_TITLE @"RGB_AVC_LOADING_MESSAGE_TITLE|RGB_TITLE_LIGHTER"
#define RGB_AVC_LOADING_MESSAGE_BACKGROUND @"RGB_AVC_LOADING_MESSAGE_BACKGROUND|RGB_WHITE"
#define RGB_FLOATING_MESSAGE_BACKGROUND @"RGB_FLOATING_MESSAGE_BACKGROUND|RGB_BLACK"
#define RGB_FLOATING_MESSAGE @"RGB_FLOATING_MESSAGE|RGB_WHITE"

@interface AGUIDefine : NSObject

- (BOOL)sessionRoleIsRetailCustomer;
- (NSString *)sessionRoleCode;
- (void)setColor:(NSString *)key value:(NSString *)value;


@property (nonatomic, strong) Class loginViewControllerClass;
@property (nonatomic, strong) NSArray *availableLanguages;
@property (nonatomic, strong) UINavigationController *rootViewController;
@property (nonatomic, copy) BOOL (^sessionRoleIsRetailCustomerBlock)(void);
@property (nonatomic, copy) NSString *(^sessionRoleCodeBlock)(void);


#pragma mark - fonts

@property (nonatomic, strong) NSString *fontNameDefault;
@property (nonatomic, strong) NSString *fontNameBold;
@property (nonatomic, strong) NSString *fontNameLight;
@property (nonatomic, strong) NSString *fontNameRegular;
@property (nonatomic, strong) NSString *fontNameMedium;


#pragma mark - common colors
//@property (nonatomic, strong) NSString *RGB_THEME;
@property (nonatomic, strong) NSString *RGB_DISABLED;

#pragma mark - title colors
@property (nonatomic, strong) NSString *RGB_TITLE_NORMAL;
//@property (nonatomic, strong) NSString *RGB_TITLE_LIGHT;
@property (nonatomic, strong) NSString *RGB_TITLE_LIGHTER;

#pragma mark - border colors
@property (nonatomic, strong) NSString *RGB_BORDER_DARKER;
//@property (nonatomic, strong) NSString *RGB_BORDER;

#pragma mark - tab bar colors
@property (nonatomic, strong) NSString *RGB_TAB_BAR_BACKGROUND;
@property (nonatomic, strong) NSString *RGB_TAB_BAR_NORMAL;

#pragma mark - cell colors
@property (nonatomic, strong) NSString *RGB_CELL_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_TITLE_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_CONTENT_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_CONTENT_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_CELL_BACKGROUND_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_CELL_BORDER;


#pragma mark - input colors
@property (nonatomic, strong) NSString *RGB_INPUT_NORMAL;
@property (nonatomic, strong) NSString *RGB_INPUT_STAR;
@property (nonatomic, strong) NSString *RGB_INPUT_TITLE;
@property (nonatomic, strong) NSString *RGB_INPUT_CURSOR;
@property (nonatomic, strong) NSString *RGB_INPUT_ICON;

#pragma mark - line progress colors
@property (nonatomic, strong) NSString *LINE_PROGRESS_TITLE;
@property (nonatomic, strong) NSString *LINE_PROGRESS_SUBTITLE;

#pragma mark - button colors
@property (nonatomic, strong) NSString *RGB_BUTTON_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_BUTTON_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_BUTTON_TITLE_DISABLED;
@property (nonatomic, strong) NSString *RGB_BUTTON_BORDER;

#pragma mark - header colors
@property (nonatomic, strong) NSString *RGB_HEADER_BORDER;
@property (nonatomic, strong) NSString *RGB_HEADER_BACKGROUND;

#pragma mark - option colors
@property (nonatomic, strong) NSString *RGB_OPTION_BACKGROUND_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_OPTION_BACKGROUND_NORMAL;
@property (nonatomic, strong) NSString *RGB_OPTION_TITLE_HIGHLIGHT;
@property (nonatomic, strong) NSString *RGB_OPTION_TITLE_NORMAL;
@property (nonatomic, strong) NSString *RGB_OPTION_BORDER;

@end
