//
//  AGFormKeyboardInput.h
//  AboveGEM
//
//  Created by traintrackcn on 11/7/14.
//  Copyright (c) 2014 2ViVe. All rights reserved.
//

#import "AGCell.h"


@interface AGTextfieldCell : AGCell <UITextFieldDelegate, UITextViewDelegate>{
//    UIView *titleContainer;
    UILabel *titleLabel;
    UILabel *starLabel;
    UIView *inputView;
//    CGFloat titleMaxH;
}

- (UITextField *)inputField;
//- (UITextView *)inputBox;
- (CGRect)inputFieldFrame;

#pragma mark - assemblers
//- (void)assembleTitleContainer;
- (void)assembleTitleView;
- (void)assembleInputView;
- (void)assembleInputField;

- (BOOL)inputIsBox;

- (void)enableNumberPadForInputField;
- (void)enableNumberAndPunctuationPadForInputField;

- (void)layoutInputField;

@property (nonatomic, assign) CGFloat titleMaxH;

@end
