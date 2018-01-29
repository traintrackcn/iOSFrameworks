//
//  AGTrasnparentTextfieldCell.h
//  AboveGEM
//
//  Created by traintrackcn on 8/12/14.
//
//

#import "AGTextfieldCell.h"

@interface AGFancyTextfieldCell : AGCell{
//    CGFloat iconW;
    
}

- (UIColor *)contentColor;
- (UIColor *)placeholderColor;
- (UIColor *)iconColor;
- (CGFloat)iconW;

- (void)setIconByName:(NSString *)iconName;

@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, assign) CGFloat separatorH;

@end
