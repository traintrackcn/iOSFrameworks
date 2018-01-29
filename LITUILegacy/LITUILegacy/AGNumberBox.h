//
//  AGDashboardNextComponentNumberBox.h
//  AboveGEM
//
//  Created by Tao Yunfei on 4/27/15.
//
//

#import <UIKit/UIKit.h>

@interface AGNumberBox : UIView

@property (nonatomic, strong) id value;

- (UIColor *)subtitleColor;
- (UIFont *)subtitleFont;
- (CGFloat)subtitleH;
- (UIColor *)numberColor;
- (UIFont *)numberFont;
- (CGFloat)numberH;

@end
