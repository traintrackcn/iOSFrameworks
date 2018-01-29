//
//  DAIconAdd.m
//  Distributors
//
//  Created by Tao Yunfei on 12/4/15.
//  Copyright © 2015 AboveGEM. All rights reserved.
//

#import "DAIconAdd.h"
#import "DSImage.h"

@interface DAIconAdd(){
    
}

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat padding;

@property (nonatomic, strong) UIView *vLineView;
@property (nonatomic, strong) UIView *hLineView;

@end

@implementation DAIconAdd


+ (UIImage *)imageInstanceWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth padding:(CGFloat)padding{
    DAIconAdd *icon = [[DAIconAdd alloc] initWithSize:size lineWidth:lineWidth padding:padding];
    return [DSImage imageWithView:icon];
}

- (instancetype)initWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth padding:(CGFloat)padding{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        [self setLineWidth:lineWidth];
        [self setPadding:padding];
        
        [self addSubview:self.vLineView];
        [self addSubview:self.hLineView];
    }
    return self;
}

#pragma mark - components

- (UIView *)vLineView{
    if (!_vLineView) {
        CGFloat x = (self.frame.size.width - self.lineWidth)/2.0;
        
        CGFloat y = self.padding;
        CGFloat h = self.frame.size.height - y*2;
        
        _vLineView = [[UIView alloc] initWithFrame:CGRectMake(x, y, self.lineWidth, h)];
        [_vLineView setBackgroundColor:[UIColor whiteColor]];
    }
    return _vLineView;
}

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
