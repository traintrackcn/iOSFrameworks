//
//  AGTrasnparentTextfieldCell.m
//  AboveGEM
//
//  Created by traintrackcn on 8/12/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGFancyTextfieldCell.h"
#import "NSObject+TextInputComponents.h"

@interface AGFancyTextfieldCell() <UITextFieldDelegate, UITextViewDelegate>{
    
}

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation AGFancyTextfieldCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.inputField];
    }
    return self;
}

- (CGFloat)paddingLR{
    return 16.0;
}

- (CGFloat)separatorH{
    return 16.0;
}



- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
//    [super applyUnselectedStyle];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - setters

- (void)setValue:(id)value{
    [super setValue:value];
    [self.inputField setText:[DSValueUtil toString:value]];
}

#pragma mark - texts

- (UITextField *)inputField{
    if (!_inputField) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = self.frame.size.width - x*2;
        CGFloat h = self.height;
        _inputField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_inputField setDelegate:self];
        [_inputField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        
        //    [self.inputField setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 8)]];
        //    [self.inputField setRightViewMode:UITextFieldViewModeAlways];
        [_inputField setTextAlignment:NSTextAlignmentLeft];
        [_inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_inputField setTextColor:self.contentColor];
        [_inputField setAdjustsFontSizeToFitWidth:YES];
        [_inputField.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_inputField.layer setBorderWidth:1.0];
        [_inputField.layer setCornerRadius:6.0];
        [_inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_inputField setLeftView:self.leftView];
        [_inputField setLeftViewMode:UITextFieldViewModeAlways];
        
//        [self setPlaceholder:@"Placeholder"];
        [_inputField setDelegate:self.textInputDelegate];
        
    }
    return _inputField;
}

- (void)setPlaceholder:(NSString *)placeholder{
    if ([self.inputField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
//        UIColor *color = [UIColor whiteColor];
        self.inputField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
    }
}

- (void)setIconByName:(NSString *)iconName{
    UIImage *img = [UIImage imageNamed:iconName];
    img = [DSImage image:img withMaskColor:self.iconColor];
//    TLOG(@"");
    [self.iconView setImage:img];
    
}

- (UIColor *)placeholderColor{
    return [UIColor whiteColor];
}

- (UIColor *)iconColor{
    return [UIColor whiteColor];
}

- (UIColor *)contentColor{
    return [UIColor whiteColor];
}

- (CGFloat)iconW{
    return 20.0;
}

- (UIView *)leftView{
    if (!_leftView) {
        CGFloat padding = (self.height - self.iconW)/2.0;
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.height + padding, self.height)];
//        [AGDebugUtil makeBorderForView:_leftView];
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//        [v setBackgroundColor:[UIColor redColor]];
//        TLOG(@"self.iconView -> %@", self.iconView);
        [_leftView addSubview:self.iconView];
        [_leftView addSubview:self.separatorView];
    }
    return _leftView;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        CGFloat x = (self.height - self.iconW)/2.0;
        CGFloat y = (self.height - self.iconW)/2.0;
//        TLOG(@"iconW -> %f", self.iconW);
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, self.iconW, self.iconW)];
//        [AGDebugUtil makeBorderForView:_iconView];
        [_iconView setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    return _iconView;
}

- (UIView *)separatorView{
    if (!_separatorView) {
        CGFloat x = self.height;
        CGFloat y = (self.height - self.separatorH)/2.0;
        CGFloat h = self.separatorH;
        _separatorView = [[UIView alloc] initWithFrame:CGRectMake(x, y, 1, h)];
        [_separatorView setBackgroundColor:[UIColor whiteColor]];
    }
    return _separatorView;
}

@end
