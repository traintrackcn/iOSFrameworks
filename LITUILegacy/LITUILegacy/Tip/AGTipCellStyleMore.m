//
//  AGTipCellStyleMore.m
//  AboveGEM
//
//  Created by traintrackcn on 13/1/15.
//
//

#import "AGTipCellStyleMore.h"

@implementation AGTipCellStyleMore

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end
