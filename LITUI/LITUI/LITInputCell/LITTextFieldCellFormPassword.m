//
//  LITTextFieldCellFormPassword.m
//  AboveGEM
//
//  Created by Tao Yunfei on 22/09/2017.
//
//

#import "LITTextFieldCellFormPassword.h"

@implementation LITTextFieldCellFormPassword

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
//        TLOG(@"textF -> %@", self.textF);
        [self.textF setSecureTextEntry:YES];
    }
    return self;
}

@end
