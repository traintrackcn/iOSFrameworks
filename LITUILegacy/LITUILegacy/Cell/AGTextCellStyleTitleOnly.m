//
//  AGTextCellStyleTitleOnly.m
//  AboveGEM
//
//  Created by traintrackcn on 6/11/14.
//
//

@import LITCommon;

#import "AGTextCellStyleTitleOnly.h"
//#import "DSValueUtil.h"
//#import "DSDeviceUtil.h"

@interface AGTextCellStyleTitleOnly(){
    UILabel *_textLabel;
}

@end

@implementation AGTextCellStyleTitleOnly

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setFont:self.detailTextLabel.font];
    }
    return self;
}

- (void)setValue:(id)value{
    NSString *text = [DSValueUtil toString:value];
    [self.textLabel setText:text];
}

#pragma mark - components

- (UILabel *)textLabel{
    if (!_textLabel) {
        CGFloat x = self.paddingLR;
        CGFloat y = 0;
        CGFloat h = self.height;
        CGFloat w = [DSDeviceUtil bounds].size.width - x*2;
        _textLabel = [super textLabel];
        [_textLabel setFrame:CGRectMake(x, y, w, h)];
    }
    return _textLabel;
}

@end
