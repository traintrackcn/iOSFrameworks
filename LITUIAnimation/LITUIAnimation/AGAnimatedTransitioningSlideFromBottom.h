//
//  AGMenuAnimatedTransitioning.h
//  AboveGEM
//
//  Created by traintrackcn on 4/12/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AGAnimatedTransitioningSlideFromBottom : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) CGFloat presentationDuration;
@property (nonatomic, assign) CGFloat dismissalDuration;

@property (nonatomic, weak) id viewController;


- (CGFloat)presentingToVHeight;
- (CGFloat)presentingToVWidth;

@end
