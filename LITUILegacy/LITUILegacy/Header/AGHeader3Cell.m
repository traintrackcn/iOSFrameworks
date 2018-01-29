//
//  AGHeader3Cell.m
//  AboveGEM
//
//  Created by traintrackcn on 28/12/14.
//
//

@import LITUICommon;

#import "AGHeader3Cell.h"

@implementation AGHeader3Cell

+ (CGFloat)height{
    return 60;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [titleLabel setFont:FONT_WITH_SIZE(20.0)];
        [self setBackgroundColor:COLOR(@"249,248,224")];
    }
    return self;
}



#pragma mark -
- (void)setValue:(id)value{
    [super setValue:value];
}

@end
