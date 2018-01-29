//
//  AGMenuAnimatedTransitioning.m
//  AboveGEM
//
//  Created by traintrackcn on 4/12/14.
//
//

@import LITUICommon;

#import "AGAnimatedTransitioningSlideFromRight.h"
//#import "AGViewController.h"

@interface AGAnimatedTransitioningSlideFromRight(){
//    CGPoint presentingToVCenter;
}

@property (nonatomic, strong) UIView *ghostView;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation AGAnimatedTransitioningSlideFromRight

- (id)init{
    self = [super init];
    if (self) {
//        [self setWOfRootView:44.0];
    }
    return self;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        [self animationPresenting:transitionContext];
    }else{
        [self animationDismissing:transitionContext];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .33f;
}

- (void)animationEnded:(BOOL)transitionCompleted{
//    TLOG(@"transitionCompleted -> %d", transitionCompleted);
}


#pragma mark - properties

- (UIView *)ghostView{
    if (!_ghostView){
        CGRect bounds = [[UIScreen mainScreen] bounds];
        _ghostView = [[UIView alloc] init];
        [_ghostView setFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    }
    return _ghostView;
}


- (UIView *)maskView{
    if (!_maskView) {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        _maskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
        UITapGestureRecognizer *gc = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMask:)];
        [_maskView addGestureRecognizer:gc];
    }
    
    return _maskView;
}


#pragma mark - interactive ops

- (void)didTapMask:(id)sender{
//    TLOG(@"", self.viewController);
//    if ([self.viewController isKindOfClass:[UINavigationController class]]) {
//        [self.viewController popViewControllerAnimated:YES];
//    }else if([self.viewController isKindOfClass:[UIViewController class]]){
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
//    }

}

#pragma mark - ops

- (void)removeGhostView{
    if (_ghostView) {
        [_ghostView removeFromSuperview];
        _ghostView = nil;
    }
}

#pragma mark - animation details

- (void)presentingSetupForToV:(UIView *)toV{
    [toV setFrame:CGRectMake(STYLE_DEVICE_WIDTH, 0, self.presentingToVWidth, self.presentingToVHeight)];
//    [toV setCenter:CGPointMake(STYLE_DEVICE_WIDTH/2.0, STYLE_DEVICE_HEIGHT/2.0)];
//    [toV.layer setCornerRadius:8.0];
//    [toV.layer setBorderWidth:.5f];
//    [toV.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [toV setClipsToBounds:YES];
}

- (void)presentingSetupForMaskViewWithContainer:(UIView *)container fromV:(UIView *)fromV{
    [container insertSubview:self.maskView aboveSubview:fromV];
    [self.maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
}

- (void)presentingSetupForGhostViewWithContainer:(UIView *)container{
    UIImage *ghostViewBgImage = [DSImage imageWithTransformedView:container];
    [self.ghostView setBackgroundColor:[UIColor colorWithPatternImage:ghostViewBgImage]];
}

- (void)animationPresenting:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *fromV = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toV = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *container = [transitionContext containerView];
    
    [container addSubview:fromV];
    [container addSubview:toV];
    
    [self presentingSetupForToV:toV];
    [self presentingSetupForMaskViewWithContainer:container fromV:fromV];
    [self presentingSetupForGhostViewWithContainer:container];
    
//    TLOG(@"self.naviController.navigationBar -> %@", self.naviController.navigationBar);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [toV setFrame:self.presentingToVFrame];
        [self.maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:self.maskOpacity]];
        
        
        
        
    } completion:^(BOOL finished) {
//        [self presentingSetupForGhostViewWithContainer:container];
//        presentingToVCenter = toV.center;
        
        [container insertSubview:self.ghostView atIndex:0];
        [transitionContext completeTransition:finished];
        
        if ([DSDeviceUtil isNotIOS8AndAbove]){
            [fromV setHidden:YES];
        }
    }];
}


- (void)dismissingSetupForGhostView{
    [self removeGhostView];
}


- (void)animationDismissing:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    [self dismissingSetupForGhostView];
    
    UIView *fromV = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView *toV = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    UIView *container = [transitionContext containerView];
    

    [container insertSubview:toV belowSubview:fromV];
    [container insertSubview:self.maskView belowSubview:fromV];
    
//    TLOG(@"container subviews -> %@", container.subviews);
    [self.maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:self.maskOpacity]];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [fromV setFrame:CGRectMake(STYLE_DEVICE_WIDTH, 0, self.presentingToVWidth, self.presentingToVHeight)];

    } completion:^(BOOL finished) {
//        toV.layer.shouldRasterize = NO;
//        TLOG(@"finished -> %d", finished);
        [self.maskView removeFromSuperview];
        [transitionContext completeTransition:finished];
//        TLOG(@"container subviews -> %@", container.subviews);
    }];
}



#pragma mark - styles

- (CGFloat)maskOpacity{
    return .6f;
}

- (CGFloat)paddingLR{
    return 10.0;
}

- (CGFloat)presentingToVHeight{
    return STYLE_DEVICE_HEIGHT;
}

- (CGFloat)presentingToVWidth{
    return STYLE_DEVICE_WIDTH*(2.0/3.0);
}

//- (CGFloat)paddingTB{
//    return (STYLE_DEVICE_HEIGHT - ( STYLE_STATUS_BAR_HEIGHT + STYLE_NAVIGATION_BAR_HEIGHT) - self.presentingToVHeight)/2.0;
//}

- (CGRect)presentingToVFrame{
    CGFloat x = STYLE_DEVICE_WIDTH - self.presentingToVWidth;
    CGFloat h = self.presentingToVHeight;
    CGFloat y = 0;
    CGFloat w = self.presentingToVWidth;
    return CGRectMake(x, y, w, h);
}

@end
