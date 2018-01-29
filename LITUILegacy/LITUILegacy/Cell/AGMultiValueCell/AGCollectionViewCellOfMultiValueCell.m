//
//  AGCollectionViewCellMultiValueUnit.m
//  AboveGEM
//
//  Created by traintrackcn on 4/1/15.
//
//

@import LITCommon;

#import "AGCollectionViewCellOfMultiValueCell.h"
#import "AGCollectionViewCellValue.h"
#import "AGMultiValueCellLabel.h"
//#import "DSValueUtil.h"
//#import "GlobalDefine.h"


@interface AGCollectionViewCellOfMultiValueCell(){
    AGMultiValueCellLabel *textLabel;
}

@end

@implementation AGCollectionViewCellOfMultiValueCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self assembleTextLabel];
//        [self setBackgroundColor:[AGStyleCoordinator colorBackgroundNormal]];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


#pragma mark - assemblers

- (void)assembleTextLabel{
    if ([DSValueUtil isAvailable:textLabel]) return;
//    CGFloat spacing = 4.0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.frame.size.width ;
    CGFloat h = self.frame.size.height;
    textLabel = [[AGMultiValueCellLabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [textLabel setNumberOfLines:0];
    [textLabel setFont:self.textFont];
    //    [titleL setLineBreakMode:NSLineBreakByWordWrapping];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setAdjustsFontSizeToFitWidth:YES];
    [textLabel setTextColor:RGBA(96, 96, 96, 1)];
    [self.contentView addSubview:textLabel];
    
//    [AGDebugUtil makeBorderForView:textLabel];
}

#pragma mark - properties

- (UIFont *)textFont{
    return [UIFont systemFontOfSize:12];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    [textLabel setTextAlignment:textAlignment];
}

- (void)decorateValueLabelsAsHeaders{
    [textLabel setFont:[UIFont systemFontOfSize:13.0]];
    [textLabel setTextColor:RGBA(186, 170, 162, 1)];
}


#pragma mark -

- (void)setValue:(id)value{
    [super setValue:value];
    if (![value isKindOfClass:[AGCollectionViewCellValue class]]) return;
    AGCollectionViewCellValue *item = (AGCollectionViewCellValue *)value;
    [textLabel setTextAlignment:item.textAlignment];
    [textLabel setText:[DSValueUtil toString:item.value]];
}

@end
