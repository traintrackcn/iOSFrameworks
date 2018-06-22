//
//  LITImageButton.m
//  LITMonitor
//
//  Created by traintrackcn on 2018/6/20.
//  Copyright © 2018 abovegem. All rights reserved.
//

#import "LITImageButton.h"

@interface LITImageButton()



@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) NSTextAlignment alignment;

@end

@implementation LITImageButton


+ (instancetype)instanceWithFrame:(CGRect)frame image:(UIImage *)image imageSize:(CGSize)imageSize alignment:(NSTextAlignment)alignment{
    LITImageButton *instance = [[LITImageButton alloc] initWithFrame:frame];
    [instance setImgSize:imageSize];
    [instance setImg:image];
    [instance setAlignment:alignment];
    return instance;
}

- (void)setTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gr];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview){
        [self addSubview:self.imgV];
    }
}

#pragma mark - components

- (UIImageView *)imgV{
    if (!_imgV) {
        CGFloat w = self.imgSize.width;
        CGFloat h = self.imgSize.height;
        CGFloat x = (self.frame.size.width - w)/2.0;
        CGFloat y = (self.frame.size.height - w)/2.0;
        
        if (self.alignment == NSTextAlignmentRight){
            x = self.frame.size.width - w;
        }else if (self.alignment == NSTextAlignmentLeft){
            x = 0;
        }
        
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_imgV setImage:self.img];
        
//        _imgV.layer.borderWidth = 1;
//        self.layer.borderWidth = 1;
    }
    return _imgV;
}


@end
