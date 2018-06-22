//
//  DSButtonCreator.m
//  og
//
//  Created by traintrackcn on 13-4-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

@import LITUICommon;

#import "DSButtonCreator.h"

@implementation DSButtonCreator

+ (UIBarButtonItem *)createNavigationBackButtonWithTarget:(id)target action:(SEL)action{
    
    return  [self createNavigationBarButtonWithImageNamed:@"BackgroundBackButton" target:target action:action];
}


+ (UIBarButtonItem *)createNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action atRight:(BOOL)atRight{
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return barBtnItem;
    
//    UIView *buttonC = [self createButtonViewForNavigationBarWithTitle:title target:target action:action atRight:atRight];
//    return  [[UIBarButtonItem alloc] initWithCustomView:buttonC];
}

+ (UIBarButtonItem *)createNavigationBarButtonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action{
    UIImage *img = [UIImage imageNamed:imageName];
    img = [DSImage image:img withMaskColor:COLOR(UI.RGB_BUTTON_BACKGROUND_NORMAL)];
    UIBarButtonItem *menuBarItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:target action:action];
    return menuBarItem;
    
}



+ (void)updateButtonView:(UIView *)buttonV title:(NSString *)title atRight:(BOOL)atRight{
    CGPoint offset = CGPointMake(0, 0);
    
    if ([DSDeviceUtil iOS7AndAbove]) {
        if (atRight) {
            offset.x = 10;
        }else{
            offset.x = -10;
        }
    }
    
    CGRect f = [self buttonFrameWithTitle:title];
    UIView *btn = [[buttonV subviews] objectAtIndex:0];
    [btn setFrame:f];
    
    
    CGRect buttonVFrame = buttonV.frame;
    buttonVFrame.size = btn.frame.size;
    [buttonV setFrame:buttonVFrame];
    
    
    CGRect bounds = buttonV.bounds;
//    TLOG(@"bounds width:%f height:%f bounds x:%f", bounds.size.width, bounds.size.height, bounds.origin.x);
    bounds.origin = CGPointMake(-offset.x, -offset.y);
    buttonV.bounds = bounds;
    
}

+ (CGRect)buttonFrameWithTitle:(NSString *)title{
    CGRect frame;
    UIFont *f = [UIFont systemFontOfSize:14];
    CGSize s = [title sizeWithAttributes:@{NSFontAttributeName:f}];
    s.width = s.width + 12.0f*2.0f;
    s.height = 32.0f;
    frame.size = s;
    frame.origin = CGPointZero;
    return frame;
}



+ (void)enableBarButtonItem:(UIBarButtonItem *)btnItem{
    @try {
        UIView *btnC = [btnItem customView];
        UIButton *btn = (UIButton *)[btnC.subviews objectAtIndex:0];
        [btn setEnabled:YES];
    }@catch (NSException *exception) {
//        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
}

//+ (void)enableButton:(UIButton *){
//    
//}

+ (void)disableBarButtonItem:(UIBarButtonItem *)btnItem{
    @try {
        UIView *btnC = [btnItem customView];
        UIButton *btn = (UIButton *)[btnC.subviews objectAtIndex:0];
        [btn setEnabled:NO];
    } @catch (NSException *exception) {
//        [[DSCrashReporterManager sharedInstance] logException:exception];
    }
}

+ (UIBarButtonItem *)closeBarButtonItemWithTarget:(id)target action:(SEL)action{
    UIImage *img = [UIImage imageNamed:@"IconClose"];
    img = [DSImage image:img withMaskColor:COLOR(UI.RGB_BUTTON_BACKGROUND_NORMAL)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:target action:action];
    return barBtnItem;
    
    
}


@end
