//
//  LITFormLongTitleTriggerCell.m
//  AboveGEM
//
//  Created by Tao Yunfei on 09/09/2017.
//
//

#import "LITTriggerCellFormLongValue.h"

@implementation LITTriggerCellFormLongValue

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier associatedVC:(id)associatedVC indexPath:(NSIndexPath *)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier associatedVC:associatedVC indexPath:indexPath];
    if (self) {
        [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)didTapAny:(id)sender{
    [self sendActionRequestToViewController:nil];
}

@end
