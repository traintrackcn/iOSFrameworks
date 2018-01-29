//
//  AGTextfieldCellStylePassword.m
//  AboveGEM
//
//  Created by traintrackcn on 8/11/14.
//
//

#import "AGTextfieldCellStylePassword.h"
#import "NSObject+TextInputComponents.h"

@implementation AGTextfieldCellStylePassword

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.inputField setSecureTextEntry:YES];
        [self.inputField setDelegate:self.textInputDelegate];
    }
    return self;
}

@end
