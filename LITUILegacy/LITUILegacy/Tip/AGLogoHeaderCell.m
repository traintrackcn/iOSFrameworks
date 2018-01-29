//
//  AGBigHeaderCell.m
//  AboveGEM
//
//  Created by traintrackcn on 8/12/14.
//
//

@import LITCommon;
@import LITUICommon;

#import "AGLogoHeaderCell.h"

@interface AGLogoHeaderCell(){
    UILabel *titleLabel;
}

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation AGLogoHeaderCell

+ (CGFloat)height{
    return 92;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self assembleTitleView];
        
        [self.contentView addSubview:self.logoView];
    }
    return self;
}

#pragma mark - components

- (UIImageView *)logoView{
    if (!_logoView) {
        CGFloat w = [DSDeviceUtil bounds].size.width;
        CGFloat h = self.height;
        _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
        [_logoView setContentMode:UIViewContentModeScaleAspectFit];
        
        [_logoView setImage:[UIImage imageNamed:@"Logo"]];
    }
    return _logoView;
}

#pragma mark -

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    
}

- (void)assembleTitleView{
    
    CGRect bounds = [DSDeviceUtil bounds];
    //    CGFloat titleH = 40;
    CGFloat x = self.paddingLR;
    CGFloat w = bounds.size.width-x*2;
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w ,self.class.height)];
    
//    [titleLabel setFont:[AGStyleCoordinator fontLoginHeaderCell]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
//    [titleLabel setAdjustsFontSizeToFitWidth:YES];
//    [AGDebugUtil makeBorderForView:titleLabel];
    //    [titleLabel setBackgroundColor:[UIColor redColor]];
//        [titleLabel.layer setBorderWidth:1.0];
 
    
    CALayer *layer = titleLabel.layer;
    [layer setShadowColor:[[UIColor blackColor] CGColor]];
    [layer setShouldRasterize:YES];
    [layer setShadowRadius:3];
    [layer setShadowOffset:CGSizeMake(0, 0)];
    [layer setShadowOpacity:.7];
    
//    layer.shadowPath = [UIBezierPath bezierPathWithRect:titleLabel.bounds].CGPath;
    
    [self.contentView addSubview:titleLabel];
}

- (void)setValue:(id)value{
    
    if (![value isKindOfClass:[NSString class]]) return;
//    NSString *key = @"\\n";
//    NSString *text = [value stringByReplacingOccurrencesOfString:key withString:@"\n"];
    NSString *text = [value stringByReplacingBackslashN];
//    TLOG(@"text -> %@", text);
    
    NSInteger brIdx = [text rangeOfString:@"\n"].location;
    NSArray *textArr = [text componentsSeparatedByString:@"\n"];
    NSString *subtitle = textArr.lastObject;
//    TLOG(@"brIdx -> %d", brIdx);
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor whiteColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:30]
                              };
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:attribs];
    
    [attributedText setAttributes:@{
                                    NSFontAttributeName: FONT_WITH_SIZE(16)
                                    } range:NSMakeRange(brIdx, subtitle.length+1)];
    
    
    [titleLabel setAttributedText:attributedText];
//    [titleLabel setText:text];
//    [titleLabel setText:@"sdf\ndsf"];
}

@end
