//
//  AGCellInnerView.h
//  AboveGEM
//
//  Created by Tao Yunfei on 6/24/15.
//
//

#import <UIKit/UIKit.h>

@interface AGCellInnerView : UIView


- (CGFloat)paddingLR;
- (UIColor *)borderColor;
- (CGFloat)borderWidth;
- (CGFloat)height;
- (CGFloat)width;
- (void)assemble;

- (UIView *)borderViewInstance;

@property (nonatomic, strong) id value;

@end
