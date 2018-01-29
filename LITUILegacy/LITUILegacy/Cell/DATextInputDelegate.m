//
//  DATextAreaDelegate.m
//  Distributors
//
//  Created by Tao Yunfei on 5/11/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

@import LITCommon;

#import "DATextInputDelegate.h"
#import "AGCell.h"
#import "AGCellAction.h"
//#import "GlobalDefine.h"

@interface DATextInputDelegate(){
    
}

@property (nonatomic, weak) UITableViewCell *cell;

@end

@implementation DATextInputDelegate

- (instancetype)initWithCell:(UITableViewCell *)cell{
    self = [super init];
    if (self) {
        [self setCell:cell];
    }
    return self;
}

#pragma mark - UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.cell endEditing:YES];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *text = textField.text;
    if (textField.textAlignment == NSTextAlignmentRight){
        text = [text stringByReplacingOccurrencesOfString:@"\u00a0" withString:@" "];
    }
    [self.cell setValueForViewController:text];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    TLOG(@"string -> %@", string);
    if (textField.textAlignment == NSTextAlignmentRight){
        if (range.location == textField.text.length && [string isEqualToString:@" "]) {
            // ignore replacement string and add your own
            textField.text = [textField.text stringByAppendingString:@"\u00a0"];
            return NO;
        }
    }
    // for all other cases, proceed with replacement
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self dispatchRequestSetValue:textView.text];
}

- (void)dispatchRequestSetValue:(id)value{
    [self.cell setValueForViewController:value];
}

@end
