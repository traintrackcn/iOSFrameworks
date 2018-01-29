//
//  AGMultiValueCellLabel.m
//  AboveGEM
//
//  Created by traintrackcn on 4/1/15.
//
//

#import "AGMultiValueCellLabel.h"

@implementation AGMultiValueCellLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [AGDebugUtil makeBorderForView:self];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    CGFloat padding = 8;
    UIEdgeInsets insets = {0, padding, 0, padding};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
