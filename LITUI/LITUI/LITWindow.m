//
//  LITWindow.m
//  AGUIKit
//
//  Created by Tao Yunfei on 02/10/2017.
//  Copyright © 2017 AboveGEM. All rights reserved.
//

#import "LITWindow.h"

@implementation LITWindow

+ (instancetype)instanceWithRootVC:(UIViewController *)vc{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    LITWindow *w = [[LITWindow alloc] initWithFrame:frame];
    
    if ([vc isKindOfClass:[UINavigationController class]] ||
        [vc isKindOfClass:[UITabBarController class]]){
        [w setRootViewController:vc];
    }else{
        UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:vc];
        [w setRootViewController:naviC];
    }
    
    [w makeKeyAndVisible];
    return w;
}



@end
