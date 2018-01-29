//
//  AGTextBox.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/22/15.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGTextBoxCell.h"

@interface AGTextBoxCell(){
    UILabel *_textLabel;
}

@property (nonatomic, strong) UITextView *textView;

@end

@implementation AGTextBoxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textView];
    }
    return self;
}



#pragma mark - 

- (void)setValue:(id)value{
    NSString *text = [DSValueUtil toString:value];
    [self.textView setText:text];
}

#pragma mark - styles

- (void)applySelectedStyle{
    
}

+ (CGFloat)height{
    return 160;
}

- (CGFloat)textViewY{
    return 44.0;
}

- (CGFloat)paddingTB{
    return 16.0;
}

#pragma mark - properties

- (UILabel *)textLabel{
    if (!_textLabel) {
        
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat w = [DSDeviceUtil bounds].size.width-self.paddingLR*2;
        CGFloat h = self.textViewY;
        
        _textLabel = [super textLabel];
        [_textLabel setFrame:CGRectMake(x, y, w, h)];
    }
    return _textLabel;
}

- (UITextView *)textView{
    if (!_textView) {
        CGFloat x = self.paddingLR;
        CGFloat y = self.textViewY;
        CGFloat w = [DSDeviceUtil bounds].size.width - self.paddingLR*2;
        CGFloat h = [self.class height] - self.textViewY - self.paddingTB;
        CGRect frame = CGRectMake(x, y, w, h);
        _textView = [[UITextView alloc] initWithFrame:frame];
        [_textView setDelegate:nil];
        [_textView setEditable:NO];
//        [_textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_textView setTextColor:COLOR(AGUI.RGB_TITLE_NORMAL)];
        
        [_textView.layer setBorderWidth:1.0];
        [_textView.layer setBorderColor:COLOR(AGUI.RGB_CELL_BORDER).CGColor];
    }
    return _textView;
}


@end
