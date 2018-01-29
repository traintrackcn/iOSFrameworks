//
//  DAButtonFactory.m
//  Distributors
//
//  Created by Tao Yunfei on 1/6/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "DAButtonFactory.h"
#import "DAButtonItem.h"

@interface DAButtonFactory(){
    
}

@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, strong) UIColor *defaultBackgroundColor;
@property (nonatomic, assign) BOOL uppercase;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation DAButtonFactory

#pragma mark -

+ (UIButton *)buttonInstanceWithItem:(DAButtonItem *)item{
    NSString *title = item.title;
    id target = item.target;
    SEL action = item.action;
    return [self buttonInstanceWithTitle:title target:target action:action backgroundColor:item.color];
}

+ (UIButton *)buttonInstanceWithTitle:(NSString *)title target:(id)target action:(SEL)action backgroundColor:(UIColor *)backgroundColor{
    UIButton *btn = [[UIButton alloc] init];
    if ([self uppercase]) title = [title uppercaseString];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if ([self cornerRadius])   [btn.layer setCornerRadius:[self cornerRadius]];
    [btn setClipsToBounds:YES];
    [btn.titleLabel setFont:[self defaultFont]];
    [btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateDisabled];
    
    UIColor *normalStateBgColor = backgroundColor?backgroundColor:[[self singleton] defaultBackgroundColor];
    UIImage *normalStateBgImage = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:normalStateBgColor];
    
    [btn setBackgroundImage:normalStateBgImage forState:UIControlStateNormal];
    [btn setBackgroundImage:[self backgroundImageForState:UIControlStateDisabled] forState:UIControlStateDisabled];
    return btn;
}

#pragma mark - styles

+ (UIImage *)backgroundImageForState:(UIControlState)state{
    
    //    TLOG(@"state -> %d", state);
    
    
    UIImage *img = [[UIImage alloc] init];
    
    if (state == UIControlStateDisabled) {
        img = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:RGBA(217, 217, 217, 1)];
    }
    
    if (state == UIControlStateNormal) {
        img = [DSImage rectangleWithSize:CGSizeMake(1, 1) fillColor:[[self singleton] defaultBackgroundColor]];
    }
    
    return img;
    
}

#pragma mark - properties

+ (UIFont *)defaultFont{
    return [[self singleton] defaultFont];
}

+ (CGFloat)cornerRadius{
    return [[self singleton] cornerRadius];
}

+ (BOOL)uppercase{
    return [[self singleton] uppercase];
}

+ (void)setUppercase:(BOOL)uppercase{
    [[self singleton] setUppercase:uppercase];
}

+ (void)setCornerRadius:(CGFloat)corerRadius{
    [[self singleton] setCornerRadius:corerRadius];
}

+ (void)setDefaultFont:(UIFont *)font{
    [[self singleton] setDefaultFont:font];
}

+ (void)setDefaultBackgroundColor:(UIColor *)color{
    [[self singleton] setDefaultBackgroundColor:color];
}

@end
