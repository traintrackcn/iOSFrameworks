//
//  AGDatePicker.m
//  AboveGEM
//
//  Created by traintrackcn on 9/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;

#import "AGSelector.h"
#import "AGViewController.h"
#import "AGVCConfiguration.h"
#import "AGAssembler.h"

//#import "DSValueUtil.h"
#import "DSLayoutUtil.h"


@interface AGSelector (){
    UIView *buttonC;
    UIView *layoutV;
    UILabel *titleV;
    UIView *contentV;
    
    CGFloat statusBarH;
    CGFloat naviBarH;
    CGFloat statusPlusNaviH;
}

@end

@implementation AGSelector


- (id)init{
    self = [super init];
    if (self) {
//        btnH = 44;
        paddingLR = 8.0;
        paddingTB = 4.0;
        statusBarH = 20.0;
        naviBarH = 44.0;
        statusPlusNaviH = statusBarH + naviBarH;
        [self assemble];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    TLOG(@"self.navigationController -> %@", self.navigationController );
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - assemblers

- (void)assemble{
    [self assembleLayoutView];
    [self assembleTitleView];
    [self assembleButtonContainer];
}

- (void)assembleLayoutView{
    layoutV = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [layoutV setBackgroundColor:[UIColor whiteColor]];
    [self setView:layoutV];
}

- (void)assembleTitleView{
    CGFloat x = 10;
    CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
    titleV = [[UILabel alloc] initWithFrame:CGRectMake(x, 30, w, 40)];
    [titleV setTextAlignment:NSTextAlignmentCenter];
    [titleV setFont:[UIFont systemFontOfSize:24]];
    [titleV setTextColor:COLOR(RGB_THEME)];
    [layoutV addSubview:titleV];
}

- (void)assembleButtonContainer{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat y = (self.view.frame.size.height - AG_BUTTON_HEIGHT - AG_BUTTON_SPACING );
//    TLOG(@"self.view.frame.size.height  -> %f", self.view.frame.size.height );
    if (![DSDeviceUtil iOS7AndAbove]) {
        y -= 20;
    }
    buttonC = [[UIView alloc] initWithFrame:CGRectMake(0, y, bounds.size.width, AG_BUTTON_HEIGHT)];
    [layoutV addSubview:buttonC];
}

#pragma mark - kinds of content views

- (void)setTitle:(NSString *)title{
    [titleV setText:title];
    [super setTitle:title];
}

- (void)setContentView:(UIView *)v{
    if ([DSValueUtil isAvailable:contentV])  [contentV removeFromSuperview];
    contentV = v;
    CGRect bounds = [DSDeviceUtil bounds];
    [layoutV addSubview:contentV];
    CGFloat y = titleV.frame.origin.y+ titleV.frame.size.height + AG_BUTTON_SPACING;
    CGFloat h =  bounds.size.height - y- AG_BUTTON_SPACING - AG_BUTTON_HEIGHT - AG_BUTTON_SPACING;
    [contentV setFrame:CGRectMake(([DSDeviceUtil bounds].size.width-contentV.frame.size.width)/2,y, contentV.frame.size.width, h)];
}

- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector{

    [buttonC addSubview: [AGAssembler assembleButtonWithTitle:title target:target selector:selector] ];
    
    [self layoutButtons];
   
}

- (void)layoutButtons{
    [DSLayoutUtil layoutButtons:buttonC.subviews];
}



#pragma mark - properties

- (UIView *)contentView{
    return contentV;
}

@end
