//
//  AGTextfieldCellStyleLong.m
//  AGUIKit
//
//  Created by Tao Yunfei on 11/18/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "AGTextfieldCellStyleLong.h"
#import "NSObject+TextInputComponents.h"

@implementation AGTextfieldCellStyleLong

+ (CGFloat)height{
    return 103.0;
}

- (void)assembleInputField{
    [super assembleInputField];
    [self.inputField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)]];
    [self.inputField setLeftViewMode:UITextFieldViewModeAlways];
    [self.inputField setTextAlignment:NSTextAlignmentLeft];
    [self.inputField.layer setBorderWidth:1.0];
    [self.inputField setDelegate:self.textInputDelegate];
//    [self enableNumberPadForInputField];
    
    //accessory view
    
    
}

- (void)layoutInputField{
    CGRect titleFrame = titleLabel.frame;
    CGSize titleSize = titleFrame.size;
    CGFloat paddingBottom = (self.titleMaxH - titleSize.height)/2.0;
    //    TLOG(@"paddingBottom -> %f", paddingBottom);
    //resize input box
    CGFloat h = [self.class height] - self.titleMaxH - paddingBottom;
    CGFloat w = self.frame.size.width - self.paddingLR*2;
    CGRect frame = CGRectMake(self.paddingLR, self.titleMaxH, w, h);
    //    frame.size = CGSizeMake(frame.size.width, h);
    [self.inputField setFrame:frame];
}

@end
