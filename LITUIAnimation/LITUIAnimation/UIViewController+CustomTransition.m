//
//  UIViewController+CustomTransition.m
//  Distributors
//
//  Created by Tao Yunfei on 5/12/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "UIViewController+CustomTransition.h"
#import "AGTransitioningDelegate.h"

@implementation UIViewController (CustomTransition)


- (void)applyCustomTransition:(Class)animatedTransitioningCls{
    if(![self transitioningDelegate]){
        AGTransitioningDelegate *delegate = [[AGTransitioningDelegate alloc] init];
        [delegate setViewController:self];
        [delegate setAnimatedTransitioningCls:animatedTransitioningCls];
        [self setTransitioningDelegate:delegate];
    }
}

@end
