//
//  AGDashboardNextComponentNumberBox.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/27/15.
//
//

#import "AGNumberBox.h"


@interface AGNumberBox(){
    
}

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIView *vSeparatorLine;


@property (nonatomic, assign) BOOL subtitleEnabled;


@end

@implementation AGNumberBox

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self assemble];
//        [AGDebugUtil makeBorderForView:self];
    }
    return self;
}


- (void)assemble{
    [self addSubview:self.numberLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.vSeparatorLine];
    
}

#pragma mark - setters

- (void)setValue:(id)value{
    _value = value;
    
    if ([value isKindOfClass:[NSArray class]]) {
        NSArray *arr = (NSArray *)value;
        [self.numberLabel setText:[NSString stringWithFormat:@"%@", arr.firstObject]];
        [self.subtitleLabel setText:[NSString stringWithFormat:@"%@", arr.lastObject]];
        
        [self setSubtitleEnabled:YES];
    }else{
        [self.numberLabel setText:[NSString stringWithFormat:@"%@", value]];
        [self.subtitleLabel setText:@""];
        
        [self setSubtitleEnabled:NO];
    }
    
    [self layoutLabels];
    
}

#pragma mark - layout

- (void)layoutLabels{
    [self layoutNumberLabel];
    [self layoutVSeparatorLine];
    [self layoutSubtitle];
}

- (void)layoutNumberLabel{
    CGFloat x = 0;
//    CGFloat y = self.paddingTB;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.numberH;
    CGFloat y = (self.frame.size.height - h)/2.0;
    
    if (self.subtitleEnabled) {
        y = (self.frame.size.height - h - self.subtitleH)/2.0;
    }
    
    [self.numberLabel setFrame:CGRectMake(x, y, w, h)];
}

- (void)layoutSubtitle{
    CGFloat x = 0;
    CGFloat h = self.subtitleH;
    CGFloat y = self.numberLabel.frame.origin.y + self.numberLabel.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    [self.subtitleLabel setFrame:CGRectMake(x, y, w, h)];
}

- (void)layoutVSeparatorLine{
    CGFloat x = self.frame.size.width + .5f;
    CGFloat y = self.numberLabel.frame.origin.y + self.vSeparatorOffset;
    CGFloat w = .5f;
    CGFloat h = self.numberLabel.frame.size.height - self.vSeparatorOffset * 2;
    
    if (self.subtitleEnabled) {
        h = (self.numberLabel.frame.size.height + self.subtitleH) - self.vSeparatorOffset * 2;
    }
    
    [self.vSeparatorLine setFrame:CGRectMake(x, y, w, h)];
}



#pragma mark - components

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        [_numberLabel setFont:self.numberFont];
        [_numberLabel setTextColor:self.numberColor];
        [_numberLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberLabel setAdjustsFontSizeToFitWidth:YES];
//        [AGDebugUtil makeBorderForView:_numberLabel];
        [_numberLabel setText:@"9999.99"];
    }
    return _numberLabel;
}


- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        
        _subtitleLabel = [[UILabel alloc] init];
        [_subtitleLabel setFont:self.subtitleFont];
        [_subtitleLabel setTextColor:self.subtitleColor];
        [_subtitleLabel setTextAlignment:NSTextAlignmentCenter];
//        [AGDebugUtil makeBorderForView:_subtitleLabel];
        [_subtitleLabel setText:@"Subtitle"];
    }
    return _subtitleLabel;
}

- (UIView *)vSeparatorLine{
    if (!_vSeparatorLine) {
        
        
        _vSeparatorLine = [[UIView alloc] init];
        [_vSeparatorLine setBackgroundColor:[UIColor whiteColor]];
    }
    return _vSeparatorLine;
}

#pragma mark - styles

- (CGFloat)paddingTB{
    return 8.0;
}

- (CGFloat)numberH{
    return 46.0;
}

- (CGFloat)subtitleH{
    return 16;
}

- (CGFloat)vSeparatorOffset{
    return 4.0;
}

- (UIColor *)subtitleColor{
    return [UIColor whiteColor];
}

- (UIFont *)subtitleFont{
    return [UIFont systemFontOfSize:12];
}

- (UIColor *)numberColor{
    return [UIColor whiteColor];
}

- (UIFont *)numberFont{
    return [UIFont systemFontOfSize:36];
}

@end
