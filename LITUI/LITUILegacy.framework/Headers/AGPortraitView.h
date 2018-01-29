//
//  AGPortraitView.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/10/15.
//
//

#import <UIKit/UIKit.h>

@interface AGPortraitView : UIView

+ (instancetype)instanceWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


- (void)setImage:(UIImage *)img;
- (void)setImageWithText:(NSString *)text;
- (void)setUrl:(NSString *)urlStr;
//- (void)setBackgroundColor:(UIColor *)backgroundColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) NSString *firstLetter;

- (UIColor *)textColor;
- (UIColor *)textBackgroundColor;
- (UIFont *)font;
- (UIImage *)defaultImage;






@end
