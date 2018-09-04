//
//  LITImageButton.m
//  LITMonitor
//
//  Created by traintrackcn on 2018/6/20.
//  Copyright © 2018 abovegem. All rights reserved.
//

#import "LITImageButton.h"

@import LITUICommon;

@interface LITImageButton()



@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) NSTextAlignment alignment;

@property (nonatomic, strong) UIView *badgeV;

@end

@implementation LITImageButton


+ (instancetype)instanceWithFrame:(CGRect)frame image:(UIImage *)image imageSize:(CGSize)imageSize alignment:(NSTextAlignment)alignment{
    LITImageButton *instance = [[LITImageButton alloc] initWithFrame:frame];
    [instance setImgSize:imageSize];
    [instance setImg:image];
    [instance setAlignment:alignment];
    return instance;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.clipsToBounds = YES;
//    }
//    return self;
//}

- (void)setTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gr];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview){
        [self addSubview:self.imgV];
    }
}

- (void)setBadge:(BOOL)badge{
    _badge = badge;
    
    self.badgeV.hidden = !badge;
}


- (void)setImage:(UIImage *)image imageSize:(CGSize)imageSize{
    self.imgV.image = image;
    [self setAlignment];
}

- (void)setAlignment{
    CGFloat w = self.imgSize.width;
    CGFloat h = self.imgSize.height;
    CGFloat x = (self.frame.size.width - w)/2.0;
    CGFloat y = (self.frame.size.height - h)/2.0;
    
    if (self.alignment == NSTextAlignmentRight){
        x = self.frame.size.width - w;
    }else if (self.alignment == NSTextAlignmentLeft){
        x = 0;
    }
    
    self.imgV.frame = CGRectMake(x, y, w, h);
}

#pragma mark - components

- (UIImageView *)imgV{
    if (!_imgV) {
        CGFloat w = self.imgSize.width;
        CGFloat h = self.imgSize.height;
        CGFloat x = (self.frame.size.width - w)/2.0;
        CGFloat y = (self.frame.size.height - h)/2.0;
        
        if (self.alignment == NSTextAlignmentRight){
            x = self.frame.size.width - w;
        }else if (self.alignment == NSTextAlignmentLeft){
            x = 0;
        }
        
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
//        _imgV.layer.borderWidth = .5f;
        [_imgV setImage:self.img];
        
        
        CGFloat badgeW = self.badgeV.frame.size.width;
        CGFloat badgeH = self.badgeV.frame.size.height;
        CGFloat badgeX = w - badgeW/2.0;
        CGFloat badgeY = - badgeH/2.0;
        
        [_imgV addSubview:self.badgeV];
        self.badgeV.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    }
    return _imgV;
}


- (UIView *)badgeV{
    if (!_badgeV){
        
        CGFloat w = 12;
        CGFloat h = w;
        CGFloat x = 0;
        CGFloat y = 0;
        _badgeV = [[UIView alloc] init];
        _badgeV.frame = CGRectMake(x, y, w, h);
        _badgeV.layer.cornerRadius = w/2.0;
        _badgeV.clipsToBounds = YES;
        _badgeV.backgroundColor = COLOR(@"223,25,33");
        _badgeV.hidden = !self.badge;
    }
    return _badgeV;
}

@end
