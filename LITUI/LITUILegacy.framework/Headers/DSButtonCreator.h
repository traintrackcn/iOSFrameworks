//
//  DSButtonCreator.h
//  og
//
//  Created by traintrackcn on 13-4-23.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class BBBadgeBarButtonItem;

@interface DSButtonCreator : NSObject

//+ (BBBadgeBarButtonItem *)createNavigationCartButtonWithTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem *)createNavigationBackButtonWithTarget:(id)target action:(SEL)action;

+ (void)updateButtonView:(UIView *)buttonV title:(NSString *)title atRight:(BOOL)atRight;
+ (UIBarButtonItem *)createNavigationBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action atRight:(BOOL)atRight;
+ (UIBarButtonItem *)createNavigationBarButtonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action;



+ (UIBarButtonItem *)closeBarButtonItemWithTarget:(id)target action:(SEL)action;

@end


