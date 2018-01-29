//
//  DAIconMinus.m
//  Distributors
//
//  Created by Tao Yunfei on 12/25/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "DAIconMinus.h"
#import "DSImage.h"

@interface DAIconMinus(){
    
}

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UIView *hLineView;

@end

@implementation DAIconMinus

+ (UIImage *)imageInstanceWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth padding:(CGFloat)padding{
    DAIconMinus *icon = [[DAIconMinus alloc] initWithSize:size lineWidth:lineWidth padding:padding];
    return [DSImage imageWithView:icon];
}

- (instancetype)initWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth padding:(CGFloat)padding{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        [self setLineWidth:lineWidth];
        [self setPadding:padding];
        
        [self addSubview:self.hLineView];
    }
    return self;
}

#pragma mark - components


- (UIView *)hLineView{
    if (!_hLineView) {
        CGFloat y = (self.frame.size.height - self.lineWidth)/2.0;
        
        CGFloat x = self.padding;
        CGFloat w = self.frame.size.width - x*2;
        
        _hLineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, self.lineWidth)];
        [_hLineView setBackgroundColor:[UIColor whiteColor]];
    }
    return _hLineView;
}

@end
