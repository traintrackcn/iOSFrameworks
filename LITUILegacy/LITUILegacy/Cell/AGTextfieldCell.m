//
//  AGFormKeyboardInput.m
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

@import LITCommon;
@import LITUICommon;

#import "AGTextfieldCell.h"
#import "NSObject+TextInputComponents.h"

@interface AGTextfieldCell() {
//    id obUIKeyboardWillShowNotification;
    
}

@end

@implementation AGTextfieldCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assembleTitleView];
        [self assembleInputView];
        [self.contentView addSubview:self.borderBottomViewStylePaddingL];
    }
    return self;
}



#pragma mark - assemblers


- (void)assembleTitleView{
    if (titleLabel) return;
//    CGFloat w = self.frame.size.width/3.0;
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:FONT_WITH_SIZE(16)];
    [titleLabel setTextColor:COLOR(UI.RGB_INPUT_TITLE)];
    [titleLabel setNumberOfLines:2];
    [titleLabel setAdjustsFontSizeToFitWidth:YES];
    
//    [titleLabel.layer setBorderWidth:1.0];
    [self.contentView addSubview:titleLabel];
}

- (void)assembleStarView{
    if (!starLabel) {
        starLabel= [[UILabel alloc] init];
        UIFont *f = [UIFont boldSystemFontOfSize:24.0];
        [starLabel setText:@"*"];
        [starLabel setTextColor:COLOR(UI.RGB_INPUT_STAR)];
        [starLabel setFont:f];
        [self.contentView addSubview:starLabel];
    }
}

- (void)removeStarView{
    if (starLabel) {
        [starLabel removeFromSuperview];
        starLabel = nil;
    }
}



#pragma mark - components

- (void)assembleInputView{
    if ([DSValueUtil isAvailable:inputView]) return;
    
    if (self.inputIsBox) {
        [self assembleInputBox];
    }else{
        [self assembleInputField];
    }
    
//    [inputView setBackgroundColor:RGBA(242, 242, 242, 1)];
//    [inputView.layer setBorderWidth:1.0];
    [self.contentView addSubview:inputView];
    
}

- (void)assembleInputBox{
    CGFloat x = self.paddingLR;
    CGFloat y = self.titleMaxH;
    CGFloat w = self.frame.size.width - self.paddingLR*2;
    CGFloat h = [self.class height] - self.titleMaxH;
    CGRect frame = CGRectMake(x, y, w, h);
    inputView = [[UITextView alloc] initWithFrame:frame];
    [self.inputBox setDelegate:self];
    [self.inputBox setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.inputBox setTextColor:COLOR(UI.RGB_INPUT_NORMAL)];
    
    [self.inputBox.layer setBorderWidth:1.0];
    [self.inputBox.layer setBorderColor:COLOR(UI.RGB_CELL_BORDER).CGColor];
    [self.inputBox setFont:FONT_WITH_SIZE(16)];
    [self.inputBox setDelegate:self.textInputDelegate];
//    [AGDebugUtil makeBorderForView:inputView];
//    TLOG(@"", <#__args...#>)
}


- (void)assembleInputField{
    
    
    inputView = [[UITextField alloc] init];
    [self.inputField setDelegate:self];
    [self.inputField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
//    [self.inputField setRightView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 8)]];
//    [self.inputField setRightViewMode:UITextFieldViewModeAlways];
    [self.inputField setTextAlignment:NSTextAlignmentRight];
    [self.inputField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.inputField setTextColor:COLOR(UI.RGB_INPUT_NORMAL)];
    [self.inputField setAdjustsFontSizeToFitWidth:YES];
    [self.inputField.layer setBorderColor:COLOR(UI.RGB_CELL_BORDER).CGColor];
    [self.inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
//    [self.inputField.layer setBorderWidth:1.0];
    [self.inputField setFont:FONT_WITH_SIZE(16)];
    [self.inputField setDelegate:self.textInputDelegate];
}

- (void)enableNumberPadForInputField{
    [self.inputField setKeyboardType:UIKeyboardTypeNumberPad];
    [self appendNumberPadToolbar];
}

- (void)enableNumberAndPunctuationPadForInputField{
    [self.inputField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [self appendNumberPadToolbar];
}

- (void)appendNumberPadToolbar{
    UIToolbar  *numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [DSDeviceUtil bounds].size.width, 50)];
    numberToolbar.items = [NSArray arrayWithObjects:
                           //                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad:)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(didTapDoneNumberPad:)],
                           //                           [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapDone:)],
                           nil];
    [self.inputField setInputAccessoryView:numberToolbar];
}

#pragma mark - interactive actions

- (void)didTapDoneNumberPad:(id)sender{
    [self.inputField endEditing:YES];
}


#pragma mark - layout

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutTitleView];
    [self layoutStarView];
    [self layoutInput];
}


- (CGRect)inputFieldFrame{
    CGFloat x = 0;
    
    if ([DSValueUtil isAvailable:starLabel]){
        x = starLabel.frame.size.width + starLabel.frame.origin.x + self.spacing;
    }else{
        x = titleLabel.frame.size.width + titleLabel.frame.origin.x + self.spacing;
    }
    
    CGFloat y = 0;
    CGFloat w = self.frame.size.width - x - self.paddingLR;
    CGFloat h = [self.class height];
    
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator){
        w -= 14;
    }
    
    return CGRectMake(x, y, w, h);
}

- (void)layoutInput{
    if (self.inputIsBox){
        [self layoutInputBox];
    }else{
        [self layoutInputField];
    }
}

- (void)layoutInputField{
    [self.inputField setFrame:self.inputFieldFrame];
}

- (void)layoutTitleView{
    if (self.inputIsBox){
        [self layoutTitleViewForInputBox];
    }else{
        [self layoutTitleViewForInputField];
    }
}

- (void)layoutTitleViewForInputBox{
    
//    CGFloat h = titleMaxH;
    CGSize titleMaxSize = CGSizeMake(self.frame.size.width, self.titleMaxH);
    CGSize titleSize = [titleLabel.text boundingRectWithSize:titleMaxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin attributes:
                        @{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    CGRect titleFrame = titleLabel.frame;
    CGFloat y = (self.titleMaxH - titleSize.height)/2.0;
    titleFrame.origin = CGPointMake(self.paddingLR, y);
    titleFrame.size = CGSizeMake(titleSize.width, titleSize.height);
    [titleLabel setFrame:titleFrame];
    
    
    
}

- (void)layoutInputBox{
//    return;
    CGRect titleFrame = titleLabel.frame;
    CGSize titleSize = titleFrame.size;
    CGFloat paddingBottom = (self.titleMaxH - titleSize.height)/2.0;
    //resize input box
    CGFloat inputBoxW = self.frame.size.width - self.paddingLR *2;
    CGFloat inputBoxH = [self.class height] - self.titleMaxH - paddingBottom;
    CGRect inputBoxFrame = self.inputBox.frame;
    inputBoxFrame.size = CGSizeMake(inputBoxW, inputBoxH);
//    TLOG(@"inputBoxFrame -> %@", NSStringFromCGRect(inputBoxFrame));
    [self.inputBox setFrame:inputBoxFrame];
}

- (void)layoutTitleViewForInputField{
    
    CGSize titleMaxSize;
    
    if ([self.class height] > self.titleMaxH){
        titleMaxSize = CGSizeMake(self.frame.size.width-self.paddingLR*2, self.titleMaxH);
    }else{
        titleMaxSize = CGSizeMake((self.frame.size.width-self.paddingLR*2)/2, self.titleMaxH);
    }
    
    CGSize titleSize = [titleLabel.text boundingRectWithSize:titleMaxSize
                                                     options:NSStringDrawingUsesLineFragmentOrigin attributes:
                        @{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
//    TLOG(@"titleMaxSize -> %@ titleSize -> %@", NSStringFromCGSize(titleMaxSize), NSStringFromCGSize(titleSize));
    
    CGRect titleFrame = titleLabel.frame;
    titleFrame.origin = CGPointMake(self.paddingLR, (self.titleMaxH - titleSize.height)/2.0);
    titleFrame.size = titleSize;
    [titleLabel setFrame:titleFrame];
//    [titleLabel.layer setBorderWidth:1.0];
}

- (void)layoutStarView{
    
    CGRect titleFrame = titleLabel.frame;
    CGRect starFrame = CGRectMake(titleFrame.origin.x + titleFrame.size.width + self.spacing, titleFrame.origin.y + self.spacing, 10, titleFrame.size.height);
    [starLabel setFrame:starFrame];
    
//    [starLabel.layer setBorderWidth:1.0];
}

#pragma mark - properties

- (UITextField *)inputField{
    return (UITextField *)inputView;
}

- (UITextView *)inputBox{
    return (UITextView *)inputView;
}

- (BOOL)inputIsBox{
    return NO;
}


- (void)setTitle:(NSString *)title{
//    TLOG(@"title -> %@", title);
    [super setTitle:title];
    [titleLabel setText:title];
}

- (void)setPlaceholder:(NSString *)placeholder{
    [self.inputField setPlaceholder:placeholder];
}

- (void)setValue:(id)value{
    [super setValue:value];
    [self.inputField setText:[DSValueUtil toString:value]];
}

- (void)setIsOptional:(BOOL)isOptional{
    if (isOptional){
        [self removeStarView];
    }else{
        [self assembleStarView];
    }
}

- (void)setIsAdvanced:(BOOL)isAdvanced{
    // display more options icon
}




#pragma mark - styles

- (void)applySelectedStyle{
    
}


- (CGFloat)titleMaxH{
    return 44.0;
}

- (CGFloat)spacing{
    return 4.0;
}

- (CGFloat)paddingLR{
    return 15.0;
}

@end
