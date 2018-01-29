//
//  AGPortraitView.m
//  AboveGEM
//
//  Created by Tao Yunfei on 4/10/15.
//
//

@import LITCommon;
@import LITUICommon;
@import LITNetwork;

#import "AGPortraitView.h"

@interface AGPortraitView(){
    
}

@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AGPortraitView

@synthesize borderColor = _borderColor;

+ (instancetype)instanceWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    AGPortraitView *instance = [[AGPortraitView alloc] initWithFrame:frame borderColor:borderColor borderWidth:borderWidth];
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBorderColor:borderColor];
        [self setBorderWidth:borderWidth];
        [self assemble];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self assemble];
    }
    return self;
}


- (void)dealloc{
    [_imageView cancelImageRequestOperation];
}

#pragma mark - ops

- (void)setImage:(UIImage *)img{
    [self.imageView setImage:img];
}

- (void)setImageWithText:(NSString *)text{
    
    if (!text) {
        [self setImage:self.defaultImage];
        return;
    }
    
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *firstLetter = [text substringToIndex:1];
    [self setFirstLetter:firstLetter];
    
    id textAttributes = @{
                          NSFontAttributeName:self.font,
                          NSForegroundColorAttributeName:self.textColor
                          };
    [self.imageView setImageWithString:text color:self.textBackgroundColor circular:YES textAttributes:textAttributes];
}

- (void)setUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
//    TLOG(@"url -> %@", url);
    [self.imageView cancelImageRequestOperation];
    
    
    
    [self.imageView setImageWithURL:url placeholderImage:[DSImage singleton].dummyImage];
    
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    [[UIImageView singleton] setImageWithURLRequest:req placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//        TLOG(@"image -> %@", image);
//    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//        TLOG(@"error -> %@", error);
//    }];
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [self.imageView setBackgroundColor:backgroundColor];
}

#pragma mark -

- (void)assemble{
    [self addSubview:self.circleView];
    [self addSubview:self.imageView];
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    if (_circleView){
        [_circleView setBackgroundColor:borderColor];
    }
}

#pragma mark - properties

- (UIImageView *)imageView{
    if (!_imageView) {
//        TLOG(@"self.borderWidth -> %f", self.borderWidth);
        CGFloat x = self.borderWidth;
        CGFloat y = x;
        CGFloat w = self.frame.size.width - x*2;
        CGFloat h = w;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView.layer setCornerRadius:w/2.0];
        [_imageView setClipsToBounds:YES];
        
        
        AFImageResponseSerializer *serializer = [[AFImageResponseSerializer alloc] init];
        serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"binary/octet-stream"];
        _imageView.imageResponseSerializer = serializer;
//        _imageView.layer.borderWidth = 1;
//        CGFloat r = w/2.0;
//        [AGStyleCoordinator decorateCircleMaskForView:_imageView radius:r];
        
//        [AGDebugUtil makeBorderForView:_imageView];
    }
    return _imageView;
}

- (UIView *)circleView{
    if (!_circleView) {
        CGFloat x = 0;
        CGFloat y = x;
        CGFloat w = self.frame.size.width;
        CGFloat h = w;
        _circleView = [[UIView alloc] init];
        
        CGRect frame = CGRectMake(x, y, w, h);
        [_circleView setFrame:frame];
        [_circleView setClipsToBounds:YES];
        [_circleView.layer setCornerRadius:w/2];
        [_circleView setBackgroundColor:_borderColor];
    }
    return _circleView;
}



#pragma mark - styles

- (UIColor *)borderColor{
    if (_borderColor) return _borderColor;
    return RGBA(138, 123, 119, 1);
}

- (CGFloat)borderWidth{
    if (_borderWidth) return _borderWidth;
    return 0;
}

- (UIColor *)textColor{
    return [UIColor whiteColor];
}

- (UIFont *)font{
    return [UIFont boldSystemFontOfSize:20.0];
}

- (UIImage *)defaultImage{
    return [DSImage singleton].dummyPortraitImage;
}

- (UIColor *)textBackgroundColor{
    return nil;
}

@end
