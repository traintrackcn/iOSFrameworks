//
//  LITImageButton.h
//  LITMonitor
//
//  Created by traintrackcn on 2018/6/20.
//  Copyright © 2018 abovegem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LITImageButton : UIView

+ (instancetype)instanceWithFrame:(CGRect)frame image:(UIImage *)image imageSize:(CGSize)imageSize alignment:(NSTextAlignment)alignment;

- (void)setTarget:(id)target action:(SEL)action;
- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize;

@property (nonatomic, assign) BOOL badge;

@end
