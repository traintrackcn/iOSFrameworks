//
//  AGCellInnerView.m
//  AboveGEM
//
//  Created by Tao Yunfei on 6/24/15.
//
//

@import LITCommon;

#import "AGCellInnerView.h"
//#import "GlobalDefine.h"
//#import "DSDeviceUtil.h"

@implementation AGCellInnerView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self determineToAssembleByFrame:frame];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self determineToAssembleByFrame:frame];
}

- (void)determineToAssembleByFrame:(CGRect)frame{
    if (!CGRectIsEmpty(frame)) {
        [self assemble];
    }
}

- (void)assemble{
    
}

#pragma mark - utils

- (UIView *)borderViewInstance{
    UIView *borderView = [[UIView alloc] init];
    [borderView setBackgroundColor:self.borderColor];
    return borderView;
}

#pragma mark - styles

- (CGFloat)paddingLR{
    return 15.0;
}

- (UIColor *)borderColor{
    return RGBA(221, 221, 221, 1);
}

- (CGFloat)borderWidth{
    return .5f;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)width{
    return [DSDeviceUtil bounds].size.width;
}

@end
