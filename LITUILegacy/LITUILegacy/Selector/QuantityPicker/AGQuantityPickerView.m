//
//  AGQuantityPickerView.m
//  AboveGEM
//
//  Created by traintrackcn on 18/3/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGQuantityPickerView.h"
#import "LITInteractivePanelView.h"

static const NSInteger AG_MAX_QUANTITY = 99;
static const NSInteger AG_MIN_QUANTITY = 0;

@interface AGQuantityPickerView()<LITInteractivePanelViewDelegate>{
    
}

@property (nonatomic, assign) CGSize componentSize;
@property (nonatomic, strong) UIButton *plusV;
@property (nonatomic, strong) UIButton *minusV;
@property (nonatomic, strong) UILabel *quantityL;
@property (nonatomic, strong) LITInteractivePanelView *interactiveV;


@end

@implementation AGQuantityPickerView

+ (instancetype)instanceWithValue:(NSInteger)value{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:AG_MIN_QUANTITY];
    [instance setMaxValue:AG_MAX_QUANTITY];
    [instance setValue:value];
    return instance;
}

+ (instancetype)instanceWithValue:(NSInteger)value maxValue:(NSInteger)maxValue{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:AG_MIN_QUANTITY];
    [instance setMaxValue:maxValue];
    [instance setValue:value];
    return instance;
}

+ (instancetype)instanceWithValue:(NSInteger)value minValue:(NSInteger)minValue{
    AGQuantityPickerView *instance = [[AGQuantityPickerView alloc]  initWithFrame:CGRectMake(0, 0, 120, 40)];
    [instance setMinValue:minValue];
    [instance setMaxValue:AG_MAX_QUANTITY];
    [instance setValue:value];
    return instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.plusV];
        [self addSubview:self.minusV];
        [self addSubview:self.quantityL];
        [self addSubview:self.interactiveV];
        
        [self.layer setBorderWidth:1];
        [self.layer setCornerRadius:4.0];
        [self.layer setBorderColor:self.borderColor.CGColor];
        
//        self.interactiveV.layer.borderWidth = 1;
//        [self.interactiveV setBackgroundColor:[[UIColor blueColor] colorWithAlphaComponent:.5]];

    }
    return self;
}

#pragma mark - setters

- (void)setValue:(NSInteger)value{
    [self.quantityL setText:[NSString stringWithFormat:@"%ld",(long)value]];
    [self dispatchDidChangeValue:value];
    [self refreshButtons];
}

- (void)setValueWitoutNotification:(NSInteger)value{
    [self.quantityL setText:[NSString stringWithFormat:@"%ld",(long)value]];
    [self refreshButtons];
}

- (void)setMaxValue:(NSInteger)maxValue{
    _maxValue = maxValue;
    [self refreshButtons];
}

- (void)setMinValue:(NSInteger)minValue{
    _minValue = minValue;
    [self refreshButtons];
}


#pragma mark - main ops


- (void)plus{
    //    TLOG(@"");
    NSInteger valueOld = self.value;
    NSInteger valueNew = valueOld+1;
    if (valueNew > self.maxValue) valueNew = self.maxValue;
    
//        TLOG(@"value -> %@ valueNew -> %@ valueMax -> %@", valueOld, valueNew, self.maxValue);
    
    if (valueNew != self.value) {
        if (![self dispatchWillChangeValue:valueNew]){
            return;
        }
    }
    
    [self setValue:valueNew];
    
}

- (void)minus{
    NSInteger valueOld = self.value;
    NSInteger valueNew = valueOld-1;
    if (valueNew < self.minValue) valueNew = self.minValue;
    
    if (valueNew != self.value) {
        if (![self dispatchWillChangeValue:valueNew]){
            return;
        }
            
    }
    [self setValue:valueNew];
}

- (void)refreshButtons{
    
    [self.minusV setEnabled:YES];
    [self.plusV setEnabled:YES];
    
//    TLOG(@"maxValue -> %d minValue -> %d value -> %d", self.maxValue, self.minValue, self.value);
    
    if (self.maxValue == self.minValue) {
        [self.minusV setEnabled:NO];
        [self.plusV setEnabled:NO];
        return;
    }
    
    if (self.value == self.maxValue) {
        [self.plusV setEnabled:NO];
        return;
    }
    
    if (self.value == self.minValue) {
        [self.minusV setEnabled:NO];
        return;
    }
}

#pragma mark - components

- (UIButton *)plusV{
    if (!_plusV) {
        _plusV = [self buttonViewWithTitle:@"+"];
        CGFloat x = self.frame.size.width - self.componentSize.width;
        CGFloat w = self.componentSize.width;
        CGFloat h = w;
        [_plusV setFrame:CGRectMake(x, 0, w, h)];
        [_plusV setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_plusV setTitleColor:self.borderColor forState:UIControlStateDisabled];
    }
    return _plusV;
}

- (UIButton *)minusV{
    if (!_minusV) {
        CGFloat w = self.componentSize.width;
        CGFloat h = self.componentSize.height;
        _minusV = [self buttonViewWithTitle:@"-"];
        [_minusV setFrame:CGRectMake(0, 0, w, h)];
        [_minusV setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_minusV setTitleColor:self.borderColor forState:UIControlStateDisabled];
    }
    return _minusV;
}

- (UILabel *)quantityL{
    if (!_quantityL) {
        CGFloat w = self.frame.size.width - self.componentSize.width*2;
        _quantityL = [[UILabel alloc] init];
        [_quantityL setTextAlignment:NSTextAlignmentCenter];
        [_quantityL setFrame:CGRectMake(self.componentSize.width, 0, w, self.componentSize.height)];
        [_quantityL setFont:FONT_WITH_SIZE(16)];
//        _quantityL.layer.borderWidth = 1;
//        _quantityL.layer.borderColor = self.borderColor.CGColor;
    }
    return _quantityL;
}

- (LITInteractivePanelView *)interactiveV{
    if (!_interactiveV){
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        _interactiveV = [[LITInteractivePanelView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        [_interactiveV setDelegate:self];
    }
    return _interactiveV;
}

- (UIButton *)buttonViewWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setUserInteractionEnabled:NO];
    
    return btn;
}

#pragma mark - properties

- (NSInteger)value{
    return [DSValueUtil toInteger:self.quantityL.text];
}

#pragma mark - styles

- (UIColor *)borderColor{
    return RGBA(214, 214, 214, 1);
}

- (CGSize)componentSize{
    if (CGSizeEqualToSize(_componentSize, CGSizeZero)) {
        _componentSize = CGSizeMake(self.frame.size.height, self.frame.size.height);
    }
    return _componentSize;
}

#pragma mark - interactive panel delegate

- (void)didTapRightInteractivePanel{
//    TLOG(@"");
    [self plus];
}

- (void)didTapLeftInteractivePanel{
//    TLOG(@"");
    [self minus];
}

#pragma mark - dispatchers

- (void)dispatchShouldChangeValue:(NSInteger)value{
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerViewShouldChangeValue:)]) {
        [_delegate quantityPickerViewShouldChangeValue:value];
    }
}

- (BOOL)dispatchWillChangeValue:(NSInteger)value{
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerViewWillChangeValue:)]) {
        return [_delegate quantityPickerViewWillChangeValue:value];
    }
    return YES;
}

- (void)dispatchDidChangeValue:(NSInteger)value{
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerViewDidChangeValue:)]) {
        [_delegate quantityPickerViewDidChangeValue:value];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(quantityPickerView:didChangeValue:)]) {
        [_delegate quantityPickerView:self didChangeValue:value];
    }
}


@end
