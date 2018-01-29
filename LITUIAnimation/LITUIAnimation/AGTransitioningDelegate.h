//
//  AGMenuTransitionDelegate.h
//  AboveGEM
//
//  Created by traintrackcn on 4/12/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class AGViewController;
@interface AGTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

//+ (instancetype)instanceWithAnimatedTranstioningClass:(Class)cls;


@property (nonatomic, weak) id viewController;
@property (nonatomic, assign) Class animatedTransitioningCls;

@end
