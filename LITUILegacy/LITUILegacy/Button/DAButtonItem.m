//
//  DAButtonItem.m
//  Distributors
//
//  Created by Tao Yunfei on 1/5/16.
//  Copyright © 2016 AboveGEM. All rights reserved.
//

#import "DAButtonItem.h"

@implementation DAButtonItem

+ (instancetype)instanceWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    DAButtonItem *item = [[self.class alloc] init];
    [item setTitle:title];
    [item setTarget:target];
    [item setAction:action];
    return item;
}

+ (instancetype)instanceWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color target:(id)target action:(SEL)action{
    DAButtonItem *item = [[self.class alloc] init];
    [item setTitle:title];
    [item setTarget:target];
    [item setAction:action];
    [item setIcon:icon];
    [item setColor:color];
    return item;
}

@end
