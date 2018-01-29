//
//  AGTextfieldCellStylNumber.m
//  AboveGEM
//
//  Created by traintrackcn on 13/11/14.
//
//

#import "AGTextfieldCellStyleNumber.h"

@implementation AGTextfieldCellStyleNumber

- (void)assembleInputField{
    [super assembleInputField];
//    [self.inputField setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)]];
//    [self.inputField setLeftViewMode:UITextFieldViewModeAlways];
//    [self.inputField setTextAlignment:NSTextAlignmentLeft];
//    [self.inputField.layer setBorderWidth:1.0];
    
    [self enableNumberPadForInputField];
    
    //accessory view
    
    
}

@end
