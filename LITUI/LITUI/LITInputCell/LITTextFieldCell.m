//
//  AGAdvTextfieldCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 17/08/2017.
//
//

@import LITUICommon;
@import LITUILegacy;

#import "LITTextFieldCell.h"
#import "LITCell+Borders.h"

@interface LITTextFieldCell(){
    
}

@property (nonatomic, strong) JVFloatLabeledTextField *textF;

@end

@implementation LITTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self){
        [self.contentView addSubview:self.textF];
        [self initializeDefaultBorders];
    }
    return self;
}

#pragma mark - 


- (void)setTitle:(NSString *)title{
    [self _setTitle:title];
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:title
                                    attributes:@{NSForegroundColorAttributeName: COLOR(RGB_TITLE_LIGHT)}];
    [self.textF setAttributedPlaceholder:attributedStr];
}

- (void)setValue:(id)value{
//    if (!value) return;
    [self _setValue:value];
    [self.textF setText:[NSString stringWithFormat:@"%@", value]];
    
    [self layoutDefaultBordersByFlag];
}

- (void)setReadOnly:(BOOL)readOnly{
    [self.textF setEnabled:!readOnly];
}

- (BOOL)readOnly{
    return !self.textF.enabled;
}

#pragma mark - components

- (JVFloatLabeledTextField *)textF{
    if (!_textF){
        CGFloat x = self.paddingLR;
        CGFloat y = 9;
        CGFloat w = STYLE_DEVICE_WIDTH - x*2;
        CGFloat h = self.height - y*2;
        
        _textF = [[JVFloatLabeledTextField alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_textF setFont:FONT_WITH_SIZE(17.0)];
        [_textF setFloatingLabelFont:FONT_WITH_SIZE(15.0)];
        [_textF setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textF setDelegate:self.textInputDelegate];
        [_textF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//        [_textF setKeepBaseline:YES];
    }
    return _textF;
}



#pragma mark - styles

+ (CGFloat)height{
    return 60.0;
}

- (CGFloat)paddingLR{
    return STYLE_PADDING_LR_DEFAULT;
}

- (void)applySelectedStyle{

}

- (void)applyUnselectedStyle{

}

@end
