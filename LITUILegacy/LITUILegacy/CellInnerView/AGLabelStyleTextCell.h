//
//  AGLabelStyleTextCell.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/27/15.
//
//

#import "AGCellInnerView.h"

@interface AGLabelStyleTextCell : AGCellInnerView

//+ (CGFloat)height;

- (void)setTitle:(NSString *)title;

- (UIFont *)textFont;
- (UIFont *)detailTextFont;
- (UIColor *)textColor;
- (UIColor *)detailTextColor;
- (UIColor *)borderColor;
- (CGFloat)borderWidth;


@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailTextLabel;
@property (nonatomic, strong) UIView *borderBottomView;

@property (nonatomic, assign) BOOL borderEnabled;

@property (nonatomic, assign) CGFloat textLabelWidthPercentage;

@end
