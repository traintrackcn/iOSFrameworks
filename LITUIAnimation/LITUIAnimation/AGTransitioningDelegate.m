//
//  AGMenuTransitionDelegate.m
//  AboveGEM
//
//  Created by traintrackcn on 4/12/14.
//
//

#import "AGTransitioningDelegate.h"
#import "AGAnimatedTransitioningSlideFromRight.h"

@interface AGTransitioningDelegate(){
   
}

@property (nonatomic, strong) id animatedTransitioning;



@end

@implementation AGTransitioningDelegate

//+ (instancetype)instanceWithAnimatedTranstioningClass:(Class)cls{
//    AGTransitioningDelegate *instance = [[self.class alloc] init];
//    [instance setAnimatedTransitioningCls:cls];
//    return instance;
//}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - properties

- (id)animatedTransitioning{
    if (!_animatedTransitioning){
        _animatedTransitioning = [[self.animatedTransitioningCls alloc] init];
        [_animatedTransitioning setViewController:self.viewController];
    }
    return _animatedTransitioning;
}

#pragma mark -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    [self.animatedTransitioning setIsPresenting:YES];
    return self.animatedTransitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    [self.animatedTransitioning setIsPresenting:NO];
    return self.animatedTransitioning;
}

@end
