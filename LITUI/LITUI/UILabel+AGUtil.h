//
//  UILabel+AGUtil.h
//  AboveGEM
//
//  Created by Tao Yunfei on 5/21/15.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (AGUtil)

- (void)setText:(NSString *)text withTextColor:(UIColor *)textColor exceptTitle:(NSString *)title;
- (void)setText:(NSString *)text withColor:(UIColor *)color font:(UIFont *)font exceptTitle:(NSString *)title;
- (void)setTextArr:(NSArray *)arr lastObjectWithColor:(UIColor *)color font:(UIFont *)font;
- (void)setTextArr:(NSArray *)arr lastObjectWithColor:(UIColor *)color;
- (void)setTextArr:(NSArray *)arr lastObjectWithFont:(UIFont *)font;


- (void)resizeWithMaxSize:(CGSize)maxSize;
- (void)resizeNormalTextWithMaxSize:(CGSize)maxSize;

- (void)moveTo:(CGPoint)pos;

- (void)applyShadow;


- (void)setUnderlineForText:(NSString *)text underlineStyle:(NSUnderlineStyle)underlineStyle underlineColor:(UIColor *)underlineColor textColor:(UIColor *)textColor;

@end
