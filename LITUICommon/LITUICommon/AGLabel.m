//
//  AGLabel.m
//  AboveGEM
//
//  Created by traintrackcn on 14/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGLabel.h"

@implementation AGLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets;
    if (UIEdgeInsetsEqualToEdgeInsets(self.edgeInsets, UIEdgeInsetsZero)){
        CGFloat padding = 8.0;
        insets = UIEdgeInsetsMake(0, padding, 0, padding);
    }else{
        insets = self.edgeInsets;
    }
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
