//
//  AGTopSeparatorCell.m
//  AboveGEM
//
//  Created by traintrackcn on 6/11/14.
//
//

#import "AGSeparatorCell.h"

@implementation AGSeparatorCell


+ (CGFloat)height{
    return 10.0f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView setBackgroundColor:[AGStyleCoordinator colorBackgroundNormal]];
    }
    return self;
}

- (void)applySelectedStyle{
    
}

- (void)applyUnselectedStyle{
    [self setBackgroundColor:[UIColor clearColor]];
}

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    CGContextRef ctx =  UIGraphicsGetCurrentContext();
//    CGPoint start = CGPointMake(0, [self.class height]-1);
//    CGPoint end = CGPointMake(self.frame.size.width, start.y);
//    CGFloat lineWidth = 2.0f;
//    UIColor *lineColor = [UIColor grayColor];
//    [DSDraw drawLine:ctx startPoint:start endPoint:end strokeColor:lineColor lineWidth:lineWidth];
//}

@end
