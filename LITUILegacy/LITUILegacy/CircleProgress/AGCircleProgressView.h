//
//  AGCircleProgressView.h
//  AboveGEM
//
//  Created by traintrackcn on 28/12/14.
//
//

#import <UIKit/UIKit.h>

@interface AGCircleProgressView : UIView

- (void)assemble;
- (void)setProgress:(CGFloat)progress;
- (void)setImmediatelyProgress:(CGFloat)progress;

@property (nonatomic, assign) CGFloat outerThickness;
@property (nonatomic, assign) CGFloat innerThickness;
@property (nonatomic, assign) CGFloat textLabelH;
@property (nonatomic, assign) CGFloat statusLabelH;

@property (nonatomic, strong) UIColor *outerCompletedColor;
@property (nonatomic, strong) UIColor *outerIncompletedColor;

@property (nonatomic, strong) UIColor *innerCompletedColor;
@property (nonatomic, strong) UIColor *innerIncompletedColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) NSString *status;

@end
