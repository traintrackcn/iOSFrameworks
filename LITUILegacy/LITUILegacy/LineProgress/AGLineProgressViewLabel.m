//
//  AGProgressViewLabel.m
//  AboveGEM
//
//  Created by traintrackcn on 29/12/14.
//
//

#import "AGLineProgressViewLabel.h"

@implementation AGLineProgressViewLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    CGFloat padding = 8.0;
    UIEdgeInsets insets = {0, padding, 0, padding};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}


@end
